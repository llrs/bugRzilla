#' Retrieve comment
#'
#' Get comments from an issue or by id of the comment.
#' @note It doesn't require being authenticated.
#' @param comment A character with the id of the comment eg. "1", can be
#' missing and it will retrieve all comments.
#' @inheritParams get_issue
#' @inheritParams create_bugzilla_key
#' @export
#' @return A `data.frame` with creation_time, text, creator, time,
#' attachment_id, bug_id.
#' @examples
#' i1 <- get_comment(issue = 1) # The comments on the first issue
#' c1 <- get_comment(comment = 1) # Just the first comment
get_comment <- function(issue, comment, host) {
    if (missing(issue) && missing(comment)) {
        stop("Provide an issue or a comment to retrieve from.")
    }
    host <- missing_host(host)
    if (missing(comment)) {
       comments <- get_commenti(issue = issue, host)
    }
    if (missing(issue)) {
        comments <- get_commentc(comment = comment, host)
    }

    comments$time <- as.POSIXct(comments$time)
    comments$creation_time <- as.POSIXct(comments$creation_time)
    comments
}

get_commentc <- function(comment, host) {
    stopifnot("comment must be a single number." = length(comment) == 1,
              "comment must be numeric." = is.numeric(comment))
    url <- paste0(host, "rest/bug/comment/", comment)
    comments <- httr::GET(url, headers)
    comments <- httr::content(comments)

    if ("error" %in% names(comments)) {
        stop(comments$message, call. = FALSE)
    }
    comment_df(comments$comments[[1]])
}

get_commenti <- function(issue, host) {
    stopifnot("issue must be a single number." = length(issue) == 1,
              "isue must be numeric." = is.numeric(issue))
    url <- paste0(host, "rest/bug/", issue, "/comment")
    comments <- httr::GET(url, headers)
    comments <- httr::content(comments)

    if ("error" %in% names(comments)) {
        stop(comments$message, call. = FALSE)
    }

    l <- lapply(comments$bugs[[1]]$comments, comment_df)
    do.call(rbind, l)
}

#' Post a comment
#'
#' Add information to a bug report.
#' @param is_markdown A logical value saying if it is markdown or not.
#' @inheritParams get_issue
#' @inheritParams get_comment
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
comment_df <- function(x) {
    x[lengths(x) == 0] <- list(NA)
    as.data.frame(x)}
