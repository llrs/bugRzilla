.onLoad <- function(libname, pkgname) {
    path <- rappdirs::user_config_dir("bugRzilla", roaming = TRUE)
    path <- file.path(normalizePath(path), ".Renviron")
    if (file.exists(path)) {
        readRenviron(path)
    }
}
