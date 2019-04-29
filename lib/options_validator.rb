# frozen_string_literal: true

class OptionsValidator
  attr_reader :errors

  def self.validate(args)
    errors = [].tap do |list|
      list.push("You must provide a filename") if args.filename == ""
      list.push("You must choose at least one matcher") unless args.email? || args.phone_number?
    end
    new(errors)
  end

  def initialize(errors)
    @errors = errors || []
  end

  def valid?
    errors.count.zero?
  end

  def invalid?
    !valid?
  end
end
