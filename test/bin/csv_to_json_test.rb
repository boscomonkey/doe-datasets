#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../bin/csv_to_json'

class CsvsToJsonTest < Minitest::Test
  def setup
    fname = 'test/fixtures/categories.csv'

    @converter = CsvsToJson.new
    @result = @converter.process(File.open fname)
  end

  def test_csvs
    csvs = @result['data']

    assert_instance_of Array, csvs
    assert_equal 7, csvs.size

    # row 0
    row = csvs.first
    assert_equal 'Energy Efficiency & Renewable Energy Data Portal', row['name']

    # row index 2 should have a 'url' value; all other rows should
    # have nil
    (0...csvs.size).each do |ii|
      if 2 == ii
        refute_nil csvs[ii]['url'], "refute_nil: #{ii} == ii"
      else
        assert_nil csvs[ii]['url'], "assert_nil: #{ii} == ii"
      end
    end

    # sample test DSIRE row
    row = csvs[-1]
    expected_data = {
      'id'   => 'federal-energy-regulatory-commission-data-sets',
      'name' => 'Federal Energy Regulatory Commission Data Sets',
      'url'  => nil,
    }
    expected_data.each {|key, val| assert_equal val, row[key]}
  end
end
