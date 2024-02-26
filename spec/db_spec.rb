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
end
