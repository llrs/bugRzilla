get_bug <- function(issue, host) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), all(issue > 0))
    url <- paste0(host, "rest/bug")
    bugs <- httr::GET(url, id = issue, headers)
    bugs <- httr::content(bugs)
}
