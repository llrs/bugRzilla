test_that("post_comment works", {
    vcr::use_cassette("post_comment", {
    pc <- post_comment(issue = 1, comment = "testing",
                       host = "https://rbugs-devel.urbanek.info/",
                       key = "R_DEV_BUGZILLA")
    })
    expect_true(is.numeric(pc))

})
