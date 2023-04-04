# Avian diversity and function across the World’s most populous cities 

Main analysis completed within RStudio. Each file is an RStudio notebook (`*.Rmd`) that can be imported into RStudio and contains additional notes about the analysis being completed.

The manuscript splits the methods and results into three sections:
* Species richness within and between cities 
* Phylogenetic signal for urban adaptability 
* Functional richness within urban hotspots 

The files used for each section are detailed below.

The manuscript presents the results of using regional pools generated from BirdLife International distribution data. In appendix 1 an alternative analysis is presented using regional pools generated from eBird data; please note that within the R analysis the eBird regional pool is referred to as Merlin as the data used to generate the regional pool from eBird is from the datasets that power the Cornel Lab's Merlin smartphone application.  This analysis also includes results from two additional regional pools; (1) when species are present in both the BirdLife regional pool and the eBird/Merlin regional pool, and (2) when species are present in either the BirdLife regional pool or the eBird/Merlin regional pool.

In general for each analysis file named `xxx_analysis.Rmd` there will also be the following corresponding files: 
* `xxx_analysis.nb.html`: an html output of the notebook containing R code and outputs
* `xxx_analysis.meta_data.schema.yaml`: schema information on any input or output CSV files created/produced.
* `xxx_analysis__input__XXXX.csv`: CSV files used for input data for the analysis
* `xxx_analysis__output__XXXX.csv`: CSV files created by the analysis
* `xxx_analysis__output__XXXX.jpg`: JPG image files created by the analysis

## Species richness within and between cities 
The analysis for comparing the percentage of regional pool richness retained at each hotspot is in `percentage_of_regional_richness.Rmd`, before running this file first run `download_data.Rmd` which loads and imports the relevant datasets (see `download_data.meta_data.schema.yaml` for more information).
`percentage_of_regional_richness.meta_data.schema.yaml` contains the schema for each of the CSV files that are created by running `percentage_of_regional_richness.Rmd`. 

The city random effect interecepts are outputed from `percentage_of_regional_richness.Rmd` into: 
* `percentage_of_regional_richness__output__birdlife_city_richness_intercept.csv`
* `percentage_of_regional_richness__output__merlin_city_richness_intercept.csv`
* `percentage_of_regional_richness__output__both_city_richness_intercept.csv`
* `percentage_of_regional_richness__output__either_city_richness_intercept.csv`

The analysis of these files for comparing cities is covered in `city_effect_richness.Rmd`.

Finally, `referee_comments.Rmd` examines the impact of the number of checklists on the percentage of regional pool richness retained within a hotspot.

Google Earth Engine was used to generate the environmental variables used to describe the regions around hotspots and the cities. The code used is here https://zenodo.org/record/7798971.

## Phylogenetic signal for urban adaptability
`phylogeny.Rmd` covers the analysis of phylogeny. `phylogeny.meta_data.schema.yaml` contains the schema for data used within this analysis.

## Functional richness within urban hotspots 
`niche_resilience.Rmd` cover the analysis for the predictors for the percentage of niches retained from the regional pool at each hotspot. The city random effect intercepts are stored in CSVs from this analysis but not used again. See `niche_resilience.meta_data.schema.yaml` for more information on the CSV files produced. Before running this file first run `download_data.Rmd`

`species_analysis.Rmd` covers the analysis of niche loss/accumulation within cities. It uses exported accumluation data, details of which can be found in `species_analysis.meta_data.schema.yaml`.

The clusters used to represent niches were generated using species morphology, the code is here https://zenodo.org/record/7798990.


