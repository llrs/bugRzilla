get_bug <- function(issue, host, new_since = NULL) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), issue > 0, length(issue) != 1)
    url <- paste0(host, "rest/bug/", issue, "/history")
     if (is.null(new_since)) {
         history <- httr::GET(url, headers)
     } else {
         history <- httr::GET(url, new_since = as.character(new_since), headers)

    }
    history <- httr::content(history)
}
