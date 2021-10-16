#' User information
#'
#' Retrieve information about users. Requires authentication.
#' @param ids Id of the users.
#' @param names Names of the users.
#' @inheritParams get_bug
#'
#' @return Information about the users
#' @export
#'
#' @examples
#' gu <- get_user(1)
get_user <- function(ids, names = NULL, host) {
    host <- missing_host(host)

    if (!missing(ids) && !is.null(names)) {
        stop("Choose either ids or names to search for users.", call. = FALSE)
    }

    if (!missing(ids) && length(ids) >= 1 && !is.numeric(ids)) {
        stop("Ids must be numeric.", call. = FALSE)
    } else if (!is.null(names) && length(names) >= 1 && !is.character(names)) {
        stop("names must be character.", call. = FALSE)
    }

    if (!missing(ids) && length(ids) > 1) {
        params <- paste0("?id=", paste0(ids, collapse = "&ids="))
    } else if (!is.null(names) && length(names) > 1) {
        params <- paste0("?names=", paste0(names, collapse = "&name="))
    }
    path <- "res/user"

    if (!missing(ids) && length(ids) == 1 || !is.null(names) && length(names) == 1) {
        path <- "res/user/"
        if (!missing(ids)) {
            params <- ids
        } else {
            params <- names
        }
    }

    browser()
    url <- paste0(host, path, params)
    users <- httr::GET(url, .state$headers)
    httr::stop_for_status(users)
    users <- httr::content(users)
}



