missing_key <- function(key) {
    if (missing(key)) {
        key <- "R_BUGZILLA"
    }
    key
}

#' Authentication
#'
#' Obtain an API key or check if it can fine one that works for this host and
#' the version of the bugzilla provided works with this package.
#' @param host URL of the bugzilla instance if missing the R bugzilla is assumed.
#' @param key API key to check.
#' @return TRUE invisibly if the actions are performed.
#' @seealso set_key() if you want to temporary use an API key.
#' @rdname authentication
#' @importFrom cli cli_ul
#' @importFrom utils browseURL
#' @export
create_bugzilla_key <- function(host) {
    host <- missing_host(host)
    url <- paste0(host, "userprefs.cgi?tab=apikey")
    if (check_api_version(host)) {
        msg <- "This package hasn't been tested with this Bugzilla version."
        cli::cli_alert_warning(msg)
    }
    if (set_key()) {
        check_authentication(host = host)
        return(invisible(TRUE))
    }
    browseURL(url)
    cli::cli_ul("Create the API key on the website.")
    cli::cli_ul("And use {.code set_key} to save it and get ready to use.")
    invisible(TRUE)
}

#' Set key to use
#'
#' If you don't want to have the API key on .Renviron or you want to use another
#' API key for bugzilla you can set it up this way. It will store the key in the
#' envirnoment which will only work for this R session.
#' @param key The API key you want to use.
#' @param key_name The name of the API key, by default "R_BUGZILLA".
#' @return TRUE
#' @importFrom rappdirs user_cache_dir
#' @export
set_key <- function(key, key_name = "R_BUGZILLA") {

    if (!check_key(key_name) && valid_key(key)) {
        write_renviron(key = key_name, value = key, file = app_file())
    }
    use_key(key_name)
    invisible(TRUE)
}

check_key <- function(key_name, verbose = TRUE) {
    path <- app_file()
    if (file.exists(path)) {
        if (verbose) {
            cli::cli_alert_info("Reading cached keys on {.path {path}}.")
        }
        readRenviron(path)
    }
    key <- Sys.getenv(key_name)
    if (key == "") {
        if (verbose) {
            cli_alert_danger("Key {.code {key_name}} not found on {.path {path}}.")
        }
        return(FALSE)
    }
    if (verbose) {
        cli_alert_success("Found key {.code {key_name}}.")
    }
    return(TRUE)

}

#' @rdname set_key
use_key <- function(key_name = "R_BUGZILLA") {
    if (!check_key(key_name, verbose = FALSE)) {
        cli_alert_danger("Key {.code {key_name}} not found. Use {.code set_key()}")
        return(invisible(FALSE))
    }
    cli_alert_success("Using key {.code {key_name}}.")
    .state$headers <- set_headers(key_name)
    return(invisible(TRUE))
}

# https://stackoverflow.com/questions/52997316/ and
# https://bugzilla.readthedocs.io/en/latest/api/core/v1/general.html#authentication
#' @importFrom httr GET POST add_headers
set_headers <- function(key) {
    key <- missing_key(key)
    httr::add_headers(
        "X-BUGZILLA-API-KEY" = Sys.getenv(key),
        "User-Agent" = "https://github.com/llrs/bugRzilla/")
}

.state <- new.env(parent = emptyenv())


app_file <- function() {
    path <- rappdirs::user_cache_dir("bugRzilla")
    dir.create(path, showWarnings = FALSE, recursive = TRUE)
    file.path(normalizePath(path), ".Renviron")
}


# use_key <- function(){
#     path <- app_file()
#     file <- strsplit(readLines(path), split = "=", fixed = TRUE)
#     key <- vector("characer", length(file))
#     value <- vector("character", length(file))
#     for (i in seq_along(file)) {
#         key[i] <- file[[i]][1]
#         value[i] <- file[[i]][2]
#     }
#     message("choose a key:")
#     key[tools::menu(key)]
# }

write_renviron <- function(key, value, file) {
    if (!dir.exists(dirname(file))) {
        dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
        file.create(file)
    }
    msg <- paste(key, value, sep = "=")
    msg <- paste0(msg, "\n")
    cli_alert_success("Storing key on {.path {file}}.")
    cat(msg, file = file, append = TRUE)
}

#' @rdname authentication
#' @importFrom cli cli_alert_danger cli_alert_success
#' @export
#' @examples
#' check_authentication()
check_authentication <- function(key = Sys.getenv("R_BUGZILLA"), host) {
    host <- missing_host(host)
    whoami <- httr::GET(paste0(host, "rest/whoami"),
                        httr::add_headers("X-BUGZILLA-API-KEY" = key,
                                          "User-agent" = "https://github.com/llrs/bugRzilla/"))
    if ("error" %in% names(httr::content(whoami))) {
        cli::cli_alert_danger("Not authenticated on this site.")
    }
    cli::cli_alert_success("Authenticated on this site!")
    invisible(TRUE)
}

#' Check API version
#'
#' Check if the package is compatible with the API it points to.
#' @inheritParams create_bugzilla_key
#' @return TRUE if it matches with the version developed, FALSE if inot.
#' @export
#' @examples
#' check_api_version()
check_api_version <- function(host) {
    host <- missing_host(host)
    version <- httr::GET(paste0(host, "rest/version"))
    httr::stop_for_status(version)
    httr::content(version)$version != "5.1.2+"
}

#' Check last audit
#'
#' Check when was the last audit.
#' @inheritParams create_bugzilla_key
#' @param product A character of the product you are reporting about.
#' @return A date.
#' @export
#' @examples
#' check_last_audit()
check_last_audit <- function(product, host) {
    host <- missing_host(host)
    product <- missing_product(product)
    audit <- httr::GET(paste0(host, "rest/last_audit_time"),
                         class = product)
    httr::stop_for_status(audit)
    time(httr::content(audit)$last_audit_time)
}


valid_key <- function(key) {
    if (key == "" & nchar(key) != 40) {
        cli::cli_alert_danger("Key not valid or not set.")
        return(FALSE)
    }
    TRUE
}
