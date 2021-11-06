# This is to check the create_bugzilla_key function
cli::test_that_cli(configs = c("plain", "unicode"), "create_bugzilla_key() works", {
    skip_on_ci()
    expect_snapshot({
        create_bugzilla_key()
    })
})


# This is to check the set_key function
test_that("set_key works", {
    skip_on_ci()
    expect_snapshot({
        sk <- set_key()
        expect_equal(write_renviron(key = sk, value = sk, file = app_file()), NULL)
    })
})


# This is to check the check_key function
cli::test_that_cli(configs = c("plain", "unicode"), "check_key() works", {
    skip_on_ci()
    expect_snapshot({
        check_key(key_name = missing_key(),  verbose = FALSE)
    })
})

# This is to check the use_key function
cli::test_that_cli(configs = c("plain", "unicode"), "use_key() works", {
    expect_snapshot({
        use_key(missing_key())
    })
})


# This is to check the check_last_audit function
test_that("check_last_audit works", {
    vcr::use_cassette("check_last_audit", {
        cla <- check_last_audit()
    })
    expect_s3_class(cla, "POSIXlt")
})


# This is to check the valid_key function
cli::test_that_cli("valid_key() works", {
    expect_snapshot({
        valid_key(key = "hgfcchg12")
    })
})
