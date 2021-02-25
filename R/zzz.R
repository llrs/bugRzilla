.onLoad <- function(libname, pkgname) {
    path <- rappdirs::user_cache_dir("bugRzilla")
    path <- file.path(normalizePath(path), ".Renviron")
    if (file.exists(path)) {
        readRenviron(path)
    }
}
