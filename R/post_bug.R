
components <- c("Accuracy", "Add-ons", "Analyses", "Documentation", "Graphics",
                "I/O", "Installation", "Language", "Low-level",
                "Mac GUI/Mac specific", "Misc",
                "Models", "S4methods", "Startup", "System-specific",
                "Translations", "Windows GUI/Window specific", "Wishlist")
#' Open an issue.
#'
#' Guides through the process of creating an issue.
#' Requires an user and an API key.
#' @param text A character vector with the text of the bug you want to
#' open.
#' @param title A character vector with the title of the bug.
#' @param component A character with the component of R you want to fill an issue with.
#' @param version A character of the Version you want to use eg "R 4.0.0".
#' @param product A character of the product you want to use if missing "R" is
#' automatically filled.
#' @param ... Named arguments passed to the API [check documentation](https://bugzilla.readthedocs.io/en/latest/api/core/v1/bug.html)
#' @inheritParams create_bugzilla_key
#' @importFrom utils select.list
#' @export
#' @seealso To obtain and use the API key see create_bugzilla_key().
#' [Webpage](https://bugs.r-project.org/bugzilla/enter_bug.cgi) for manual entry
#' @return The ID of the issue posted.
post_bug <- function(text, title, component, ...,
                    version, product, host) {
    # Provide some checks/questions to the users
    # Fill description, version and summary
    if (missing(component)) {
        if (getOption("menu.graphics")) {
            component <- select.list(components,
                                     title = "Pick a component")
        } else {
            cli::cli_alert("Please, pick a component:")
            component <- select.list(components)
        }
    }
    component <- match.arg(component, components)
    version <- missing_version(version)
    host <- missing_host(host)
    product <- missing_product(product)
    url <- paste0(host, "rest/bug")
    bugs <- httr::POST(url,
                       description = text,
                       product = product,
                       component = component,
                       summary = title,
                       version = version,
                       ...,
                       headers)
    bugs <- httr::content(bugs)
}