#' read_csa_time
#'
#' Read the data available in the package.
#'
#' @export
read_csa_time <- function(){
  dplyr::bind_rows(lapply(dir(system.file(package = "csatimer"), pattern = ".rds", full.names = T), readr::read_rds))
}
