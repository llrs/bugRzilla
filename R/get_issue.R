#' Get information of a single issue
#' @importFrom xml2 read_xml
#' @export
#' @param issue Number of the issue
#' @param url Url of the website.
#' @examples
#' gi <- get_issue(1)
get_issue <- function(issue, url = "https://bugs.r-project.org/bugzilla/") {
    stopifnot(is.numeric(issue),
              issue > 0)
    url <- paste0(url, "show_bug.cgi?id=", issue,
           "&ctype=xml")
    xml <- xml2::read_xml(url)
    parse_issue(xml)
}
