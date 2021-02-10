#' @importFrom xml2 xml_find_all xml_children xml_attrs xml_child
parse_issue <- function(xml) {
    stopifnot(is(xml, "xml_document"))

    xml2 <- xml2::xml_find_all(xml, "./bug/*")

    names <- xml2::xml_name(xml2)

    values <- xml2::xml_text(xml2[!names %in% c("long_desc", "attachment")])
    names(values) <- names[!names %in% c("long_desc", "attachment")]
    # See who performed the action
    # Only the reporter and the assigned_to has name as attribute
    who <- xml2::xml_attr(xml2[26:27], "name")
    names(who) <- c("reported_by", "assigned_by")
    values <- c(values, who)

    long_desc <- xml2[names %in% "long_desc"]
    ld <- sapply(long_desc, parse_long_desc)
    attachment <- xml2[names %in% "attachment"]
    at <- sapply(attachment, parse_attachment)
}


parse_long_desc <- function(x) {

}

parse_attachment <- function(x) {

}
