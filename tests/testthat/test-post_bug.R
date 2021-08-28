test_that("post_bug works", {
    skip("Test manually")
    report <- post_bug(text = "testing 5",
                       title = "Posting bug from within R",
                       op_sys = "Other", # OS/Version
                       rep_platform = "Other", # GF Platform
                       host = "https://rbugs-devel.urbanek.info/bugzilla/",
                       key = "R_DEV_BUGZILLA")
    stopifnot(is.numeric(report$id))
})
