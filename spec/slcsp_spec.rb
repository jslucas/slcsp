require 'slcsp'

describe "SLCSP" do
  subject { SLCSP.call() }

  it { is_expected.to eq(true) }
end
