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


#' @export
ideo_values <- c(
  "Far-Left" = "#f20519",
  "Left" = "#e3669e",
  "Center" = "#d589e8",
  "Right" = "#0D378A",
  "Far-Right" = "#06090a",
  "Government" = "#e0ce07",
  "Other" = "#aaadad"
)

#' @export
ideo_values_nogov <- c(
  "Far-Left" = "#f20519",
  "Left" = "#e3669e",
  "Center" = "#d589e8",
  "Right" = "#0D378A",
  "Far-Right" = "#06090a",
  "Other" = "#aaadad"
)


#' label_to_ideology
#' @export
label_to_ideology <- function(x){
  x %>%
    dplyr::mutate(ideology = case_when(
      name == "Zemmour Eric" ~ "Far-Right",
      label %in% c("Président De La République En Débat Politique",
                   "Président De La République Hors Débat Politique",
                   "Ministre", "Premier Ministre", "Secretaire Etat") ~ "Government",
      label %in% c("La France Insoumise", "Parti De Gauche", "Parti Communiste Français",
                   "Lutte Ouvrière", "Nouveau Parti Anticapitaliste") ~ "Far-Left",
      label %in% c("Génération.s", "EELV", "Divers Gauche", "Parti Socialiste", "Mouvement Du 1er Juillet",
                   "Parti Radical De Gauche", "Nouvelle Donne", "Place Publique",
                   "Nouvelle Gauche Socialiste", "Gauche Républicaine Et Socialiste",
                   "Gauche Démocrate Et Républicaine") ~ "Left",
      label %in% c( "La République En Marche", "Mouvement Démocrate", "Les Centristes",
                    "Territoires De Progrès", "Parti Ecologiste", "Divers Centre", "Génération Ecologie",
                    "Cap 21", "Cap Écologie", "Union des démocrates et des écologistes") ~ "Center",
      label %in% c("Les Républicains", "Divers Droite", "Union Des Démocrates Et Indépendants",
                   "Nouveau Centre", "Parti Chretien Democrate", "Chasse Pêche Nature et Tradition",
                   "Centre National Des Independants et Paysans", "Libres", "Agir", "Parti Radical") ~ "Right",
      label %in% c(  "Generation Identitaire", "Front National", "Debout La France",
                     "Les Patriotes", "Jeanne, Au Secours !", "Les Amis D'Éric Zemmour",
                     "Génération Z", "Rassemblement National", "Reconquête",
                     "Generation Frexit", "Mouvement pour la France") ~ "Far-Right"
    )) %>%
    dplyr::mutate(ideology = fct_relevel(ideology, "Government", "Far-Left", "Left", "Center", "Right", "Far-Right"))
}


cands_order <- c("Melenchon Jean Luc" , "Poutou Philippe" , "Arthaud Nathalie" , "Roussel Fabien" , "Hidalgo Anne",
                 "Jadot Yannick", "Taubira Christiane", "Macron Emmanuel", "Lassalle Jean", "Pecresse Valerie", "Zemmour Eric" ,
                 "Le Pen Marine" , "Philippot Florian" , "Dupont Aignan Nicolas")

#' candidat_to_ideology
#' @export
candidat_to_ideology <- function(x){
  x %>%
    mutate(
      ideology = case_when(
        candidat == "Melenchon Jean Luc" ~ "Far-Left",
        candidat == "Poutou Philippe" ~ "Far-Left",
        candidat == "Arthaud Nathalie" ~ "Far-Left",
        candidat == "Roussel Fabien" ~ "Far-Left",
        candidat == "Hidalgo Anne" ~ "Left",
        candidat == "Larrouturou Pierre" ~ "Left",
        candidat == "Montebourg Arnaud" ~ "Left",
        candidat == "Jadot Yannick" ~ "Left",
        candidat == "Taubira Christiane" ~ "Left",
        candidat == "Macron Emmanuel" ~ "Center",
        candidat == "Lassalle Jean" ~ "Center",
        candidat == "Pecresse Valerie" ~ "Right",
        candidat == "Zemmour Eric" ~ "Far-Right",
        candidat == "Le Pen Marine" ~ "Far-Right",
        candidat == "Philippot Florian" ~ "Far-Right",
        candidat == "Dupont Aignan Nicolas" ~ "Far-Right",
        T ~ "Other"
      ),
      ideology = fct_relevel(ideology, "Far-Left", "Left", "Center", "Right", "Far-Right"),
      candidat = ifelse(candidat %in% cands_order, candidat, "Autres") %>%
        factor %>%
        fct_relevel(c("Autres", cands_order)))
}



# add_ideology <- function(.tbl){
#   .tbl %>%
#     dplyr::mutate(
#       ideology = dplyr::case_when(
#         party == "Exécutif" ~ "Government",
#         party %in% c("LFI", "PCF") ~ "Far left",
#         party %in% c("PS", "EELV", "Gauche") ~ "Left",
#         party %in% c("MODEM", "LREM") ~ "Center",
#         party %in% c("LR", "Libres", "Droite", "UDI") ~ "Right",
#         party %in% c("RN", "DlF", "FN", "Mouvement pour la France") ~ "Far right",
#         label %in% c("Agir", "Chasse Pêche Nature et Tradition", "Parti Chretien Democrate") ~ "Right",
#         label %in% c("Les Centristes", "Divers Centre", "Mouvement Radical", "CAP 21", "Cap 21", "Union des démocrates et des écologistes") ~ "Center",
#         label %in% c("Secretaire Etat") ~ "Government",
#         label %in% c("Génération.s", "Gauche Républicaine Et Socialiste", "Parti Radical De Gauche", "Place Publique", "Les Radicaux De Gauche", "Nouvelle Donne",
#                      "Parti De Gauche", "Gauche Démocrate Et Républicaine", "Génération Ecologie", "Territoires De Progrès") ~ "Left",
#         label %in% c("Nouveau Parti Anticapitaliste", "Lutte Ouvrière") ~ "Far left",
#         label %in% c("Les Patriotes", "Jeanne, Au Secours !", "Les Amis D'Éric Zemmour", "Génération Z", "Generation Identitaire") ~ "Far right",
#         T ~ "Other"
#       ),
#       ideology = factor(ideology) %>% forcats::fct_relevel("Government", "Far left", "Left", "Center", "Right", "Far right", "Other")
#     )
#
# }





