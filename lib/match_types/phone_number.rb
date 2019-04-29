# frozen_string_literal = true

require 'phone_number'

module MatchTypes
  class PhoneNumber
    def for?(column)
      column.phone_number?
    end

    def normalize(data)
      ::PhoneNumber.parse(data).to_s
    end
  end
end
