#' read_csa_election
#'
#' @export

read_csa_election <- function(election_id){
  if(!election_id %in% c("pres_2017", "pres_2022")){
    stop('election_id not found.\nelection_id must be one of `c("pres_2017", "pres_2022")`')
  }

  readr::read_rds(system.file(paste0(election_id, ".rds"), package = "csatimer"))

}
