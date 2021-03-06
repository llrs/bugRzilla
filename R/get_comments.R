#' Retrieve comment
#'
#' Get comments from an issue or by id of the comment.
#' @note It doesn't require being authenticated.
#' @param comment A character with the id of the comment eg. "1", can be
#' missing and it will retrieve all comments.
#' @inheritParams get_bug
#' @inheritParams create_bugzilla_key
#' @export
#' @return A `data.frame` with creation_time, text, creator, time,
#' attachment_id, bug_id.
#' @examples
#' i1 <- get_comment(issue = 1) # The comments on the first issue
#' c1 <- get_comment(comment = 1) # Just the first comment
get_comment <- function(issue, comment, host) {
    if (missing(issue) && missing(comment)) {
        stop("Provide an issue or a comment to retrieve from.", call. = FALSE)
    }
    if (!missing(issue) && !missing(comment)) {
        warning("Issue ID is ignored", call. = FALSE)
    }
    host <- missing_host(host)
    if (missing(issue)) {
        comments <- get_commentc(comment = comment, host)
    } else {
       comments <- get_commenti(issue = issue, host)
    }

    comments$time <- time(comments$time)
    comments$creation_time <- time(comments$creation_time)
    comments
}

get_commentc <- function(comment, host) {
    stopifnot("comment must be a single number." = length(comment) == 1,
              "comment must be numeric." = is.numeric(comment))
    url <- paste0(host, "rest/bug/comment/", comment)
    comments <- httr::GET(url, .state$headers)
    httr::stop_for_status(comments)
    comments <- httr::content(comments)

    if ("error" %in% names(comments)) {
        stop(comments$message, call. = FALSE)
    }
    flatten_list(comments$comments[[1]])
}

get_commenti <- function(issue, host) {
    stopifnot("issue must be a single number." = length(issue) == 1,
              "isue must be numeric." = is.numeric(issue))
    url <- paste0(host, "rest/bug/", issue, "/comment")
    comments <- httr::GET(url, .state$headers)
    httr::stop_for_status(comments)
    comments <- httr::content(comments)

    if ("error" %in% names(comments)) {
        stop(comments$message, call. = FALSE)
    }

    l <- lapply(comments$bugs[[1]]$comments, flatten_list)
    do.call(rbind, l)
}

#' Post a comment
#'
#' Add information to a bug report.
#' @param is_markdown A logical value saying if it is markdown or not.
#' @param issue A numeric value of the issue ID where the comment should be
#' posted.
#' @param comment The text you want to post.
#' @inheritParams create_bugzilla_key
#' @return The ID of the comment posted.
#' @export
post_comment <- function(issue, comment, is_markdown, host, key) {
    stopifnot(!is.logical(is_markdown))
    host <- missing_host(host)
    headers <- set_headers(key)
    url <- paste0(host, "rest/bug/", issue, "/comment")
    # comments <- httr::POST(url,
    #                        comment = comment, is_markdown = is_markdown,
    #                        headers)
    # httr::content(comments)$id

}
