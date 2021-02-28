bug_search <- function(..., host) {
    host <- missing_host(host)
    params <- params(...)

    url <- paste0(host, "rest/bug?", params)
    bugs <- httr::GET(url, .state$headers)
    message(url)
    httr::stop_for_status(bugs)
    bugs <- httr::content(bugs)
    bugs <- bugs$bugs
    if (length(bugs) == 0) {
        stop("Bug with this parameters do not exist.", call. = FALSE)
    }

    for (i in seq_along(bugs)) {
        x <- flatten_list(bugs[[i]])
        bugs[[i]] <- x[, match(names(bugs[[i]]), colnames(x))]
    }
    out <- do.call(rbind, bugs)
    out$creation_time <- time(out$creation_time)
    out$last_change_time <- time(out$last_change_time)
    out
}


valid_parameters <- c("alias", "assigned_to", "component", "creation_time",
                      "creator", "id", "last_change_time", "limit",
                      "longdescs.count", "offset", "op_sys", "platform",
                      "priority", "product", "resolution", "severity",
                      "status", "summary", "tags", "target_milestone",
                      "qa_contact", "url", "version", "whiteboard",
                      "quicksearch")

params <- function(...) {
    l <- list(...)
    names_parameters <- names(l)
    if (any(!names_parameters %in% valid_parameters)) {
        stop("Invalid parameter. Check the valid parameters", call. = FALSE)
    }
    names <- rep(names(l), lengths(l))
    parameters <- unlist(l, recursive = FALSE, use.names = FALSE)
    p <- sum(lengths(l))
    l2 <- vector("character", p)
    for (param in seq_len(p)) {
        l2[[param]] <- paste(names[[param]], parameters[[param]], sep = "=")
    }
    paste0(l2, collapse = "&")
}



