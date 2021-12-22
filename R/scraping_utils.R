parse_index_page <- function(page){
  date <- page %>%
    rvest::html_nodes("td:nth-child(1)") %>%
    purrr::map_chr(~.x %>% rvest::html_text())

  title <- page %>%
    rvest::html_nodes("td:nth-child(2)") %>%
    purrr::map_chr(~.x %>% rvest::html_text())

  pdf_link <- page %>%
    rvest::html_nodes("td:nth-child(3)") %>%
    purrr::map_chr(~.x %>% rvest::html_node("a") %>% rvest::html_attr("href"))

  tabular_link <- page %>%
    rvest::html_nodes("td:nth-child(4)") %>%
    purrr::map_chr(~.x %>% rvest::html_node("a") %>% rvest::html_attr("href"))

  tibble::tibble(date,title, pdf_link, tabular_link)
}

parse_odt_perso <- function(link, month = ""){
  inp <- textreadr::read_odt(link)


  tibble::tibble(raw = inp) %>%
    dplyr::mutate(time = str_extract(raw, "\\d{2}:\\d{2}:\\d{2}"),
                  is_info = !is.na(lead(time)) | !is.na(lead(time, 2)) | !is.na(time),
                  chunk_id = cumsum(is_info & is_info != lag(is_info, default = T)),
    ) %>%
    dplyr::group_by(chunk_id, is_info) %>%
    dplyr::mutate(pers_id = ifelse(!is_info, NA, cumsum(!is.na(lag(time, default = ""))))) %>%
    dplyr::group_by(chunk_id, is_info, pers_id) %>%
    dplyr::mutate(time = if(is_info[1] && length(raw) > 0) raw[1] else NA_character_,
                  funct = if(is_info[1] && length(raw) > 1) raw[2] else NA_character_,
                  name = if(is_info[1] && length(raw) > 2) raw[3] else NA_character_,
                  type = if(!is_info[1] && length(raw) > 3) raw[length(raw) - 3] else NA_character_,
                  channel = if(!is_info[1] && length(raw) > 4) raw[length(raw) - 4] else NA_character_,
    ) %>%
    dplyr::ungroup() %>%
    tidyr::fill(type, channel, .direction = "down") %>%
    dplyr::filter(!is.na(time)) %>%
    dplyr::distinct(channel, type, name, funct, time, .keep_all = T) %>%
    select(channel, type, name, funct, time) %>%
    rename(name = time, time = name) %>%
    mutate(month = !!month,
           first_dig = 60*as.numeric(str_extract(time, "\\d+")) + as.numeric(str_extract(time, "(?<=\\:)\\d+")),
           channel = ifelse(first_dig > lag(first_dig, default = 0), "T", NA_character_)) %>%
    select(-first_dig) %>%
    glimpse

}

# inp %>%
#   tabulizer::extract_tables() %>%
#   purrr::map_dfr(parse_case) %>%
#   dplyr::mutate(type = tidyr:::fillDown(type)) %>%
#   dplyr::glimpse()
#
# parse_case <- function(x){
#   type <- x[1, 1]
#   if(length(intersect(c("Intervenant","Appartenance", "Durée"), x[1, ])) > 0){
#     x <- x[-1, ]
#   } else {
#     type <- NA_character_
#   }
#
#   x_ <- x %>%
#     as_tibble() %>%
#     select_if(~any(.x != ""))
#
#   tibble::tibble(
#     channel = c("T", rep(NA_character_, nrow(x_) - 1)),
#     type = type ,
#     name = x_[[1]],
#     func = x_[[2]],
#     time = x_[[3]]
#   )
# }

parse_pdf_perso <- function(link, month = "00/2021"){
  pdftools::pdf_text(link) %>%
    str_split("\n+") %>%
    map_dfr(~tibble::tibble(text = str_trim(.x))) %>%
    mutate(new_table = ifelse(str_detect(text, "\\d{2}\\:\\d{2}\\:\\d{2}"), NA_character_, "T")) %>%
    filter(is.na(new_table) | lead(is.na(new_table))) %>%
    mutate(type = tidyr:::fillDown(lag(ifelse(new_table, str_extract(text, "\\w+"), NA_character_))),
           new_table = lag(new_table)) %>%
    filter(str_detect(text, "\\d{2}\\:\\d{2}\\:\\d{2}")) %>%
    separate(text, into = c("name", "funct", "time"), sep = "\\s{2,}") %>%
    select(channel = new_table, type, name, funct, time) %>%
    mutate(month = {{month}},
           first_dig = 60*as.numeric(str_extract(time, "\\d+")) + as.numeric(str_extract(time, "(?<=\\:)\\d+")),
           channel = ifelse(first_dig > lag(first_dig, default = 0), "T", NA_character_)) %>%
    select(-first_dig)

}
