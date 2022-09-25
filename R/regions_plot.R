#' @title Plot of Regions HPI Difference
#' @description Show a plot of the hpi change between in different regions
#' @details This function using data 'hpi', ploting the hpi changes
#' in all regions. You can put a year. like(1990,2018)
#' It will draw a graph of the HPI changes in your chosen years for
#' all regions.
#' @param Min,Number.
#'  A min year (the plot beginning from which year) you chose 
#'  you can choose from unique(yang7er::hpi$year)
#' @param Max,Number.
#'  A max year (the plot ending from which year) you chose 
#'  you can choose from unique(yang7er::hpi$year)
#'
#'@returns A plot.
#'
#'
#'@examples
#' #Plot from 1995 to 2017
#' regions_plot(1995,2017)
#'
#'@export
regions_plot <- function(Min,Max){
  #define ggplot
  aes <- ggplot2::aes
  #define dataset
  hpi <- yang7er::hpi
  `%>%` <- magrittr::`%>%`
  
  output_df <- hpi %>%
    dplyr::filter(year >= Min,
                  year <= Max) %>%
    ggplot2::ggplot(aes(x=year,
                        y=region_avg,
                        color=region))+
    ggplot2::geom_line()+
    ggplot2::theme_bw()
  
  return(output_df)
}