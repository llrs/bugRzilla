get_attachment <- function(issue, host) {
    host <- missing_host(host)
    url <- paste0(host, "rest/bug/", issue, "/attachment")
    attachments <- httr::GET(url, headers)
    attachments <- httr::content(attachments)
    l <- lapply(attachments$bugs, function(x){
        x[[1]][lengths(x[[1]]) == 0] <- list("")
        as.data.frame(x[[1]])})
    do.call(rbind, l)
}

get_attachment <- function(attachment, host){
    host <- missing_host(host)
    url <- paste0(host, "rest/bug/attachment/", attachment)
    attachments <- httr::GET(url, headers)
    attachments <- httr::content(attachments)
    l <- lapply(attachments$bugs, function(x){
        x[[1]][lengths(x[[1]]) == 0] <- list("")
        as.data.frame(x[[1]])})
    do.call(rbind, l)
}
