class DataExtractor
  attr_reader :data
  RAW_HTML_LABELS = Regexp.union([/Date/, /Hour/, /Temperature/, /Surface Wind/,
                                  /Sky Cover/, /Precipitation Potential/,
                                  /Relative Humidity/])
  def initialize(nokogiri_doc)
    @data = {}
    parse_data(nokogiri_doc)
  end

  def parse_data(doc)
    doc.css("tr").each do |row|
      parse_row(row) if is_data_row?(row)
    end
  end

  def parse_row(row)
    label = find_label(row)
    return if @data.has_key?(label)
    extract_data(label, row)
  end

  def find_label(row)
    raw_label = row.content.scan(RAW_HTML_LABELS)[0]
    convert_label(raw_label)
  end

  def convert_label(raw_label)
    raw_label_converter = { "Hour" => :time,
                            "Date" => :date,
                            "Temperature" => :temp,
                            "Surface Wind" => :wind,
                            "Sky Cover" => :sky_cover,
                            "Precipitation Potential" => :precip,
                            "Relative Humidity" => :humidity }
    raw_label_converter[raw_label]
  end

  def extract_data(label, row)
    @data[label] = []
    label_pos = find_label_pos(row)
    row.children.each_with_index do |child, index|
      next if index <= label_pos
      col_content = child.content.strip
      @data[label] << col_content unless col_content == ""
    end
  end

  def find_label_pos(row)
    row.children.each_with_index do |child, index|
      return index if !!(child.content.match(RAW_HTML_LABELS))
    end
  end

  def is_data_row?(row)
    return false if !!(row.content.match(/[\W]Hour/))
    row.content.scan(RAW_HTML_LABELS).length == 1
  end
end
