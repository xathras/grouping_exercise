# frozen_string_literal: true

module MatchTypes
  class Email
    def for?(column)
      column.email?
    end

    def normalize(data)
      data
    end
  end
end
