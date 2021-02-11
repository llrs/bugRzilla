

ui_fail <- function(message) {
    stop(crayon::red(cli::symbol$cross),
         crayon::black(message), call. = FALSE)
}

ui_done <- function(message) {
    message(crayon::green(cli::symbol$tick),
            crayon::black(message))
}


ui_todo <- function(message) {
    message(crayon::red(cli::symbol$bullet),
            crayon::black(message))
}
