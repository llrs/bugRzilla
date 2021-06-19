valid_parameters <- c("alias", "assigned_to", "component", "creation_time",
                      "creator", "id", "last_change_time", "limit",
                      "longdescs.count", "offset", "op_sys", "platform",
                      "priority", "product", "resolution", "severity",
                      "status", "summary", "tags", "target_milestone",
                      "qa_contact", "url", "version", "whiteboard",
                      "quicksearch")

# test_that("bug_search works", {
#     vcr::use_cassette("bug_search", {
#         bs <- bug_search(id=1)
#         url <- "https://bugs.r-project.org/bugzilla/rest/bug?id=1"
#     })
#     expect_equal(paste0(missing_host(), "rest/bug?", params(id=1)), url)
# })

test_that("params works", {
    par <- params()
    expect_true(all(names(par) %in% valid_parameters))
    expect_error(params(ids=1))
})
