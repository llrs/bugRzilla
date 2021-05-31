library("vcr") # *Required* as vcr is set up on loading
library("httptest")

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

test_that("create_bugzilla_key works", {
  vcr::use_cassette("create_bugzilla_key", {
    host <- "https://bugs.r-project.org/bugzilla/"
    cbk <- create_bugzilla_key(host)
  })
  expect_equal(a <- paste0(host, "userprefs.cgi?tab=apikey"), url)
  cli::test_that_cli("cli_alert_warning works", {
    expect_snapshot({
      cli::cli_alert_warning("This package hasn't been tested with this Bugzilla version.")
    })
  })
})


test_that("check_authentication works", {
  vcr::use_cassette("check_authentication", {
    ca <- check_authentication(host)
  })
  expect_equal(missing_host(host), "https://bugs.r-project.org/bugzilla/")
  cli::test_that_cli("cli_alert_danger",{
    expect_snapshot({
      cli::cli_alert_danger("Not authenticated on this site.")
      cli::cli_alert_success("Authenticated on this site!")
    })
  })
})

test_that("check_api_version works", {
  vcr::use_cassette("check_api_version", {
    cav <- check_api_version(host)
  })
  expect_equal(missing_host(host), "https://bugs.r-project.org/bugzilla/")
})


test_that("check_last_audit works", {
  vcr::use_cassette("check_last_audit", {
    product <- "R"
    cla <- check_last_audit(product, host)
  })
  expect_equal(missing_host(host), "https://bugs.r-project.org/bugzilla/")
  httptest::expect_GET(paste0(host, "rest/last_audit_time"), "https://bugs.r-project.org/bugzilla/rest/last_audit_time")
  expect_equal(missing_product(product), "R")
})


invisible(vcr::vcr_configure(
  dir = vcr_dir,
  filter_request_headers = list(
      "Authorization" = "My bearer token is safe",
      "X-BUGZILLA-API-KEY" = "Removing this header too just in case")
))
vcr::check_cassette_names()


test_that("valid_key works", {
  use_cassette("valid_key", {
    vk <- valid_key("R_BUGZILLA")
  })
  cli::test_that_cli("cli_alert_danger", {
    expect_snapshot({
      cli::cli_alert_danger("Key not valid or not set.")
    })
  })
})
