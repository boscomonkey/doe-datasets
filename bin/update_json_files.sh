#!/bin/bash

# Convenience utility to update both JSON files from Google
# Spreadsheet tabs.

bin/categories_csv.sh | tee data/categories.csv | bin/csv_to_json.rb > data/categories.json
bin/datasets_csv.sh   | tee data/datasets.csv   | bin/csv_to_json.rb > data/datasets.json
