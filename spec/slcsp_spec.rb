require 'slcsp'

describe "SLCSP" do
  describe ".call" do
    subject { SLCSP.call(rates) }

    context "with no rates" do
      let(:rates) { [] }
      it { is_expected.to eq(nil) }
    end

    context "with one rate" do
      let(:rates) { [123.32] }
      it { is_expected.to eq(nil) }
    end

    context "with two rates" do
      let(:rates) { [60.23, 90.12] }
      it { is_expected.to eq(90.12) }
    end

    context "with many rates" do
      let(:rates) { [60.23, 123.43, 90.12, 123.32] }
      it { is_expected.to eq(90.12) }
    end
  end

  describe ".format" do
    it "returns float rounded 2 decimal places as string" do
      expect(SLCSP.format(123.332)).to eq("123.33")
      expect(SLCSP.format(123.339)).to eq("123.34")
    end

    it "returns nil if given nil" do
      expect(SLCSP.format(nil)).to eq(nil)
    end
  end
end
