#' ODBC results.
#'
#' @keywords internal
#' @export
setClass(
  "ODBCResult",
  contains = "DBIResult",
  slots= list(
    connection="ODBCConnection",
    sql="character",
    is_done="logical"
  )
)

#' Hack its is_done property assigned in the parent environment.
#'
set_as_done <- function(res, n, boolean) 
{
  name <- deparse(substitute(res, env=parent.frame(n=n-1)))
  res@is_done <- boolean
  assign(name, res, envir=parent.frame(n=n))  
}

#' Execute a SQL statement on a database connection
#'
#' To retrieve results a chunk at a time, use \code{dbSendQuery},
#' \code{dbFetch}, then \code{ClearResult}. Alternatively, if you want all the
#' results (and they'll fit in memory) use \code{dbGetQuery} which sends,
#' fetches and clears for you.
#' 
#' @param res Code a \linkS4class{ODBCResult} produced by \code{\link[DBI]{dbSendQuery}}.
#' @param n Number of rows to return. If less than zero returns all rows.
#' @inheritParams DBI::rownamesToColumn
#' @export
#' @rdname odbc-query
setMethod("dbFetch", "ODBCResult", function(res, n = -1, ..., row.names = NA) {
  result <- sqlQuery(res@connection@odbc, res@sql)
  set_as_done(res, 5, TRUE)
  result
})

#' @rdname odbc-query
#' @export
setMethod("dbHasCompleted", "ODBCResult", function(res, ...) {
  res@is_done
})

#' @rdname odbc-query
#' @export
setMethod("dbClearResult", "ODBCResult", function(res, ...) {
  name <- deparse(substitute(res))
  set_as_done(res, 5, FALSE)
  TRUE
})