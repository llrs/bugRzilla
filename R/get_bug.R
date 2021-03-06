#' Get information of issues
#'
#' Retrieve data from the issues posted.
#' @export
#' @param issue Number of the issue.
#' @inheritParams create_bugzilla_key
#' @return A data.frame with all the information available and ordered by comment.
#' @export
#' @examples
#' gi <- get_bug(1)
get_bug <- function(issue, host) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), all(issue > 0))
    issues <- paste0(issue, collapse = ",")
    url <- paste0(host, "rest/bug?id=", issues)
    bugs <- httr::GET(url, .state$headers)
    httr::stop_for_status(bugs)
    bugs <- httr::content(bugs)

    if ("error" %in% names(bugs)) {
        stop("Query too long. Reduce the number of issues requested",
             call. = FALSE)
    }

    bugs <- bugs$bugs
    if (length(bugs) == 0) {
        stop("Bug #", issue, " does not exist.", call. = FALSE)
    }

    for (i in seq_along(bugs)) {
        x <- flatten_list(bugs[[i]])
        bugs[[i]] <- x[, match(names(bugs[[i]]), colnames(x))]
    }
    out <- do.call(rbind, bugs)
    out$creation_time <- time(out$creation_time)
    out$last_change_time <- time(out$last_change_time)
    out
}
