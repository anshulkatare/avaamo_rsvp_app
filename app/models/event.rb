class Event < ApplicationRecord
  belongs_to :user
  has_many :rsvps

  enum event_length: [:fullday, :part_day]

  def self.bulk_upload(file)
    require 'csv'
    user = User.first
    events = []

    CSV.foreach(file.path, headers: true) do |row|
      events << build_event(title: row['title'],
                            start_time: row['starttime'],
                            end_time: row['endtime'],
                            description: row['description'],
                            all_day: row['allday'],
                            user: user)
    end

    Event.import! events
  end

  private

  def self.build_event(title:, start_time:, end_time:, description:, all_day:, user: )
    event_length = (all_day == 'TRUE') ? :fullday : :part_day
    Event.new(title: title,
              start_time: start_time.to_time,
              end_time: end_time.to_time,
              description: description,
              event_length: event_length,
              user: user)
  end
end
