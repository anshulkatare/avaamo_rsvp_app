class Rsvps < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: [:yes, :no, :maybe, :pending]

  def self.bulk_create(user_ids:, event_id:)
    rsvps = user_ids.map do |user_id|
      Rsvps.new(user_id: user_id,
                event_id: event_id,
                status: :pending)
    end

    Rsvps.import! rsvps
  end

  def self.bulk_upload(file)
    require 'csv'
    rsvps = []

    CSV.foreach(file.path, headers: true) do |row|
      event = Event.find_by title: row['title']
      rsvps = build_rsvp(event: event,
                          users_n_statuses: row['users#rsvp'])
    end

    Rsvps.import! rsvps
  end

  private

  def self.build_rsvp(event: event, users_n_statuses: row['users#rsvp'])
    users_n_statuses = users_n_statuses.split(';')

    users_n_statuses.map do |user_n_status|
      user_n_status = user_n_status.split('#')
      Rsvps.new(event: event,
                user: User.find_by(username: user_n_status[0]),
                status: user_n_status[1])
    end

  end
end
