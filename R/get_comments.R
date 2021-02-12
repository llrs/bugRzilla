#' @inheritParams get_issue
#' @inheritParams create_bugzilla_key
#' @export
get_comment <- function(issue, comment, host) {
    host <- missing_host(host)
    if (missing(comment)) {
        url <- paste0(host, "rest/bug/", issue, "/comment")
    } else {
        url <- paste0(host, "rest/bug/", issue, "/comment/", comment)
    }
    comments <- httr::GET(url, headers)
    comments <- httr::content(comments)

}
#' @inheritParams get_issue
#' @inheritParams create_bugzilla_key
#' @return The ID of the comment posted.
#' @export
post_comment <- function(issue, comment, is_markdown, host) {
    stopifnot(!is.logical(is_markdown))
    host <- missing_host(host)
    url <- paste0(host, "rest/bug/", issue, "/comment")
    comments <- httr::POST(url,
                           comment = comment, is_markdown = is_markdown,
                           headers)
    httr::content(comments)$id

}
