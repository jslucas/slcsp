require 'csv'
require 'db'
require 'slcsp'

module Solution
  @headers = ["zipcode", "rate"]

  def self.call(input = "slcsp.csv", output = "result.csv", db = Db.instance)
    CSV.open(output, "w") do |file|
      file << @headers
      puts @headers.join(',')

      CSV.foreach(input, headers: true) do |row|
        row["rate"] =
          row["zipcode"]
            .then { |zip| db.silver_rates_for(zip) }
            .then { |rates| SLCSP.call(rates) }
            .then { |maybe_rate| SLCSP.format(maybe_rate) }

        file << row
        puts row.to_s
      end
    end
  end
end
