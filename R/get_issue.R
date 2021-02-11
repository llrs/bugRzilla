#' Get information of a single issue
#' @importFrom xml2 read_xml
#' @export
#' @param issue Number of the issue
#' @param host Url of the website.
#' @examples
#' gi <- get_issue(1)
get_issue <- function(issue, host) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), issue > 0)
    host <- paste0(host, "show_bug.cgi?id=", issue,
           "&ctype=xml")
    xml <- xml2::read_xml(host)
    issue <- parse_issue(xml)
    cn <- colnames(issue)
    issue <- issue[, !cn %in% c("isprivate", "comment_sort_order")]
    issue[order(issue$comment_count), ]
}
