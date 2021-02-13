missing_host <- function(host) {
    if (missing(host)) {
        host <- "https://bugs.r-project.org/bugzilla/"
    }
    host
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
