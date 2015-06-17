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
    extras_key = "$extra_params"
    csv.each do |row|
      hash = {}
      all_headers.each_with_index {|head, ii|
        if head.nil?
          # extra params w/o header
          unless row[ii].nil?
            hash[extras_key] = [] unless hash.include?(extras_key)
            hash[extras_key] << row[ii]
          end
        else
          # value has named header
          key = head.downcase
          hash[key] = row[head]
        end
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
