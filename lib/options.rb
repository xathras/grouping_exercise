# frozen_string_literal: true

class Options
  attr_accessor :filename
  attr_accessor :email
  attr_accessor :phone_number
  attr_accessor :help_text
  attr_accessor :help

  def initialize
    @filename = ""
    @email = false
    @phone_number = false
    @help_text = ""
  end

  def email?
    email
  end

  def phone_number?
    phone_number
  end

  def help?
    help
  end
end
