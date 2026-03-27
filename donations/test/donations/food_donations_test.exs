defmodule Donations.FoodDonationsTest do
  use Donations.DataCase

  alias Donations.FoodDonations

  describe "donations" do
    alias Donations.FoodDonations.Donation

    import Donations.FoodDonationsFixtures

    @invalid_attrs %{item: nil, emoji: nil, quantity: nil, days_until_expires: nil}

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert FoodDonations.list_donations() == [donation]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert FoodDonations.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      valid_attrs = %{item: "some item", emoji: "some emoji", quantity: 42, days_until_expires: 42}

      assert {:ok, %Donation{} = donation} = FoodDonations.create_donation(valid_attrs)
      assert donation.item == "some item"
      assert donation.emoji == "some emoji"
      assert donation.quantity == 42
      assert donation.days_until_expires == 42
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodDonations.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()
      update_attrs = %{item: "some updated item", emoji: "some updated emoji", quantity: 43, days_until_expires: 43}

      assert {:ok, %Donation{} = donation} = FoodDonations.update_donation(donation, update_attrs)
      assert donation.item == "some updated item"
      assert donation.emoji == "some updated emoji"
      assert donation.quantity == 43
      assert donation.days_until_expires == 43
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodDonations.update_donation(donation, @invalid_attrs)
      assert donation == FoodDonations.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = FoodDonations.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> FoodDonations.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = FoodDonations.change_donation(donation)
    end
  end
end
