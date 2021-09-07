test_that("post_bug works", {
    skip("Test manually")
    report <- post_r_bug(text = "testing 5",
                       title = "Posting bug from within R",
                       op_sys = "Other", # OS/Version
                       rep_platform = "Other", # GF Platform
                       key = "R_DEV_BUGZILLA")
    stopifnot(is.numeric(report))
})
