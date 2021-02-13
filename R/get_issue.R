#' Get information of a single issue
#'
#' Retrieve data of an issue from the xml file associated with it (Doesn't use
#' the API). Note that it is slower than get_comment() but provides more information.
#' @importFrom xml2 read_xml
#' @export
#' @param issue Number of the issue.
#' @inheritParams create_bugzilla_key
#' @return A data.frame with all the information available and ordered by comment.
#' @export
#' @seealso get_bug() for the equivalent using the API.
#' @examples
#' gi <- get_issue(1)
get_issue <- function(issue, host) {
    host <- missing_host(host)
    stopifnot(is.numeric(issue), issue > 0)
    host <- paste0(host, "show_bug.cgi?id=", issue,
           "&ctype=xml")
    xml <- xml2::read_xml(host)
    if (length(xml2::xml_attrs(xml_child(xml, "bug"))) != 0) {
        stop("Issue is not a valid bug Id.", call. = FALSE)
    }
    issue <- parse_issue(xml)
    cn <- colnames(issue)
    issue <- issue[, !cn %in% c("isprivate", "comment_sort_order")]
    issue[order(issue$comment_count), ]
}
