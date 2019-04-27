# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.setup(:production)
$LOAD_PATH.unshift("lib", __FILE__)
require 'options'
require 'parser'
require 'options_validator'

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

# TODO: Open the CSV
# TODO: read the CSV entries
# TODO: check the CSV entry for duplication,
#       writing to the output file if unique, skipping if duplicated
