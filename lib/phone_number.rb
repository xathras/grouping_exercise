# this class represents a simple US phone number
# if you need to represent non-US phone numbers you'll
# need to make significant changes, especially to the
# parsing code
class PhoneNumber
  attr_reader :country_code
  attr_reader :npa
  attr_reader :npx
  attr_reader :line_number

  def self.parse(phone_number_string)
    normalized_string = phone_number_string.delete('^0-9')
    if normalized_string.size == 10
      new("1", normalized_string[0..2], normalized_string[3..5], normalized_string[6..9])
    else
      new(normalized_string[0], normalized_string[1..3], normalized_string[4..6], normalized_string[7..10])
    end
  end

  def initialize(country_code, npa, npx, line_number)
    @country_code = country_code
    @npa = npa
    @npx = npx
    @line_number = line_number
  end

  def to_s
    "#@country_code#@npa#@npx#@line_number"
  end
end
