module SLCSP
  def self.call(rates)
    rates.length > 1 ? rates.sort[1] : nil
  end

  def self.format(maybe_rate)
    if maybe_rate
      sprintf("%.2f", maybe_rate.round(2))
    else
      nil
    end
  end
end
