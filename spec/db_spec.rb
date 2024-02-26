require 'db'

describe Db do
  subject { Db.instance }

  it "seeds zips from zips.csv" do
    expect(
      subject.query <<-SQL
        select distinct(state) from zips where zipcode='36703';
      SQL
    ).to eq(["AL"])
  end

  it "seeds plans from plans.csv" do
    expect(
      subject.query <<-SQL
        select state from plans where plan_id='74449NR9870320';
      SQL
    ).to eq(["GA"])
  end

  describe ".silver_rates_for" do
    it "returns all rates for silver plans by zip" do
      expect(subject.silver_rates_for("58703"))
        .to eq([326.65, 314.78, 318.27, 289.74, 315.23, 297.93, 335.34, 313.24, 302.28])
    end
  end
end
