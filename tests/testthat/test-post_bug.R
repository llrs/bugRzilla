cli::test_that_cli(configs = "plain", "post_bug() works", {
    skip_if_not(interactive())
    vcr::use_cassette("post_bug_works", {
        pg <- post_bug("This is the test description", "TEST!!!")
    })
    expect_snapshot(
        expect_type(pg, "list")
    )
})


cli::test_that_cli(configs = "plain", "post_bug() fails", {
    skip_if_not(interactive())
    expect_snapshot(
        expect_error(post_bug("This is the test description", "TEST!!!"), "Do it and then return please.")
    )
})
