class GuestChoicesController < ApplicationController
  skip_before_action :authenticate_user!

  def find_rsvp
    if params[:query].present?
      @guest = Guest.find_by("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def index
    @guest = Guest.find(params[:guest_id])
  end

  def new
    @user = current_user
    @event = @user.events.first
    @guest = Guest.find(params[:guest_id])
    @guest_choice = GuestChoice.new
  end

  def create
    @guest = Guest.find(params[:guest_id])
    @guest_choice = GuestChoice.new
    @guest_choice.guest = @guest
    if @guest_choice.save!
      redirect_to edit_guest_guest_choice_path(@guest, @guest_choice)
    end
  end

  def attendance
    @guest = Guest.find(params[:id])
    @guest.status = params[:status].to_i
    @guest.save!
  end

  def edit
    @guest = Guest.find(params[:guest_id])
    @guest_choice = GuestChoice.find(params[:id])
    @guests = @guest_choice.guest.event.guests.all
  end

  def update
    @guest = Guest.find(params[:guest_id])
    @guest_choice = GuestChoice.find(params[:id])
    @guest_choice.choices = [Guest.find(params[:guest_id]).name, Guest.find(params[:guest_choice][:choices].first).name, Guest.find(params[:guest_choice][:choices].second).name]
    @guest
    if @guest_choice.update(guest_choice_params)
      redirect_to guest_guest_choices_path(@guest)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def guest_choice_params
    params.require(:guest_choice).permit(:choices)
  end
end
