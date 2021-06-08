valid_parameters <- c("alias", "assigned_to", "component", "creation_time",
                      "creator", "id", "last_change_time", "limit",
                      "longdescs.count", "offset", "op_sys", "platform",
                      "priority", "product", "resolution", "severity",
                      "status", "summary", "tags", "target_milestone",
                      "qa_contact", "url", "version", "whiteboard",
                      "quicksearch")

# test_that("bug_search works", {
#     vcr::use_cassette("bug_search", {
#         bs <- bug_search()
#         url <- "https://bugs.r-project.org/bugzilla/rest/bug?id=1"
#         params <- params(1)
#     })
#     expect_equal(missing_host(), "https://bugs.r-project.org/bugzilla/")
# })

test_that("params works", {
    vcr::use_cassette("params", {
        par <- params()
    })
    expect_true(all(names(par) %in% valid_parameters))
})
