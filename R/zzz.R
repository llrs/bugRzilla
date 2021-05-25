.onLoad <- function(libname, pkgname) {
    path <- tools::R_user_dir("bugRzilla")
    path <- file.path(path, ".Renviron")
    if (file.exists(path)) {
        readRenviron(path)
    }
}
