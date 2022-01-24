#' update_csatimer
#'
#' Update the data available in the package
#'
#' @export
update_csatimer <- function(quiet = F){
  # Routine dataset
  purrr::walk(2016:2021, update_year, quiet = quiet)

  # Elections
  c("pres_2017", "pres_2022") %>%
    purrr::walk(update_year, quiet = quiet)
}

update_year <- function(year, quiet = F){
  suppressWarnings({
    try({
      download.file(glue::glue("https://github.com/benjaminguinaudeau/csatimer/blob/master/inst/{year}.rds?raw=true"),
                    destfile = paste0(system.file(package = "csatimer"), glue::glue("/{year}.rds")),
                    quiet = T)
      if(!quiet) cli::cli_alert_info("Updating {year}")
    }, silent = T)
  })
}

