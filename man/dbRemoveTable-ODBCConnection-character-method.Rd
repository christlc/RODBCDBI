% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ODBCConnection.R
\docType{methods}
\name{dbRemoveTable,ODBCConnection,character-method}
\alias{dbRemoveTable,ODBCConnection,character-method}
\title{Remove a table from the database.}
\usage{
\S4method{dbRemoveTable}{ODBCConnection,character}(conn, name)
}
\arguments{
\item{conn}{An existing \code{\linkS4class{ODBCConnection}}}

\item{name}{character vector of length 1 giving name of table to remove}
}
\description{
Executes the SQL \code{DROP TABLE}.
}

