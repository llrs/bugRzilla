test_that("get_history works", {
    vcr::use_cassette("get_history", {
        gh <- get_history(1)
    })
    expect_s3_class(gh, "data.frame")
    expect_equal(dim(gh), c(8, 4))
    expect_s3_class(gh$when, "POSIXlt")
    colnames <- c("who", "when", "changes", "issue")
    expect_true(all(colnames(gh) %in% colnames))
})


vcr::use_cassette("get_history_fails", {
    test_that("get_history fails", {
        expect_error(get_history(issue = 2))
    })
})
