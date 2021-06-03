library("vcr") # *Required* as vcr is set up on loading
library("httptest") # *Required* as hhtptest is set up on loading

vcr_dir <- vcr::vcr_test_path("fixtures")
if (!nzchar(Sys.getenv("R_BUGZILLA"))) {
    if (dir.exists(vcr_dir)) {
        Sys.setenv("R_BUGZILLA" = "foobar")
    } else {
        stop("No API key nor cassettes, tests cannot be run.",
             call. = FALSE)
    }
}

use_key()

invisible(vcr::vcr_configure(
  dir = vcr_dir,
  filter_request_headers = list(
    "Authorization" = "My bearer token is safe",
    "X-BUGZILLA-API-KEY" = "Removing this header too just in case")
))
vcr::check_cassette_names()
