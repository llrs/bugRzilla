test_that("get_issue works", {
    vcr::use_cassette("get_issue", {
        gi <- get_issue(1)
    })
    expect_s3_class(gi, "data.frame")
    expect_equal(dim(gi), c(5, 46))
    expect_s3_class(gi$bug_when, "POSIXlt")
    colnames <- c(
        "attachid", "commentid", "comment_count", "who", "bug_when",
        "thetext", "bug_id", "creation_ts", "short_desc", "delta_ts.comment",
        "reporter_accessible", "cclist_accessible", "classification_id",
        "classification", "product", "component", "version", "rep_platform",
        "op_sys", "bug_status", "resolution", "bug_file_loc", "status_whiteboard",
        "keywords", "priority", "bug_severity", "target_milestone", "dependson",
        "dependson.1", "dependson.2", "everconfirmed", "reporter", "assigned_to",
        "cc", "reported_by", "assigned_by", "isobsolete", "ispatch",
        "date", "delta_ts.attachment", "desc", "filename", "type", "size",
        "attacher", "data")
    expect_true(all(names(gi) %in% colnames))
})
