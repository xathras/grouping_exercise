require 'spec_helper'
require 'phone_number'

RSpec.describe PhoneNumber do
  it 'should recognize 10 digit phone numbers with various formatting' do
    numbers = ['(555) 555-5555', '555.555.5555', '5555555555', '555-555-5555']

    numbers.each do |input_string|
      output = PhoneNumber.parse(input_string)

      expect(output.npa).to eq('555')
      expect(output.npx).to eq('555')
      expect(output.line_number).to eq('5555')
    end
  end

  it 'should recognize 11 digit phone numbers with various formatting' do
    numbers = ['+1 (555) 555-5555', '1.555.555.5555', '15555555555', '1-555-555-5555']

    numbers.each do |input_string|
      output = PhoneNumber.parse(input_string)

      expect(output.country_code).to eq('1')
      expect(output.npa).to eq('555')
      expect(output.npx).to eq('555')
      expect(output.line_number).to eq('5555')
    end
  end


  it 'should provide a normalized phone number without the formatting' do
    output = PhoneNumber.parse('(123) 456-7890').to_s

    expect(output).to eq('11234567890')
  end
end
