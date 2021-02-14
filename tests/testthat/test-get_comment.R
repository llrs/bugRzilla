test_that("get_comment issue works", {
    vcr::use_cassette("get_commenti", {
        i1 <- get_comment(issue = 1)
    })
    expect_s3_class(i1, "data.frame")
    expect_equal(dim(i1), c(5, 11))
    expect_s3_class(i1$creation_time, "POSIXlt")
    colnames <- c("attachment_id", "is_markdown", "creation_time", "text",
                  "bug_id", "creator", "tags", "id", "time", "count",
                  "is_private")
    expect_true(all(colnames(i1) %in% colnames))
})

test_that("get_comment comment works", {
    vcr::use_cassette("get_commentc", {
        c1 <- get_comment(comment = 1)
    })
    expect_s3_class(c1, "data.frame")
    expect_equal(dim(c1), c(1, 11))
    expect_s3_class(c1$creation_time, "POSIXlt")
    colnames <- c("attachment_id", "is_markdown", "creation_time", "text",
                  "bug_id", "creator", "tags", "id", "time", "count",
                  "is_private")
    expect_true(all(colnames(c1) %in% colnames))
})

vcr::use_cassette("get_comment_fails", {
    test_that("get_comment issue fails", {
        expect_error(get_comment(issue = 2), "Bug #2 does not exist.")
    })
})
