#' @importFrom xml2 xml_find_all xml_children xml_attrs xml_child
#' @importFrom methods is
parse_issue <- function(xml) {
    stopifnot(methods::is(xml, "xml_document"))

    xml2 <- xml2::xml_find_all(xml, "./bug/*")

    names <- xml2::xml_name(xml2)

    values <- xml2::xml_text(xml2[!names %in% c("long_desc", "attachment")])
    names(values) <- names[!names %in% c("long_desc", "attachment")]
    # See who performed the action
    # Only the reporter and the assigned_to has name as attribute
    who <- xml2::xml_attr(xml2, "name")
    who <- who[!is.na(who)]
    names(who) <- c("reported_by", "assigned_by")
    values <- c(values, who)

    long_desc <- xml2[names %in% "long_desc"]
    ld <- lapply(long_desc, parse_long_desc)
    comments <- as.data.frame(t(simplify2array(ld)))

    # Merge general information with comments
    values <- as.data.frame(as.list(values))
    out <- cbind.data.frame(comments, values)

    # Merge attachment information
    if (any(names %in% "attachment")) {
        attachment <- xml2[names %in% "attachment"]
        at <- lapply(attachment, parse_attachment)
        attachments <- as.data.frame(t(simplify2array(at)))
        out <- merge(out, attachments, all = TRUE, sort = FALSE,
                     by = "attachid", suffixes = c(".comment", ".attachment"))
        out$delta_ts.comment <- as.POSIXct(out$delta_ts.comment)
        out$delta_ts.attachment <- as.POSIXct(out$delta_ts.attachment)
        out$date <- as.POSIXct(out$date)
    }
    out$comment_count <- as.numeric(out$comment_count)
    out$commentid <- as.numeric(out$commentid)
    out$attachid <- as.numeric(out$attachid)
    out$bug_when <- as.POSIXct(out$bug_when)
    out$creation_ts <- as.POSIXct(out$creation_ts)
    out
}


parse_long_desc <- function(x) {
    x <- xml2::xml_children(x)
    values <- xml2::xml_text(x)
    names(values) <- xml2::xml_name(x)
    who <- xml2::xml_attr(xml2::xml_find_all(x, "./who"), "name")
    values <- c(values, "name" = who)
    if (!"attachid" %in% names(values)) {
        # Assumes that always there values appear on the same order
        values <- c(values[1:2], "attachid" =  NA, values[3:5])
    }
    values
}

parse_attachment <- function(x) {
    attachment_attr <- xml2::xml_attrs(x)
    x <- xml2::xml_children(x)
    values <- xml2::xml_text(x)
    names(values) <- xml2::xml_name(x)
    c(attachment_attr, values)
}
