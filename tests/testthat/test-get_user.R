test_that("get_user works", {
    skip_on_cran()
    expect_snapshot({
        use_key()
    }, transform = function(x){gsub("/home/\\w+/", "~/", x)})
    vcr::use_cassette("get_user", {
        gu <- get_user(2)
    })
    expect_equal(nrow(gu), 1)
    expect_equal(ncol(gu), 3)
    expect_equal(colnames(gu), c("real_name", "id", "can_login"))
    expect_s3_class(gu, "data.frame")
})

test_that("get_user multiple ids", {
    skip_on_cran()
    expect_snapshot({
        use_key()
    }, transform = function(x){gsub("/home/\\w+/", "~/", x)})
    vcr::use_cassette("get_user2", {
        gu <- get_user(c(1, 2))
    })
    expect_equal(nrow(gu), 2)
    expect_equal(ncol(gu), 3)
    expect_equal(colnames(gu), c("real_name", "id", "can_login"))
    expect_s3_class(gu, "data.frame")
})

