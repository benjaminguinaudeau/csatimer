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

parse_odt <- function(link){
  inp <- textreadr::read_odt(link)

  tibble::tibble(raw = inp) %>%
    dplyr::mutate(time = str_extract(raw, "\\d{2}:\\d{2}:\\d{2}"),
                  is_info = !is.na(lead(time)) | !is.na(lead(time, 2)) | !is.na(time),
                  chunk_id = cumsum(is_info & is_info != lag(is_info, default = T)),
    ) %>%
    dplyr::group_by(chunk_id, is_info) %>%
    dplyr::mutate(pers_id = ifelse(!is_info, NA, cumsum(!is.na(lag(time, default = ""))))) %>%
    dplyr::group_by(chunk_id, is_info, pers_id) %>%
    dplyr::mutate(time = if(is_info[1]) raw[1] else NA_character_,
                  funct = if(is_info[1]) raw[2] else NA_character_,
                  name = if(is_info[1]) raw[3] else NA_character_,
                  type = if(!is_info[1]) raw[length(raw) - 3] else NA_character_,
                  channel = if(!is_info[1]) raw[length(raw) - 4] else NA_character_,
    ) %>%
    dplyr::ungroup() %>%
    tidyr::fill(type, channel, .direction = "down") %>%
    dplyr::filter(!is.na(time)) %>%
    dplyr::distinct(channel, type, name, funct, time, .keep_all = T) %>%
    glimpse

}
