jQuery(document).ready(function() {

    function renderCategories(categories) {
        var source    = jQuery('#category-template').html();
        var template  = Handlebars.compile(source);
        var container = jQuery('.featured-datasets');

        // cycle over array of categories and render each cat
        categories.map(function(cat) {
            var html = template(cat);
            container.append(html)
        });
    };

    function onDataSuccess(categoriesResult, datasetsResult) {
        var categories = categoriesResult[0].data;	// loaded from JSON
        var datasets   = datasetsResult[0].data;	// loaded from JSON
        var categoryMap = {}				// maps category_id to category

        // cycle over categories to build map
        categories.map(function(cat) {
            categoryMap[cat.id] = cat;
        });

        // cyle over datasets to insert into correct category
        datasets.map(function(dset) {
            var cat = categoryMap[dset.category_id];

            if (!cat) {
                console.log('UNKNOWN category_id:', dset.category_id);
                return;		// bail this iteration if category is missing
            }

            if (!cat.datasets) {
                cat.datasets = [];
            }
            cat.datasets.push(dset);
        });

        // fill it
        renderCategories(categories);
    };

    $.when(
        $.ajax('data/categories.json'),
        $.ajax('data/datasets.json')
    )
        .done(onDataSuccess);

});
