#' Open an issue
#'
#' Requires an user and an API key.
#' @param ... Named arguments passed to the API [check documentation](https://bugzilla.readthedocs.io/en/latest/api/core/v1/bug.html)
#' @return The ID of the issue.
post_bug <- function(description, summary, component, ...,
                    version, product, host) {
    # Fill description, version and summary
    version <- missing_version(version)
    host <- missing_host(host)
    product <- missing_product(product)
    stopifnot(is.numeric(issue), all(issue > 0))
    url <- paste0(host, "rest/bug")
    bugs <- httr::POST(url, product = product,
                       component = component,
                       summary = summary,
                       version = version,
                       ...,
                       headers)
    bugs <- httr::content(bugs)
}
