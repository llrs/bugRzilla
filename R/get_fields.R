get_fields <- function(host) {
    host <- missing_host(host)
    url <- paste0(host, "/rest/field/bug")
    fields <- httr::GET(url)
    fields <- httr::content(fields)
    fields <- fields$fields
    name <- vapply(fields, function(x){x$display_name}, character(1L))
    mandatory <- vapply(fields, function(x){x$is_mandatory}, logical(1L))
    values <- lapply(fields, function(x){
        lapply(x$values, function(y){
            y$name
        })})
    values[lengths(values) == 0] <- list(NA)
    df <- data.frame(Name = name, Mandatory = mandatory)
    df$Values <- values
    df
}
