class Row
  attr_reader :columns
  attr_reader :data

  def initialize(columns, data)
    @columns = columns
    @data = data
  end

  def to_a
    data
  end
end
