require 'spec_helper'
require 'parser'

RSpec.describe Parser do
  it 'should include the help text in the results' do
    args = Parser.parse([])

    expect(args.help_text).not_to eq("")
  end

  it 'should indicate affirmative for email checking when given the short option' do
    args = Parser.parse(%w[-e])

    expect(args.email?).to eq(true)
  end

  it 'should indicate affirmative for email checking when given the long option' do
    args = Parser.parse(%w[--email])

    expect(args.email?).to eq(true)
  end

  it 'should indicate negative for email checking when given no email option' do
    args = Parser.parse([])

    expect(args.email?).to eq(false)
  end

  it 'should indicate affirmative for phone number checking when given the short option' do
    args = Parser.parse(%w[-p])

    expect(args.phone_number?).to eq(true)
  end

  it 'should indicate affirmative for phone number checking when given the long option' do
    args = Parser.parse(%w[--phone])

    expect(args.phone_number?).to eq(true)
  end

  it 'should indicate negative for phone number checking when given no phone number option' do
    args = Parser.parse([])

    expect(args.phone_number?).to eq(false)
  end

  it 'should have the provided filename when given the short option' do
    args = Parser.parse(%w[-f example.csv])

    expect(args.filename).to eq("example.csv")
  end

  it 'should have the provided filename when given the long option' do
    args = Parser.parse(%w[--filename=example.csv])

    expect(args.filename).to eq("example.csv")
  end

  it 'should have a blank filename when none is provided' do
    args = Parser.parse([])

    expect(args.filename).to eq('')
  end
end
