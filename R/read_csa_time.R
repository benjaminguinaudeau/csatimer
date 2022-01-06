#' read_csa_time
#'
#' Read the data available in the package.
#'
#' @export
read_csa_time <- function(){
  dplyr::bind_rows(lapply(dir(system.file(package = "csatimer"), pattern = ".rds", full.names = T), readr::read_rds))
}

#' update_csa_time
#'
#' Update the data available in the package
#'
#' @export
update_csa_time <- function(quiet = F){
  purrr::walk(2016:2021, update_year, quiet = quiet)
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
