# This is to check the create_bugzilla_key function
test_that("create_bugzilla_key works", {
    vcr::use_cassette("create_bugzilla_key", {
        cbk <- create_bugzilla_key(missing_host())
        url <- "https://bugs.r-project.org/bugzilla/userprefs.cgi?tab=apikey"
    })
    expect_equal(missing_host(),"https://bugs.r-project.org/bugzilla/")
    expect_equal(paste0(missing_host(), "userprefs.cgi?tab=apikey"), url)
    cli::test_that_cli( configs = c("plain", "ansi", "unicode", "fancy"), "cli_alert_warning", {
        expect_snapshot({
            cli::cli_alert_warning("This package hasn't been tested with this Bugzilla version.")
        })
    })
    cli::test_that_cli(configs = c("plain", "unicode"),"ul", {
        expect_snapshot({
            cli::cli_ul("Create the API key on the website.")
        })
    })
})


# This is to check the set_key function
test_that("set_key works", {
    vcr::use_cassette("set_key", {
        sk <- set_key()
    })
    expect_equal(write_renviron(key = sk, value = sk, file = app_file()), NULL)
})


# # This is to check the check_key function
# test_that("check_key works", {
#     vcr::use_cassette("check_key", {
#         sk <- check_key(use_key(), verbose = FALSE)
#         path <- app_file()
#         key_name <- use_key()
#     })
#     cli::test_that_cli("sk_cli_alert_danger", {
#         expect_snapshot({
#             cli_alert_danger("Key {.code {key_name}} not found on {.path {path}}.")
#         })
#     })
# })
#
#
# # This is to check the use_key function
# test_that("use_key works", {
#     vcr::use_cassette("use_key", {
#         key_name <- use_key()
#     })
#     cli::test_that_cli("uk_cli_alert_danger", {
#         expect_snapshot({
#             cli::cli_alert_danger("Key {.code {key_name}} not found. Use {.code set_key()}")
#         })
#     })
# })

# This is to check the check_authentication function
test_that("check_authentication works", {
    vcr::use_cassette("check_authentication", {
        ca <- check_authentication(missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
    cli::test_that_cli("ca_cli_alert_danger",{
        expect_snapshot({
            cli::cli_alert_danger("Not authenticated on this site.")
            cli::cli_alert_success("Authenticated on this site!")
        })
    })
})


# This is to check the check_api_version function
test_that("check_api_version works", {
    vcr::use_cassette("check_api_version", {
        cav <- check_api_version(missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
})


# This is to check the check_last_audit function
test_that("check_last_audit works", {
    vcr::use_cassette("check_last_audit", {
        cla <- check_last_audit(missing_product(), missing_host())
    })
    expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
    expect_equal(missing_product(), "R")
    expect_s3_class(GET(paste0(missing_host(), "rest/last_audit_time")), "response")
})


# This is to check the valid_key function
test_that("valid_key works", {
    vcr::use_cassette("valid_key", {
        vk <- valid_key(use_key())
    })
    cli::test_that_cli("vk_cli_alert_danger", {
        expect_snapshot({
            cli::cli_alert_danger("Key not valid or not set.")
        })
    })
})
