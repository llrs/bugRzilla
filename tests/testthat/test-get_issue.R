test_that("get_issue works", {
    skip_on_cran()
    skip_if_offline()
    gi <- get_issue(1)
    expect_s3_class(gi, "data.frame")
})
