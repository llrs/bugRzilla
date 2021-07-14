local({
    with_mock(post_bug, post_bug())
    cli::test_that_cli(configs = "plain", "post_bug() works", {
        skip_if_not(interactive())
        expect_snapshot(
            expect_type(post_bug, "closure")
            # expect_error(post_bug(), "Do it and then return please."),
            # expect_error(post_bug(), "Do it, later if you are still sure it is a bug then return please.")
        )
    })
})
