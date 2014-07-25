class DataExtractor
  attr_reader :data
  HTML_LABELS = ["Date", "Hour", "Temperature", "Surface Wind", "Sky Cover",
    "Precipitation Potential", "Relative Humidity"]

  def initialize(nokogiri_doc)
    @nokogiri_doc = nokogiri_doc
  end

  def data
    @data ||= parse_data(@nokogiri_doc)
  end

  private

  def regex_labels
    Regexp.union(HTML_LABELS.map { |label| /#{label}/ })
  end

  def parse_data(doc)
    @data = {}
    doc.css("tr").each do |row|
      parse_row(row) if is_data_row?(row)
    end
    @data
  end

  def parse_row(row)
    label = find_label(row)
    return if @data.has_key?(label)
    @data[label] = extract_data(row)
  end

  def find_label(row)
    raw_label = row.content.scan(regex_labels)[0]
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

  def extract_data(row)
    label_pos = find_label_pos(row)
    row_data = []
    row.children[label_pos + 1 .. -1].each do |child|
      col_content = child.content.strip
      row_data << col_content unless col_content.empty?
    end
    row_data
  end

  def find_label_pos(row)
    row.children.each_with_index do |child, index|
      return index if !!(child.content.match(regex_labels))
    end
  end

  def is_data_row?(row)
    #The word "Hour" matches to a row that contains data, but there is a row that
    #matches the /[\W]Hour/ Regex that does not contain data
    return false if !!(row.content.match(/[\W]Hour/))
    row.content.scan(regex_labels).length == 1
  end
end
