require 'set'
require 'phone_number'

class RowSet
  class EmailChecker
    def for?(column)
      column.email?
    end

    def normalize(data)
      data
    end
  end

  class PhoneNumberChecker
    def for?(column)
      column.phone_number?
    end

    def normalize(data)
      PhoneNumber.parse(data).to_s
    end
  end

  def initialize(options, set = Set.new)
    @options = options
    @set = set
    @checkers = [].tap do |list|
      list.push(EmailChecker.new) if @options.email?
      list.push(PhoneNumberChecker.new) if @options.phone_number?
    end
  end

  def include?(row)
    with_metadata(row).any? { |column, data|
      checkers_for(column)
        .map { |object| object.normalize(data) }
        .any? { |value| @set.include?(value) }
    }
  end

  def matched_value?(row)
    with_metadata(row).map { |column, data|
      checkers_for(column)
        .map { |object| object.normalize(data) }
        .select { |value| @set.include?(value) }
        .first
    }.compact.first
  end

  def add(row)
    new_set = with_metadata(row).map { |column, data|
      checkers_for(column).first&.normalize(data)
    }.reduce(Set.new(@set.to_a)) { |new_set, data| new_set.add(data) }
    self.class.new(@options, new_set)
  end

  private

  def with_metadata(row)
    row.columns.zip(row.data).reject { |_, data| data.nil? }
  end

  def checkers_for(column)
    @checkers.select { |object| object.for?(column) }
  end
end
