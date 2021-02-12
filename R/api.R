
# https://stackoverflow.com/questions/52997316/ and
# https://bugzilla.readthedocs.io/en/latest/api/core/v1/general.html#authentication
#' @importFrom httr GET POST add_headers
headers <- httr::add_headers("X-BUGZILLA-API-KEY" = Sys.getenv("R_BUGZILLA"),
                       Application = "https://github.com/llrs/bugRzilla/")


#' Authentication
#'
#' Obtain an API key or check if it is working.
#' @param host URL of the bugzilla instance if missing the R bugzilla is assumed.
#' @param key API key to check.
#' @return TRUE invisibly if the actions are performed.
#' @rdname authentication
#' @importFrom cli cli_ul
#' @importFrom utils browseURL
#' @export
create_bugzilla_key <- function(host) {
    host <- missing_host(host)
    url <- paste0(host, "userprefs.cgi?tab=apikey")

    if (!nzchar(Sys.getenv("R_BUGZILLA"))) {
        cli::cli_alert_warning("Already found an API key.")
        return(invisible(TRUE))
    }
    browseURL(url)
    msg <- c("Activate the API key and save it on .Renviron as R_BUGZILLA.\n",
             "\t{.code usethis::edit_r_environ()} might come handy")
    cli::cli_ul(paste0(msg, collapse = ""))
    cli::cli_ul("Restart R session so that changes take effect.")
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
                                          Application = "https://github.com/llrs/bugRzilla/"))
    if ("error" %in% names(httr::content(whoami))) {
        cli::cli_alert_danger("Not authenticated.")
    }
    cli::cli_alert_success("Authenticated!")
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
