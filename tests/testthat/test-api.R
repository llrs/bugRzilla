test_that("create_bugzilla_key works", {
    vcr::use_cassette("create_bugzilla_key", {
        cbk <- create_bugzilla_key(missing_host())
        url <- "https://bugs.r-project.org/bugzilla/userprefs.cgi?tab=apikey"
    })
    expect_equal(paste0(missing_host(), "userprefs.cgi?tab=apikey"), url)
    expect_condition()
    cli::test_that_cli("cli_alert_warning works", {
        expect_snapshot({
            cli::cli_alert_warning("This package hasn't been tested with this Bugzilla version.")
        })
    })
})


test_that("check_authentication works", {
    vcr::use_cassette("check_authentication", {
        ca <- check_authentication(missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
    cli::test_that_cli("cli_alert_danger",{
        expect_snapshot({
            cli::cli_alert_danger("Not authenticated on this site.")
            cli::cli_alert_success("Authenticated on this site!")
        })
    })
})


test_that("check_api_version works", {
    vcr::use_cassette("check_api_version", {
        cav <- check_api_version(missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
})


test_that("check_last_audit works", {
    vcr::use_cassette("check_last_audit", {
        cla <- check_last_audit(missing_product(), missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
    expect_equal(missing_product(), "R")
    expect_s3_class(GET(paste0(missing_host(), "rest/last_audit_time")), "response")
})


test_that("valid_key works", {
    use_cassette("valid_key", {
        vk <- valid_key(use_key())
    })
    cli::test_that_cli("cli_alert_dangers", {
        expect_snapshot({
            cli::cli_alert_danger("Key not valid or not set.")
        })
    })
})

snapshot_accept('R/api.R')
