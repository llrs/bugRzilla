
# https://stackoverflow.com/questions/52997316/ and
# https://bugzilla.readthedocs.io/en/latest/api/core/v1/general.html#authentication
#' @importFrom httr GET POST add_headers
headers <- httr::add_headers("X-BUGZILLA-API-KEY" = Sys.getenv("R_BUGZILLA"),
                       "User-Agent" = "https://github.com/llrs/bugRzilla/")

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
    msg <- c("Activate the API key and save it on .Renviron as R_BUGZILLA.\n",
             "\t{.code usethis::edit_r_environ()} might come handy")
    cli::cli_ul(paste0(msg, collapse = ""))
    cli::cli_ul("Restart R session so that changes take effect.")
    cli::cli_alert_info("Or use {.code set_key} to use it only for this session.")
    invisible(TRUE)
}

#' Set key to use
#'
#' If you don't want to have the API key on .Renviron or you want to use another
#' API key for bugzilla you can set it up this way. It will store the key in the
#' envirnoment which will only work for this R session.
#' @param key The API key you want to use.
#' @return TRUE
#' @export
set_key <- function(key = Sys.getenv("R_BUGZILLA")) {
    if (!valid_key(key)) {
        return(invisible(FALSE))
    }
    Sys.setenv("R_BUGZILLA" = key)
    cli::cli_alert_success("Key set for this session.")
    invisible(TRUE)
}

#' @rdname authentication
#' @importFrom cli cli_alert_danger cli_alert_success
#' @export
check_authentication <- function(key = Sys.getenv("R_BUGZILLA"), host) {
    host <- missing_host(host)
    httr::handle(host)
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
    as.POSIXct(httr::content(audit)$last_audit_time)
}


valid_key <- function(key) {
    if (key == "" & nchar(key) != 40) {
        cli::cli_alert_danger("Key not valid or not set.")
        return(FALSE)
    }
    TRUE
}
