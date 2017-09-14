module Csv_Parser
  def self.parse_csv(file)
    csv = CSV.parse(File.new(file).read, :headers => true, :col_sep => ", ")
    results = []
    csv.each do |row|
      # Route.create!(row.to_hash)
      results << row.to_hash
    end
    results
  end
end