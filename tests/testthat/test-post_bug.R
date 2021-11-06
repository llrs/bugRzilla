test_that("post_bug works", {
    skip("Test manually")
    # Make sure the right one is on
    check_key("R_DEV_BUGZILLA")
    check_authentication(host = "https://rbugs-devel.urbanek.info/")
    # Make the actual request
    report <- post_r_bug(text = "testing 5",
                       title = "Posting bug from within R",
                       op_sys = "Other", # OS/Version
                       rep_platform = "Other", # GF Platform
                       key = "R_DEV_BUGZILLA")
    # check the reports on https://rbugs-devel.urbanek.info/buglist.cgi?bug_status=__open__&list_id=18286&order=changeddate%20DESC%2Cpriority%2Cbug_severity&query_format=specific
    stopifnot(is.numeric(report))
})
