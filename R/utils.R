missing_host <- function(host) {
    if (missing(host)) {
        host <- "https://bugs.r-project.org/bugzilla/"
    }
    host
}

missing_key <- function(key) {
    if (missing(key)) {
        key <- "R_BUGZILLA"
    }
    key
}

missing_version <- function(version) {
    if (missing(version)) {
        ver <- R.Version()[c("major", "minor")]
        if (ver$minor != "0.0") {
            ver$minor <- "0.x"
        }
        version <- paste0(ver, collapse = ".")
    }
    version
}

missing_product <- function(product) {
    if (missing(product)) {
        product <- "R"
    }
    product
}


flatten_list <- function(x) {
    x[lengths(x) == 0] <- list(NA)
    special <- c("creator_detail", "assigned_to_detail", "depends_on",
                 "cc_detail", "cc", "changes", "keywords")
    df <- as.data.frame(x[!names(x) %in% special])
    # If there is a list of multiple elements add it as a list of data.frames.

    if ("depends_on" %in% names(x)) {
        df$depends_on <- list(unlist(x$depends_on,
                                    recursive = FALSE,
                                    use.names = FALSE))
    }
    if ("cc" %in% names(x)) {
        df$cc <- list(unlist(x$cc, recursive = FALSE, use.names = FALSE))
    }
    if ("keywords" %in% names(x)) {
        df$keywords <- list(unlist(x$keywords, recursive = FALSE, use.names = FALSE))
    }
    if ("cc_detail" %in% names(x)) {
        df$cc_detail <- list(as.data.frame(x$cc_detail))
    }
    if ("creator_detail" %in% names(x)) {
        df$creator_detail <- list(as.data.frame(x$creator_detail))
    }
    if ("changes" %in% names(x)) {
        if (length(x$changes) == 1) {
            df$changes <- list(as.data.frame(x$changes))
        } else {
            df$changes <- list(lapply(x$changes, as.data.frame))
        }
    }
    if ("assigned_to_detail" %in% names(x)) {
        df$assigned_to_detail <- list(as.data.frame(x$assigned_to_detail))
    }
    df
}

time <- function(x) {
    strptime(x, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
}
