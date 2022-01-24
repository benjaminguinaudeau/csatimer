
<!-- README.md is generated from README.Rmd. Please edit that file -->

# csatimer

`csatimer` provides data on how much French politician speech in the
media.

The dataset contained in the package are also
[available](https://github.com/benjaminguinaudeau/csatimer/tree/master/inst/csv)
in the csv-format.

## Data

*Last Update: January, 23 2022*

Two types of datasets are provided:

-   speaking time of politicians during routine period (no electoral
    campaigns)
-   speaking time of candidates during political campaigns

### Routine period (no electoral campaigns)

Every month, the [CSA](https://www.csa.fr/csapluralisme/tableau)
collects how much each political personality speaks on each of the major
radio and TV stations.

This dataset can be accessed using `read_csa_routine` and is continuous
between September 2017 and November 2021.

``` r
read_csa_routine() %>%
  dplyr::glimpse()
#> Rows: 106,850
#> Columns: 7
#> $ month     <date> 2017-09-01, 2017-09-01, 2017-09-01, 2017-09-01, 2017-09-01,…
#> $ station   <chr> "TF1", "France 2", "France 2", "France 2", "France 2", "Fran…
#> $ prog_type <chr> "JT", "JT", "JT", "MAG", "MAG", "PROG", "JT", "MAG", "JT", "…
#> $ name      <chr> "Macron Emmanuel", "Macron Emmanuel", "Macron Emmanuel", "Ma…
#> $ label     <chr> "Président De La République En Débat Politique", "Président …
#> $ party     <fct> Exécutif, Exécutif, Exécutif, Exécutif, Exécutif, Exécutif, …
#> $ time      <dbl> 8.416667, 7.933333, 4.050000, 6.300000, 2.266667, 3.500000, …
```

It contains following columns:

-   month <date> `"2017-01-01"`
-   station <chr> `"TF1", "France 2", "France Inter", ...`
-   prog\_type <chr> `"JT", "MAG", "PROG"`
-   name <chr>
    `"Emmanuel Macron", "Marine Le Pen", "François Hollande", ...`
-   label <chr>
    `"Président", "Parti Socialiste", "Ministre", "Les Républicains", ...`
-   party <chr> `"Exécutif" , "Ps", "LR", ...`
-   time <dbl>

Speaking times are measured in minutes. For instance, in September 2017,
Emanuel Macron spoke 8.4 minutes on TF1.

`prog_type` refers to different types of TV/Radio shows: \* `JT`:
newscast \* `MAG`: political shows \* `PROG`: non-political shows

### Electoral campaigns

During electoral campaigns - presidential, legislative and local - , the
CSA publishes every two weeks
[data](https://www.csa.fr/Proteger/Garantie-des-droits-et-libertes/Proteger-le-pluralisme-politique/Pendant-une-election)
on the speaking time of campaigning candidates.

For each candidate, it computes three different times:

-   `time_candidat`: speaking time of the candidate himself
-   `time_support`: speaking time of the personalities supporting the
    candidate
-   `time_mention`: speaking time of journalists mentioning the
    candidate.

This dataset can be accessed using `read_csa_election("pres_2022")`.

Following elections are available:

-   Presidential elections 2022: `read_csa_election("pres_2022")`
-   Presidential elections 2017: `read_csa_election("pres_2017")`

``` r
read_csa_election("pres_2022")  %>%
  dplyr::glimpse()
#> Rows: 265
#> Columns: 9
#> $ type          <chr> "presidential", "presidential", "presidential", "preside…
#> $ constituency  <chr> "national", "national", "national", "national", "nationa…
#> $ date_start    <date> 2022-01-01, 2022-01-01, 2022-01-01, 2022-01-01, 2022-01…
#> $ date_end      <date> 2022-01-16, 2022-01-16, 2022-01-16, 2022-01-16, 2022-01…
#> $ station       <chr> "BFM Business", "BFM Business", "BFM Business", "BFM TV"…
#> $ candidat      <chr> "Macron Emmanuel", "Pecresse Valerie", "Zemmour Eric", "…
#> $ time_candidat <dbl> 0.0000000, 0.1333333, 0.6000000, 9.7166667, 50.9166667, …
#> $ time_support  <dbl> 3.9833333, 0.0000000, 0.0000000, 0.0000000, 31.0500000, …
#> $ time_mention  <dbl> 0.0000000, 0.0000000, 1.3166667, 0.0000000, 3.0666667, 1…
```

### Updating data

Data will be updated as the CSA publishes new routine and campaign data.

To update the data local version, use `update_csatimer()`

``` r
# Updating data
update_csatimer()
#> ℹ Updating 2019
#> ℹ Updating 2020
#> ℹ Updating 2021
```
