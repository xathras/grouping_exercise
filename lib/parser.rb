# frozen_string_literal: true

require 'optparse'
require 'options'

module Parser
  def self.parse(string)
    args = Options.new
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage grouping_exercise.rb [options]"

      opts.on("-f", "--filename=FILENAME", "The name of the .csv to process") do |f|
        args.filename = f
      end

      opts.on("-e", "--email", "Use emails to remove duplicates from the processed file") do |e|
        args.email = e
      end

      opts.on("-p", "--phone", "Use phone numbers to remove duplicates from the processed file") do |p|
        args.phone_number = p
      end

      opts.on("-h", "--help", "Prints these instructions") do
        args.help = true
      end

      args.help_text = opts.to_s
    end

    opt_parser.parse(string)
    args
  end
end
