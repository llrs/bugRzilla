#' Retrieve information about attachments
#'
#' Given an issue or an attachment
#' @inheritParams get_comment
#' @param attachment A numeric ID of the attachment.
#' @return A data.frame with the information available.
#' @export
#' @examples
#' get_attachment(issue = 1)
#' get_attachment(attachment = 1)
get_attachment <- function(issue, attachment, host) {
    host <- missing_host(host)
    if (missing(issue) & missing(attachment)) {
        stop("Both issue and attachment can't be missing", call. = FALSE)
    }
    if (!missing(issue) & !missing(attachment)) {
        warning("Issue ID is ignored", call. = FALSE)
    }
    if (missing(issue)) {
        attachment <- get_attachmenta(attachment, host)
    } else {
        attachment <- get_attachmenti(issue, host)
    }
    attachment$last_change_time <- time(attachment$last_change_time)
    attachment$creation_time <- time(attachment$creation_time)
    attachment
}

get_attachmenti <- function(issue, host) {
    url <- paste0(host, "rest/bug/", issue, "/attachment")
    attachments <- httr::GET(url, headers)
    attachments <- httr::content(attachments)
    attachments <- attachments$bugs[[1]]
    for (i in seq_along(attachments)) {
        x <- flatten_list(attachments[[i]])
        attachments[[i]] <- x[, match(names(attachments[[i]]), colnames(x))]
    }

    do.call(rbind, attachments)
}

get_attachmenta <- function(attachment, host){
    url <- paste0(host, "rest/bug/attachment/", attachment)
    attachments <- httr::GET(url, headers)
    attachments <- httr::content(attachments)
    flatten_list(attachments$attachments[[1]])
}
