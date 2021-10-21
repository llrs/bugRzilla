#' User information
#'
#' Retrieve information about users. Requires authentication.
#' @param ids Id of the users.
#' @param names Names of the users. Should be without spaces and with the right encoding.
#' @inheritParams get_bug
#'
#' @return A data.frame with information about the users:
#' real name, id, groups, and if they can log in.
#' @export
#' @references <https://bugzilla.readthedocs.io/en/latest/api/core/v1/user.html#get-user>
#' @examples
#' dontrun{
#' use_key()
#' gu <- get_user(2)}
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

    path <- "rest/user"

    if (!missing(ids) && length(ids) == 1) {
        query <- NULL
        path <- paste0(path, "/", ids)
    } else if (!missing(ids) && length(ids) > 1) {
        query <- paste0("?ids=", paste0(ids, collapse = "&ids="))
    } else if(!is.null(names) && length(names) >= 1) {
        query <- paste0("?names=", paste0(names, collapse = "&names="))
    }

    url <- paste0(host, path, query)
    users <- httr::GET(url, .state$headers)
    httr::stop_for_status(users)
    u <- httr::content(users)
    users <- lapply(u$users, user)
    if (length(u$users) > 1) {
        users <- do.call(rbind, users)
    } else {
        users <- users[[1]]
    }
    users <- as.data.frame(users)
    users$id <- as.numeric(users$id)
    users$can_login <- as.logical(users$can_login)
    users
}


user <- function(x) {
    # We omit the name column as it contains the email and the group
    t(simplify2array(x[c("real_name", "id", "can_login")]))
}

