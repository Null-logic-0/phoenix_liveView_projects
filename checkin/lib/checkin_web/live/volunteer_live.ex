defmodule CheckinWeb.VolunteerLive do
  use CheckinWeb, :live_view

  alias Checkin.Volunteers
  alias CheckinWeb.VolunteerFormComponent

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Volunteers.subscribe()
    end

    volunteers = Volunteers.list_volunteers()

    socket =
      socket
      |> stream(:volunteers, volunteers)
      |> assign(:count, length(volunteers))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1 class="text-center font-bold text-3xl">Volunteer Check-In</h1>
      <div id="volunteer-checkin">
        <.live_component module={VolunteerFormComponent} id={:new} count={@count}/>
        <div id="volunteers" phx-update="stream">
          <.volunteer :for={{volunteer_id, volunteer} <- @streams.volunteers}
            volunteer={volunteer}
            id={volunteer_id}
          />
        </div>
      </div>
    </Layouts.app>
    """
  end

  def volunteer(assigns) do
    ~H"""
    <div

      id={@id}
      class={"volunteer #{if @volunteer.checked_out, do: "out"}"}
    >
      <div class="name">
        {@volunteer.name}
      </div>
      <div class="phone">
        {@volunteer.phone}
      </div>

      <.button phx-click="toggle-status" phx-value-id={@volunteer.id} class="btn btn-secondary">
        {if @volunteer.checked_out, do: "Check In", else: "Check Out"}
      </.button>

      <.link
          phx-click="delete"
          phx-value-id={@volunteer.id}
          data-confirm="Are you sure?"
          class="delete">
        <.icon name="hero-trash-solid" />
      </.link>
    </div>
    """
  end

  def handle_event("delete", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    {:ok, _} = Volunteers.delete_volunteer(volunteer)

    socket =
      socket
      |> put_flash(:info, "Volunteer successfully deleted!")

    {:noreply, socket}
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} =
      Volunteers.update_volunteer(volunteer, %{checked_out: !volunteer.checked_out})

    {:noreply, socket}
  end

  def handle_info({:volunteer_created, volunteer}, socket) do
    socket =
      socket
      |> update(:count, &(&1 + 1))
      |> stream_insert(:volunteers, volunteer, at: 0)
      |> put_flash(:info, "Volunteer successfully checked in!")

    {:noreply, socket}
  end

  def handle_info({:volunteer_updated, volunteer}, socket) do
    {:noreply, stream_insert(socket, :volunteers, volunteer)}
  end

  def handle_info({:volunteer_deleted, volunteer}, socket) do
    socket = update(socket, :count, &(&1 - 1))
    {:noreply, stream_delete(socket, :volunteers, volunteer)}
  end
end
