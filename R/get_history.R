#' Provide information about the history of an issue.
#'
#' See what has changed of an issue.
#' @inheritParams get_bug
#' @param new_since A character with a Date in YYYY-MM-DD format.
#' @export
#' @importFrom httr status_code
#' @importFrom httr stop_for_status
#' @examples
#' get_history(issue = 1)
get_history <- function(issue, host, new_since = NULL) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), issue > 0, length(issue) == 1)
    url <- paste0(host, "rest/bug/", issue, "/history")
     if (is.null(new_since)) {
         history <- httr::GET(url, headers)
     } else {
         url <- paste(url, "?new_since=", new_since)
         history <- httr::GET(url, headers)
     }
    httr::stop_for_status(history)
    if (httr::status_code(history) != 200) {
        history <- httr::content(history)
        stop(history$message, call. = FALSE)
    }
    history <- httr::content(history)
    history <- history$bugs[[1]]$history
    l <- lapply(history, flatten_list)
    df <- do.call(rbind, l)
    df$when <- time(df$when)
    df$issue <- issue
    df
}
