# Avian diversity and function across the World’s most populous cities 

Main analysis completed within RStudio. Each file is an RStudio notebook that can be imported into RStudio and contains additional notes about the analysis being completed.

The manuscript splits the methods and results into three sections:
* Species richness within and between cities 
* Phylogenetic signal for urban adaptability 
* Functional richness within urban hotspots 

The files used for each section will be detailed below.

Note that within the R analysis the eBird regional pool is referred to as Merlin as the data used to generate the regional pool from eBird is from the datasets that powers the Cornel Lab's Merlin application.

## Species richness within and between cities 
The analysis for comparing the percentage of regional pool richness retained at each hotspot is in `percentage_of_regional_richness.Rmd`, before running this file first run `download_data.Rmd` which loads and imports the relevant datasets (see `download_data.meta_data.schema.yaml` for more information).
`percentage_of_regional_richness.meta_data.schema.yaml` contains the schema for each of the CSV files that are created by running `percentage_of_regional_richness.Rmd`. 
`percentage_of_regional_richness__output__birdlife_city_richness_intercept.csv`, `percentage_of_regional_richness__output__merlin_city_richness_intercept.csv`, `percentage_of_regional_richness__output__both_city_richness_intercept.csv`, and `percentage_of_regional_richness__output__either_city_richness_intercept.csv` are used in the following section for comparing cities.

The analysis for comparing cities is covered in `city_effect_richness.Rmd`, note that you must first run `percentage_of_regional_richness.Rmd` to generate the city random effect intercepts.

## Phylogenetic signal for urban adaptability
`phylogeny.Rmd` covers the analysis of phylogeny. `phylogeny.meta_data.schema.yaml` contains the schema for data used within this analysis.

## Functional richness within urban hotspots 
`niche_resilience.Rmd` cover the analysis for the predictors for the percentage of niches retained from the regional pool at each hotspot.
