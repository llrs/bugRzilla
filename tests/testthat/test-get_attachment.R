colnames <- c("id", "creator", "is_obsolete", "last_change_time", "data",
              "size", "is_private", "summary", "content_type",
              "creation_time", "file_name", "bug_id", "is_patch", "flags")
test_that("get_attachment issue works", {
    vcr::use_cassette("get_attachmenti", {
        i1 <- get_attachment(issue = 1)
    })
    expect_s3_class(i1, "data.frame")
    expect_equal(dim(i1), c(1, 14))
    expect_s3_class(i1$creation_time, "POSIXlt")
    expect_true(all(colnames(i1) %in% colnames))
})

test_that("get_attachment comment works", {
    vcr::use_cassette("get_attachmenta", {
        c1 <- get_attachment(attachment = 1)
    })
    expect_s3_class(c1, "data.frame")
    expect_equal(dim(c1), c(1, 14))
    expect_s3_class(c1$creation_time, "POSIXlt")
    expect_true(all(colnames(c1) %in% colnames))
})

vcr::use_cassette("get_attachment_fails", {
    test_that("get_attachment issue fails", {
        expect_error(get_attachment(issue = 2), "Bug #2 does not exist.")
    })
})
