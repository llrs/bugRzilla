#' Get fields
#'
#' Retrieve possible fields to fill and their values if they are from a closed list.
#' @inheritParams create_bugzilla_key
#' @return A data.frame with three columns, Name of the fields, if it is
#' mandatory and the values it can take.
#' @export
#' @examples
#' fields <- get_fields()
get_fields <- function(host) {
    host <- missing_host(host)
    stopifnot(is.character(host))
    url <- paste0(host, "/rest/field/bug")
    fields <- httr::GET(url)
    httr::stop_for_status(fields)
    fields <- httr::content(fields)
    fields <- fields$fields
    name <- vapply(fields, function(x){x$display_name}, character(1L))
    name_field <- vapply(fields, function(x){x$name}, character(1L))
    mandatory <- vapply(fields, function(x){x$is_mandatory}, logical(1L))
    values <- lapply(fields, function(x){
        y <- lapply(x$values, function(y){
            y$name
        })
        unlist(y, recursive = FALSE, use.names = FALSE)})
    values[lengths(values) == 0] <- list(NA)
    df <- data.frame(name = name, name_field = name_field, mandatory = mandatory)
    df$values <- values
    df
}
