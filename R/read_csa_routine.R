#' read_csa_routine
#'
#' Read the data available in the package.
#'
#' @export
read_csa_routine <- function(){
  dplyr::bind_rows(lapply(dir(system.file(package = "csatimer"), pattern = "^\\d{4}.rds", full.names = T), readr::read_rds))
}

