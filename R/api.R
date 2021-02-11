
#' @importFrom httr GET POST add_headers
headers <- httr::add_headers("X-BUGZILLA-API-KEY" = Sys.getenv("R_BUGZILLA"),
                       Application = "https://github.com/llrs/bugRzilla/")
# https://stackoverflow.com/questions/52997316/ and
# https://bugzilla.readthedocs.io/en/latest/api/core/v1/general.html#authentication
# gt <- httr::GET("https://bugs.r-project.org/bugzilla/rest/user/1", headers)

# Get data from endpoints
# Post comments/bugs (depend on reprex?)

#' Authentication
#'
#' Obtain an API key or check if it is working.
#' @param host URL of the bugzilla instance.
#' @param key API key to check.
#' @return TRUE invisibly if the actions are performed.
#' @rdname authentication
#' @export
create_bugzilla_key <- function(host = "https://bugs.r-project.org/bugzilla/") {
    url <- paste0(host, "userprefs.cgi?tab=apikey")
    browseURL(url)
    ui_todo(c(" Activate the API key and save it on .Renviron as R_BUGZILLA.\n",
            "\tusethis::edit_r_environ() might come handy"))
    ui_todo(" Restart R session so that changes take effect.")
    invisible(TRUE)
}

#' @name authentication
#' @export
check_authentication <- function(key = Sys.getenv("R_BUGZILLA"),
                                 host = "https://bugs.r-project.org/bugzilla/") {
    whoami <- httr::GET(paste0(host, "rest/whoami"),
                        httr::add_headers("X-BUGZILLA-API-KEY" = key,
                                          Application = "https://github.com/llrs/bugRzilla/"))
    if ("error" %in% names(httr::content(whoami))) {
        ui_fail(" Not authenticated.")
    }
    ui_done(" Authenticated!")
    invisible(TRUE)
}
