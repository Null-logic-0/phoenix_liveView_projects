defmodule CheckinWeb.VolunteerLive do
  use CheckinWeb, :live_view

  alias Checkin.Volunteers
  alias Checkin.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    volunteers = Volunteers.list_volunteers()

    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket =
      socket
      |> stream(:volunteers, volunteers)
      |> assign(form: to_form(changeset))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1 class="text-center font-bold text-3xl">Volunteer Check-In</h1>
      <div id="volunteer-checkin">
        <.form for={@form} phx-submit="save" phx-change="validate">
          <.input field={@form[:name]} placeholder="Name" phx-debounce="500" />
          <.input field={@form[:phone]} type="tel" placeholder="Phone" phx-debounce="blur" />
          <.button phx-disable-with="Saving...">
            Check in
          </.button>
        </.form>
        <div id="volunteers" phx-update="stream">
          <div
            :for={{volunteer_id, volunteer} <- @streams.volunteers}
            id={volunteer_id}
            class={"volunteer #{if volunteer.checked_out, do: "out"}"}
          >
            <div class="name">
              {volunteer.name}
            </div>
            <div class="phone">
              {volunteer.phone}
            </div>

            <.button phx-click="toggle-status" phx-value-id={volunteer.id} class="btn btn-secondary">
              {if volunteer.checked_out, do: "Check In", else: "Check Out"}
            </.button>

            <.link
                phx-click="delete"
                phx-value-id={volunteer.id}
                data-confirm="Are you sure?"
                class="delete">
              <.icon name="hero-trash-solid" />
            </.link>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  def handle_event("delete", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    {:ok, _} = Volunteers.delete_volunteer(volunteer)

    socket =
      socket
      |> stream_delete(:volunteers, volunteer)
      |> put_flash(:info, "Volunteer successfully deleted!")

    {:noreply, socket}
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, volunteer} =
      Volunteers.update_volunteer(volunteer, %{checked_out: !volunteer.checked_out})

    {:noreply, stream_insert(socket, :volunteers, volunteer)}
  end

  def handle_event("validate", %{"volunteer" => volunteer_params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(volunteer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("save", %{"volunteer" => volunteer_params}, socket) do
    case Volunteers.create_volunteer(volunteer_params) do
      {:ok, volunteer} ->
        socket =
          socket
          |> stream_insert(:volunteers, volunteer, at: 0)
          |> put_flash(:info, "Volunteer successfully checked in!")

        changeset = Volunteers.change_volunteer(%Volunteer{})
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
