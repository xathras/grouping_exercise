# frozen_string_literal: true
# !/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.setup(:production)
$LOAD_PATH.unshift("lib", __FILE__)
require 'csv'
require 'options'
require 'parser'
require 'options_validator'
require 'columns'
require 'row'
require 'row_set'

args = Parser.parse(ARGV)

if args.help?
  puts args.help_text
  exit
end

validation = OptionsValidator.validate(args)
if validation.invalid?
  puts validation.errors.join("\n")
  exit 1
end

columns = nil
seen_rows = RowSet.new(args)
output_filename = "#{File.basename(args.filename, '.*')}_output.csv"

CSV.open(output_filename, "wb") do |output_csv|
  counter = 0
  CSV.foreach(args.filename) do |raw_row|
    columns ||= Columns.parse(raw_row)
    if columns.first.name == raw_row[0]
      output_csv.puts(%w[ID] + raw_row)
      next
    end
    counter += 1

    row = Row.new(columns, raw_row)
    seen_rows = if seen_rows.include?(row)
                  seen_rows
                else
                  output_csv.puts([counter] + row.to_a)
                  seen_rows.add(row)
                end
  end
end
