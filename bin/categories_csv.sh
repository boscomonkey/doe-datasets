#!/bin/bash

# Retrieves the "categories" tab of the "DOE Datasets and Repositories
# for Energy Roundtable" Google Spreadsheet as a CSV to STDOUT.
#
# Useful for piping to bin/csv_to_json.rb to create the corresponding
# JSON file. For example:
#
# bin/categories_csv.sh | bin/csv_to_json.rb > data/categories.json

curl 'https://docs.google.com/spreadsheets/d/1YM4SlzE7lg_JfcCSRCrrNM6DeA8K43hgrWttaVVfhwE/export?format=csv&gid=0'
