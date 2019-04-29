require 'spec_helper'
require 'columns'

RSpec.describe Columns do
  it 'should turn a list of strings into a list of columns' do
    data = %w[FirstName LastName Phone Email Zip]

    columns = Columns.parse(data)

    expect(columns.map(&:name)).to match_array(data)
  end

  describe Columns::Column do
    it 'should think it is an email column if the word email is anywhere in the name' do
      columns = %w[email Email Email1 1Email1 Email2].map { |value| described_class.new(value) }

      columns.each do |column|
        expect(column).to be_email
      end
    end

    it 'should think it is a phone number column if the word phone is anywhere in the name' do
      columns = %w[phone Phone PhoneNumber Phone1 PhoneNumber1 Phone2].map { |value| described_class.new(value) }

      columns.each do |column|
        expect(column).to be_phone_number
      end
    end
  end
end
