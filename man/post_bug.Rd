% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/post_bug.R
\name{post_bug}
\alias{post_bug}
\title{Open an issue.}
\usage{
post_bug(text, title, component, ..., version, product, host, key)
}
\arguments{
\item{text}{A character vector with the text of the bug you want to
open.}

\item{title}{A character vector with the title of the bug.}

\item{component}{A character with the component of R you want to fill an issue with.}

\item{...}{Named arguments passed to the API \href{https://bugzilla.readthedocs.io/en/latest/api/core/v1/bug.html}{check documentation}}

\item{version}{A character of the Version you want to use eg "R 4.0.0".}

\item{product}{A character of the product you want to use if missing "R" is
automatically filled.}

\item{host}{URL of the bugzilla instance if missing the R bugzilla is assumed.}

\item{key}{API key to check.}
}
\value{
The ID of the issue posted.
}
\description{
Guides through the process of creating an issue.
Requires an user and an API key.
}
\seealso{
To obtain and use the API key see create_bugzilla_key().
\href{https://bugs.r-project.org/bugzilla/enter_bug.cgi}{Webpage} for manual entry
}
