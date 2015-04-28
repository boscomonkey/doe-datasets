#!/usr/bin/env ruby

require 'csv'
require 'json'

class CsvsToJson

  def process(csv_fname)
    csv = CSV.read(csv_fname, headers:true)

    # extract named headers
    all_headers = csv.headers

    # organize return result
    array = []

    # iterate over rows
    csv.each do |row|
      hash = {}
      all_headers.each {|head|
        key = head.downcase
        hash[key] = row[head]
      }

      array << hash
    end

    {'data' => array}
  end

end


if __FILE__ == $0 && 1 == ARGV.length
  # if there is 1 argument, invoke code on first argument

  fname = ARGV[0]
  converter = CsvsToJson.new
  obj = converter.process(fname)

  puts JSON.pretty_generate(obj)

elsif __FILE__ == $0 && 0 == ARGV.length
  # no command line arg, run unit test

  require 'minitest/autorun'

  class Test < Minitest::Test
    def setup
      fname = 'test/fixtures/sunshotcatalystdatasets.csv'
      @converter = CsvsToJson.new
      @result = @converter.process(fname)
    end

    def test_csvs
      csvs = @result['data']

      assert_instance_of Array, csvs
      assert_equal 14, csvs.size

      # row 0
      row = csvs.first
      assert_equal 'PVWatts', row['name']

      # first 9 rows should have a 'query' value
      (0..8).each {|ii| refute_nil csvs[ii]['query']}
      (9..13).each {|ii| assert_nil csvs[ii]['query']}

      # sample test DSIRE row
      row = csvs[11]
      expected_data = {
        'name'  => 'Database of State Incentives for Renewables & Efficiency',
        'url'   => 'http://www.dsireusa.org/',
        'query' => nil
      }
      expected_data.each {|key, val| assert_equal val, row[key]}
    end
  end

end
