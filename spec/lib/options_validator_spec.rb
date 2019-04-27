# frozen_string_literal=true

require 'spec_helper'
require 'options'
require 'options_validator'

RSpec.describe OptionsValidator do
  it 'is invalid if no filename is provided' do
    args = Options.new
    args.email = true

    results = OptionsValidator.validate(args)
    
    expect(results).to be_invalid
  end

  it 'is invalid if no match mode is specified' do
    args = Options.new
    args.filename = "test.csv"

    results = OptionsValidator.validate(args)

    expect(results).to be_invalid
  end
end
