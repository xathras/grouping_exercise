# frozen_string_literal: true

require 'set'
require 'match_types'

class RowSet
  def initialize(options, set = Set.new)
    @options = options
    @set = set
    @match_types = MatchTypes.for(@options)
  end

  def include?(row)
    with_metadata(row).any? { |column, data|
      match_types_for(column)
        .map { |object| object.normalize(data) }
        .any? { |value| @set.include?(value) }
    }
  end

  def add(row)
    new_set = with_metadata(row)
      .map { |column, data|
        match_types_for(column).first&.normalize(data)
      }
      .reduce(Set.new(@set.to_a)) { |new_set, data| new_set.add(data) }
    self.class.new(@options, new_set)
  end

  private

  def with_metadata(row)
    row.columns.zip(row.data).reject { |_, data| data.nil? }
  end

  def match_types_for(column)
    @match_types.select { |object| object.for?(column) }
  end
end
