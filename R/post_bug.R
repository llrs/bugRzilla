
components <- c("Accuracy", "Add-ons", "Analyses", "Documentation", "Graphics",
                "I/O", "Installation", "Language", "Low-level",
                "Mac GUI/Mac specific", "Misc",
                "Models", "S4methods", "Startup", "System-specific",
                "Translations", "Windows GUI/Window specific", "Wishlist")
#' Open an issue.
#'
#' Guides through the process of creating an issue.
#' Requires an user and an API key. `post_r_bug` is a helper with some checks
#' and advice before submitting issues to the R Bugzilla database.
#'
#' Many arguments can be passed, read the documentation on the reference to
#' @param text A character vector with the text of the bug you want to
#' open.
#' @param title A character vector with the title of the bug.
#' @param component A character with the component of R you want to fill an issue with.
#' If you omit it while using the `post_r_bug` you will be prompted to fill it.
#' @param version A character of the version you want to use eg "R 4.0.0".
#' If omitted on post_r_bug it will be automatically assumed to be from the version of R being used.
#' @param product A character of the product you want to use if missing "R" is
#' automatically filled.
#' @param is_markdown Is using markdown formatting? True by default.
#' @param ... Named arguments passed to the API [check documentation](https://bugzilla.readthedocs.io/en/latest/api/core/v1/bug.html)
#' @inheritParams create_bugzilla_key
#' @importFrom utils menu
#' @importFrom cli cli_alert
#' @export
#' @seealso To obtain and use the API key see create_bugzilla_key().
#' [Webpage](https://bugs.r-project.org/bugzilla/enter_bug.cgi) for manual entry
#' @return The ID of the issue posted. NULL if the user doesn't follow the advice.
#' @references API parameters: <https://bugzilla.readthedocs.io/en/latest/api/core/v1/bug.html#create-bug>
#' Markdown allowed: <https://bugs.r-project.org/page.cgi?id=markdown.html>
post_bug <- function(title, text, component, version, product, ..., is_markdown = TRUE,
                    host, key) {
    title <- paste("BugRzilla:", title)
    if (Sys.getenv("RBUGZILLA") == "" & product == "R") {
        stop("To post to the R bugzilla use the post_r_bug function.",
             call. = FALSE)
    } else if (Sys.getenv("RBUGZILLA") != "" & product == "R") {
        ask_final_confirmation()
    } else {
        ask_confirmation("Are you really sure?")
    }
    url <- paste0(host, "rest/bug")
    bugs <- httr::POST(url,
                       body = list(
                           description = text,
                           product = product,
                           component = component,
                           summary = title,
                           version = version,
                           is_markdown = is_markdown,
                           ...),
                       encode = "json",
                       config = set_headers(key))
    if (httr::http_error(bugs)) {
        stop("You probably didn't use the right columns or values.\n",
             "  Check the API documentation as it says:\n\t",
             httr::content(bugs)$message, call. = FALSE)
    }
    bugs <- httr::content(bugs)
    bugs$id
}

#' @export
#' @rdname post_bug
post_r_bug <- function(title, text, component, version, ..., key) {
    # Provide some checks/questions to the users
    # Fill description, version and summary
    if (missing(component)) {
        cli::cli_alert("Please, pick a component:")
        component <- menu(components)
        component <- components[component]
    }
    version <- missing_version(version)
    Sys.setenv("RBUGZILLA" = "a")
    on.exit(Sys.unsetenv("RBUGZILLA"), add = TRUE)
    if (read_documentation() == "Cancel") {
        return()
    }
    if (ask_research() == "Cancel") {
        return()
    }
    if (about_content() == "Cancel") {
        return()
    }
    post_bug(title = title,
             text = text,
             component = component,
             version = version,
             product = "R",
             # To replace when going into production by: "https://bugs.r-project.org/bugzilla/"
             host = "https://rbugs-devel.urbanek.info/",
             key = missing_key(key),
             ...)
}
