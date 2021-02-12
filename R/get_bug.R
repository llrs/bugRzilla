#' Get information of issues
#'
#' Retrieve data from the issues posted.
#' @export
#' @param issue Number of the issue.
#' @inheritParams create_bugzilla_key
#' @return A data.frame with all the information available and ordered by comment.
#' @export
#' @seealso get_issue() for the equivalent without using the API.
#' @examples
#' gi <- get_bug(1)
get_bug <- function(issue, host) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), all(issue > 0))
    url <- paste0(host, "rest/bug")
    httr::handle(host)
    bugs <- httr::GET(host, path = "rest/bug", config = list(headers), id = issue,)
    bugs <- httr::content(bugs)
}
