#' @title Run Shiny App
#' @description Creating a website, shows different regions of HPI changes in US.
#' @return A website.
#' @examples
#' run_app

#' @export
run_app <- function() {
  shiny::runApp(appDir = system.file("myapp/app.R",
                                     package = "yang7er"))
}






