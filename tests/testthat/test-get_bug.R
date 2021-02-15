test_that("get_bug issue works", {
    vcr::use_cassette("get_bug", {
        i1 <- get_bug(issue = 1)
    })
    expect_s3_class(i1, "data.frame")
    expect_equal(dim(i1), c(1, 38))
    expect_s3_class(i1$creation_time, "POSIXlt")
    colnames <- c(
        "see_also", "creator", "keywords", "depends_on", "blocks",
        "target_milestone", "classification", "severity", "is_confirmed",
        "is_creator_accessible", "cc_detail", "is_cc_accessible", "status",
        "alias", "op_sys", "dupe_of", "platform", "url", "last_change_time",
        "resolution", "whiteboard", "deadline", "product", "is_open",
        "cc", "version", "component", "assigned_to_detail", "id", "summary",
        "priority", "groups", "creator_detail", "creation_time", "qa_contact",
        "flags", "assigned_to", "out")
    expect_true(all(colnames(i1) %in% colnames))
})

vcr::use_cassette("get_bug_fails", {
    test_that("get_bug issue fails", {
        expect_error(get_bug(issue = 2), "Bug #2 does not exist.")
    })
})

