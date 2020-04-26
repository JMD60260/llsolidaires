require 'csv'

class CsvExport
  def initialize(data, attributes)
    @header = attributes
    @data = data
    @options = { col_sep: ';' }
  end

  def perform
    Enumerator.new do |yielder|
      yielder << CSV.generate_line(@header, @options)
      @data.each do |record|
        yielder << CSV.generate_line(get_data(record), @options)
      end
    end
  end

  private

  def get_data(record)
    @header.map do |attribute|
      record.send(attribute)
    end
  end
end
