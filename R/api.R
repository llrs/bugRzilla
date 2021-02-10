
#' @importFrom httr GET POST add_headers
headers <- httr::add_headers("X-BUGZILLA-API-KEY" = Sys.getenv("R_BUGZILLA"),
                       Application = "https://github.com/llrs/bugRzilla/")
# https://stackoverflow.com/questions/52997316/ and
# https://bugzilla.readthedocs.io/en/latest/api/core/v1/general.html#authentication
# gt <- httr::GET("https://bugs.r-project.org/bugzilla/rest/user/1", headers)

# Provide a function to check if variable with API key is available
# Get data from endpoints
# Post comments/bugs (depend on reprex?)

# whoami <- httr::GET("https://bugs.r-project.org/bugzilla/rest/whoami")
