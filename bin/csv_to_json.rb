#!/usr/bin/env ruby

require 'csv'
require 'json'

class CsvsToJson

  def process(io)
    csv = CSV.parse(io, headers:true)

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


if __FILE__ == $0

  # If invoked on the command line, grab input from ARGF

  converter = CsvsToJson.new
  obj = converter.process(ARGF.file)

  puts JSON.pretty_generate(obj)

end
