
official_documentation <- c(
    "https://www.r-project.org/bugs.html",
    "https://mac.r-project.org/man/R-FAQ.html#R-Bugs",
    "https://bugs.r-project.org/bugzilla/page.cgi?id=bug-writing.html")

read_documentation <- function() {
    cli::cat_rule("Documentation")
    cli::cli_alert("Have you read the documentation recently?\n")
    cli::cat_line("(0 to cancel)")
    answer <- ask_confirmation()
    if (answer %in% no) {
        cli::cli_alert_success("Opening documentation...")
        lapply(official_documentation, browseURL)
        stop("Do it and then return please.", call. =  FALSE)
    }
    invisible(answer)
}


yes <- c("Yes", "Definitely", "Positive", "For sure", "Yup", "Yeah",
         "Absolutely")
no <- c("Not sure", "Not now", "Negative", "No", "Nope", "Absolutely not")

ask_confirmation <- function(title = NULL, positive = yes, negative = no) {
    options <- c(sample(positive, 1), sample(negative, 2)) # Mix which ones
    options <- sample(options, 3) # Random order
    sel <- menu(options, title = title)
    invisible(c("Cancel", options)[sel + 1])
}

#' @importFrom cli cat_rule
ask_research <- function() {
    cli::cat_rule("Previous research")
    cli::cli_ul("Did you search for similar issues?")
    cli::cli_ul("Did you search on the mailing list archive?")
    cli::cli_ul("Did you search on forums and different sites?")
    cli::cli_alert("Are all the above questions affirmative?")
    answer <- ask_confirmation()
    if (answer %in% no) {
        stop("Do it, later if you are still sure it is a bug then return please.",
            call. =  FALSE)
    } else if (answer == "Cancel") {
        return(invisible(NULL))
    }
    invisible(answer)
}


about_content <- function() {
    cli::cli_rule("Content of the issue")
    cli_alert("Do you provide a short reproducible example of the issue?")
    cli::cat_line("Maybe first check with the R-devel mailing list")
    cli_alert("Is this issue about R and not a package?")
    cli_alert("Do you explain expectations and the buggy behaviour?")
    cli_alert("Did you try to identify the cause of the bug?")
    ask_confirmation("Are all the answers above positive?")
}


ask_final_confirmation <- function(message) {
    cli::cli_alert_warning("This notification will reach the R-core volunteers and many more")
    cli::cli_ul("Are you sure to open a bug?")
    ask_confirmation()
}
