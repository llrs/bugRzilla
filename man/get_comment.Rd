% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_comments.R
\name{get_comment}
\alias{get_comment}
\title{Retrieve comment}
\usage{
get_comment(issue, comment, host)
}
\arguments{
\item{issue}{Number of the issue.}

\item{comment}{A character with the id of the comment eg. "1", can be
missing and it will retrieve all comments.}

\item{host}{URL of the bugzilla instance if missing the R bugzilla is assumed.}
}
\value{
A \code{data.frame} with creation_time, text, creator, time,
attachment_id, bug_id.
}
\description{
Get comments from an issue or by id of the comment.
}
\note{
It doesn't require being authenticated.
}
\examples{
i1 <- get_comment(issue = 1) # The comments on the first issue
c1 <- get_comment(comment = 1) # Just the first comment
}
