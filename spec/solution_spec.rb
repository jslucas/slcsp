require 'solution'
require 'tempfile'
require 'csv'

describe Solution do
  subject { Solution.call(input_path, output_path) }

  let(:output_file) { Tempfile.new("output.csv") }
  let(:input_file) { Tempfile.new("input.csv") }
  let(:output_path) { output_file.path }
  let(:input_path) { input_file.path }

  before do
    CSV.open(input_file.path, 'w') do |csv|
      csv << ["zipcode", "rate"]
      csv << ["64148", ""]
    end
  end

  after do
    output_file.close!
    input_file.close!
  end

  describe "output file" do
    it "has headers" do
      subject

      expect(CSV.open(output_file.path, 'r').first)
        .to eq(["zipcode", "rate"])
    end

    it "fills in the rate column" do
      subject

      expect(CSV.open(output_file.path, 'r', headers: true).first["rate"])
        .to eq("245.20")
    end
  end
end
