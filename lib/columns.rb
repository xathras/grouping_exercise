module Columns
  Column = Struct.new(:name) do
    def email?
      name.downcase.include?('email')
    end

    def phone_number?
      name.downcase.include?('phone')
    end
  end

  def self.parse(data)
    data.map { |value| Column.new(value) }
  end
end
