test_that("get_fields works", {
    # skip_if_offline()
    # skip_on_cran()
    vcr::use_cassette("get_fields", {
        fi <- get_fields()
    })
    expect_s3_class(fi, "data.frame")
    expect_equal(dim(fi), c(61, 4))

    colnames <- c("name", "name_field", "mandatory", "values")
    expect_true(all(names(fi) %in% colnames))

    rownames <- c(
  "Bug #", "Summary", "Classification", "Product", "Version",
  "Platform", "URL", "OS/Version", "Status", "Status Whiteboard",
  "Keywords", "Resolution", "Severity", "Priority", "Component",
  "AssignedTo", "ReportedBy", "Votes", "QAContact", "CC", "Depends on",
  "Blocks", "Attachment description", "Attachment filename", "Attachment mime type",
  "Attachment is patch", "Attachment is obsolete", "Attachment is private",
  "Attachment creator", "Target Milestone", "Creation date", "Last changed date",
  "Comment", "Comment is private", "Alias", "Ever Confirmed", "Reporter Accessible",
  "CC Accessible", "Group", "Estimated Hours", "Remaining Hours",
  "Deadline", "Commenter", "Flags", "Flag Requestee", "Flag Setter",
  "Hours Worked", "Percentage Complete", "Content", "Attachment data",
  "Time Since Assignee Touched", "Days since bug changed", "See Also",
  "Number of Comments", "Personal Tags", "AssignedToName", "ReportedByName",
  "QAContactName", "Last Visit", "Comment Tag", "Duplicate of")
    expect_true(all(fi$Name %in% rownames))
})
