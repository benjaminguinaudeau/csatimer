#' add_station_dummies
#' @description Adds two dummies: is_private captures private stations (vs public ones) and is_tv captures TV stations (vs radio ones)
#' @export
add_station_dummies <- function(.tbl){
  .tbl %>%
    dplyr::mutate(
      is_private = !station %in% c("France 2", "France 3", "France 5", "France Culture", "France Inter", "France Info", "France Info TV", "Radio Classique",
                                   "France 2", "France 24", "France 3", "France 5", "France Info TV", "France Culture", "France Info", "France Inter", "Radio Classique", "RFI", "TV5Monde"),
      is_tv = station %in% c("TF1", "France 2", "France 3", "France 5", "M6", "Canal+", "BFM TV", "LCI", "France Info TV", "CNEWS", "TMC", "RMC Story", "RMC Découverte",
                             "C8", "Numéro 23",
                             "BFM TV", "C NEWS", "C8", "Euronews", "LCI", "M6", "RMC Découverte", "RMC Story", "RT France","TF1",
                             "France 2", "France 24", "France 3", "France 5", "France Info TV", "TV5Monde",
                             "Canal +", "C NEWS")
    )
}







