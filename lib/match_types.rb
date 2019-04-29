# frozen_string_literal = true

require 'match_types/email'
require 'match_types/phone_number'

module MatchTypes
  def self.for(options)
    [].tap do |list|
      list.push(MatchTypes::Email.new) if options.email?
      list.push(MatchTypes::PhoneNumber.new) if options.phone_number?
    end
  end
end
