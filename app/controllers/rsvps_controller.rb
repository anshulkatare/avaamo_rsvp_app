class RsvpsController < ApplicationController

  def show_all
    @events =
        Event.joins('inner join rsvps on rsvps.event_id = events.id')
            .where('rsvps.user_id = ?', params[:user_id])
  end

  def send_rsvp
    @users = User.all
  end

  def update_rsvp

    response =
        Rsvps::UpdateRsvp.new(status: params[:response],
                          rsvp_id: params[:rsvp_id])
            .execute

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_rsvps
    Rsvps
        .bulk_create(user_ids: params[:user_ids],
                     event_id: params[:event_id])
  end
end
