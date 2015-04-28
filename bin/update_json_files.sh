#!/bin/bash

# Convenience utility to update both JSON files from Google
# Spreadsheet tabs.

bin/categories_csv.sh | bin/csv_to_json.rb > data/categories.json
bin/datasets_csv.sh   | bin/csv_to_json.rb > data/datasets.json
