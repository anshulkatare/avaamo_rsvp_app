module Rsvps
  class UpdateRsvp
    attr_reader :status, :user_id, :rsvp_id

    def initialize(status:, user_id:, rsvp_id:)
      @status = status
      @rsvp_id = rsvp_id
    end

    def execute
      rsvp = Rsvp.find rsvp_id

    end
  end
end