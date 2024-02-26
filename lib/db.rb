require 'sqlite3'
require 'singleton'

class Db
  include Singleton

  def query(q)
    @db.execute(q).flatten
  end

  def silver_rates_for(zip)
    query <<-SQL
      select distinct p.rate
      from plans p
      join zips z
      on p.state = z.state
      and p.rate_area = z.rate_area
      where p.metal_level = "Silver"
      and z.zipcode = #{zip};
    SQL
  end

  def zips
    query <<-SQL
      select distinct(state) from zips where zipcode='36703';
    SQL
  end

  def plans
    query <<-SQL
      select state from plans where plan_id='74449NR9870320';
    SQL
  end

  private

  def initialize
    system("rm slcsp.sqlite3")
    @db = SQLite3::Database.new "slcsp.sqlite3"

    self.seed()
  end

  def seed
    @db.execute <<-SQL
      create table plans (
        plan_id nvarchar(14) primary key,
        state nvarchar(2) not null,
        metal_level nvarchar(12) not null,
        rate double not null,
        rate_area integer
      );

      create table zips (
        zipcode nvarchar(5) not null,
        state nvarchar(2) not null,
        county_code nvarchar(5) not null,
        name nvarchar(50) not null,
        rate_area integer
      )
    SQL

    system(
      "sqlite3",
      "slcsp.sqlite3",
      ".mode csv",
      ".import zips.csv zips",
    )

    system(
      "sqlite3",
      "slcsp.sqlite3",
      ".mode csv",
      ".import plans.csv plans"
    )
  end
end
