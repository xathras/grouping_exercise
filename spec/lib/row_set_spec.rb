require 'spec_helper'
require 'options'
require 'columns'
require 'row'
require 'row_set'

RSpec.describe RowSet do
  it 'should indicate a duplicate record if the email validation is turned on and it has already seen a row with the provided email' do
    options = Options.new.tap do |opts|
      opts.email = true
    end
    columns = Columns.parse(%w[FirstName Email1])
    row1 = Row.new(columns, %w[Andrew andrew@example.com])
    row2 = Row.new(columns, %w[Andy andrew@example.com])
    validator = RowSet.new(options).add(row1)

    expect(validator.include?(row2)).to eq(true)
  end

  it 'should indicate a duplicate record if the phone number validation is turned on and it has already seen a row with the provided phone number' do
    options = Options.new.tap do |opts|
      opts.phone_number = true
    end
    columns = Columns.parse(%w[FirstName Phone])
    row1 = Row.new(columns, %w[Andrew 5555555555])
    row2 = Row.new(columns, %w[Andy 5555555555])
    validator = RowSet.new(options).add(row1)

    expect(validator.include?(row2)).to eq(true)
  end

  it 'should indicate a duplicate record if both validations are on and it has seen a row with either/any value' do
    options = Options.new.tap do |opts|
      opts.email = true
      opts.phone_number = true
    end
    columns = Columns.parse(%w[FirstName Phone Email])
    row1 = Row.new(columns, %w[Andrew 5555555555 andrew@example.com])
    row2 = Row.new(columns, %w[Andy 5545555555 andrew@example.com])
    row3 = Row.new(columns, %w[Andy 5555555555 andrew@compuserve.com])
    validator = RowSet.new(options).add(row1)

    expect(validator.include?(row2)).to eq(true)
    expect(validator.include?(row3)).to eq(true)
  end

  it 'should let you know which column/value is in the set' do
    options = Options.new.tap do |opts|
      opts.phone_number = true
    end
    columns = Columns.parse(%w[FirstName Phone])
    row1 = Row.new(columns, %w[Andrew 5555555555])
    row2 = Row.new(columns, %w[Andy 5555555555])
    validator = RowSet.new(options).add(row1)

    expect(validator.matched_value(row2)).to eq('15555555555')
  end
end
