
<!-- README.md is generated from README.Rmd. Please edit that file -->

# csatimer

<!-- badges: start -->
<!-- badges: end -->

*Dernière Mise à jour: 21 décembre 2021*

L’objectif de `{csatimer}`, est de disséminer en format analysable les
données de temps de parôle des personalités politiques, tels que
collectées par le Consiel Supérieur de l’Audiovisuel.

Conformément aux dispositions de l’article 13 de la loi du 30 septembre
1986, le CSA publie régulièrement les tableaux relatifs aux temps de
parole des personnalités politiques relevés dans les journaux et
bulletins d’information, les magazines et les autres émissions des
programmes sur les antennes des télévisions et des radios. Pour plus
d’information, le site du CSA propose un
[récapitulatif](https://www.csa.fr/csapluralisme/tableau) des données.

Le package contient l’ensemble des données relatives aux personalités
individuelles depuis 2019. A terme, la couverture temporelle sera
étendue jusqu’au début de la série en 2016.

## Installation

Le package peut être installé depuis [GitHub](https://github.com/) avec:

``` r
# install.packages("devtools")
devtools::install_github("benjaminguinaudeau/csatimer")
```

## Lire les données

`{csatimer}` contient une seule et unique fonction `read_csa_time`, qui
vise à lire les données.

``` r
library(csatimer)
dplyr::glimpse(read_csa_time())
#> Rows: 72,091
#> Columns: 10
#> $ month        <date> 2019-02-01, 2019-02-01, 2019-02-01, 2019-02-01, 2019-02-…
#> $ media        <chr> "TF1", "France 2", "France 3", "France 3", "Canal +", "Fr…
#> $ tv           <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU…
#> $ radio        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, F…
#> $ prog_type    <chr> "JT", "JT", "JT", "PROG", "PROG", "MAG", "PROG", "JT", "J…
#> $ nom          <chr> "Macron Emmanuel", "Macron Emmanuel", "Macron Emmanuel", …
#> $ appartenance <chr> "Président De La République Hors Débat Politique", "Prési…
#> $ party_abb    <fct> Exécutif, Exécutif, Exécutif, Exécutif, Exécutif, Exécuti…
#> $ time         <dbl> 3.0000, 7.0000, 9.0000, 1.0000, 3.0000, 9.0000, 12.0000, …
#> $ path         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
```

Les données sont collectées sur une base mensuelle. Les colonnes
suivantes sont incluses :

-   month: mois concerné
-   média: radio ou chaine télévisée concernée
-   radio/tv: type de média
-   prog\_type: le CSA différencie entre trois types de programmes (JT:
    journaux d’information, MAG: Magazines d’information et PROG:
    Programmation hors journaux et magazines)
-   nom: Nom de la personalité concernée
-   appartenance: Appartenance telle que fournie par le CSA
-   party\_abb: Abbréviation du party (pour objectifs de visualisation)
-   time: Temps de parole d’un personalité (par type de programme x
    chaîne x mois)

Veuillez noter, que les temps parole d’une personalité ou d’un parti
peuvent être agrégés à différents niveaux. Voici une liste des niveaux
d’aggrégation possibles:

-   année: 2019, 2020, etc…
-   mois: Janvier 2019, janvier 2018, etc…
-   media: TF1, France Inter, LCI, etc…
-   types de programme: JT, MAG ou PROG

Bien entendu ces niveaux peuvent être croisées. Ainsi, les temps de
paroles peuvent par example être agrégées au niveau du type de média
pour chaque média (JT x TF1, MAG x TF1, PROG x France 5, etc…)

## Actualisation des données

Les données seront actualisées dès que de nouvelles données seront
publiées par le CSA. Notez qu’une fois les données actualisées, il vous
sera nécessaire de réinstaller le package afin de profiter des dernières
données.

## Mettre les données à jour

Les données contenues dans le package seront actualisé au cours du
temps. Pour actualiser la version locale des données, vous pouvez
utiliser `update_csa_time`

``` r
update_csa_time()
#> ℹ Updating 2019
#> ℹ Updating 2020
#> ℹ Updating 2021
```
