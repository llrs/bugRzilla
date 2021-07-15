cli::test_that_cli(configs = "plain", "post_bug() works", {
    skip_if_not(interactive())
    vcr::use_cassette("post_bug_works", {
        pg <- post_bug()
    })
    expect_snapshot(
        expect_type(pg, "list")
    )
})


# cli::test_that_cli(configs = "plain", "post_bug() fails", {
#     skip_if_not(interactive())
#     pg1 <- post_bug()
#     expect_snapshot(
#         expect_error(pg1, "Do it and then return please.")
#     )
# })
