This is a bit of exploration to analyse the papers submmitted to the [AGILE 2014 conference](http://www.agile-online.org/index.php/conference/conference-2014) with R. 

* data/submissions.csv: Raw data as extracted from the submission manager tool.
* data/submissions-clean.csv: clean data after doing some data transformations and cleaning.
* R/cleaning.R: tranforms submissions.csv into submissions-clean.csv, for completeness
* R/treemap.R: create a tree map visualization that counts the times of contributions aggregated by the first keyword chosen by the authors and then by the acceptance status. See an example [here](http://www.geotec.uji.es/wagile-2014-treemap/)
