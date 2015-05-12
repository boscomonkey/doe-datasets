# U.S. Department of Energy Datasets #

List of significant datasets from the U.S. Department of Energy, categorized by the Offices, National Laboratories, and/or functionality.


## Why This Project ##

For the first [Energy Open Data Roundtable](http://energy.gov/eere/articles/first-ever-energy-open-data-roundtable-catalyzes-value-big-data-revolution-energy) on Apr 29, 2015, the [Center of Open Data Enterprise](http://www.opendataenterprise.org/convene) created a [Microsoft Word document](data/3-Energy%20Roundtable%20-%20DRAFT%20DOE%20data%20sets%204-23-15.docx) of DOE datasets relevant to the conference discussion.

In addition to providing meta-data of the datasets as a Word Doc, we felt that it was important to also deliver it as machine readable data in both [CSV](http://en.wikipedia.org/wiki/Comma-separated_values) and [JSON](http://en.wikipedia.org/wiki/JSON) formats.

Thus, this project was formed.

We then realized that if the data is in machine readable format, then there is no need to maintain a human readable version in parallel. Instead, we can use the latest JSON data to render our [index page](index.html) dynamically. With this simple insight, the human readable form will never get out of sync with the machine readable form.

## Under the Covers ##

If you wish to contribute to the categories and datasets described in this repo,it's useful to know the categories and datasets relate to each other. Also, it's useful to know where to store and manage the data so that changes are propagated to both machine and human readable formats.

### Data Model ###

The data model consists of two "tables" - categories, and datasets. The categories table has these fields:

| Name			| Type	 | Required	| Example |
|---------------|--------|----------|---------|
| id			| string | yes		| doe-explorer |
| name			| string | yes		| DOE Explorer |
| url			| string | no		| http://www.osti.gov/dataexplorer/ |
| description	| string | no, but recommended | This portal, launched in 2013 by DOE’s Office of Science, provides science, technology, and engineering research and data collections from DOE. |

The datasets table has these fields:

| Name			| Type 	 | Required | Example |
|---------------|--------|----------|---------|
| category_id	| string | yes, relates to ````id```` in ````categories```` table | doe-explorer |
| name			| string | yes		| DOE Global Energy Storage Database |
| url			| string | yes		| http://www.osti.gov/dataexplorer/biblio/1134061 |
| description	| string | no, but recommended | The DOE International Energy Storage Database has more than 400 documented energy storage projects from 34 countries around the world. The database provides free, up-to-date information on grid-connected energy storage projects and relevant state and federal policies. |

The IDs are contructed by converting lowercasing all the alphabetic characters and converting all occurrences of non-alphabetics into one hyphen.

The ````categories```` and ````datasets```` tables are stored in a [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1YM4SlzE7lg_JfcCSRCrrNM6DeA8K43hgrWttaVVfhwE/edit#gid=0) and are exported to CSV files in ````data/```` with the command line utilities ````bin/categories_csv.sh```` and ````bin/datasets_csv.sh````.

### Creating JSON from CSV ###

Once you have valid CSV files, you can convert them into JSON that drives ````index.html```` by using the command line utility ````bin/csv_to_json.rb````. This utility will take either piped output from STDIN or one or more filenames specified as arguments. The output from the utility is sent to STDOUT and should be piped to a file.

````bin/update_json_files.sh```` is a convenience script that performs the following in one shot:

* downloads categories and datasets from the Google Spreadsheet
* saves them as CSVs
* converts and saves them as JSONs

### JavaScript Templating ###

If you inspect ````index.html```` and ````js/main.js````, you will notice that the HTML file contains no content, and the JavaScript loads the data from JSON files and rendered them dynamically.

The rendering is performed via [Handlebar JS](http://handlebarsjs.com/) templating engine and you can see the template inside the ````script```` tag with ID "category-template" and type "text/x-handlebars-template".


## Contributing ##

TBD

### Adding Code ###

TBD

### Adding Data ###

TBD
