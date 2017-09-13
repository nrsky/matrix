module Csv_Parser
  def self.parse_csv(file)
    csv = CSV.parse(File.new(file).read, :headers => true, :col_sep => ", ")
    csv.each do |row|
      Route.create!(row.to_hash)
    end
  end
end