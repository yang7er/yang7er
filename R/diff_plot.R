#' @title Plot of Region and State HPI Difference
#' @description Show a plot of the difference of hpi between region and state
#' @details This function using data 'hpi', ploting the difference of hpi
#' between region and state. You can put a state name.
#' It will draw a comparative graph of the HPI changes in your chosen state,
#'  and the region where the state is located
#' @param State Character.
#'  A state name from hpi dataset,
#'  you can choose from unique(yang7er::hpi$state)
#'
#' @returns A plot.
#'
#'
#'@examples
#' diff_plot("NY")
#'
#'
#' @export
diff_plot <- function(State){

  #define ggplot
  aes <- ggplot2::aes
  #define dataset
  hpi <- yang7er::hpi
  `%>%` <- magrittr::`%>%`


  output_df <- hpi %>%
    dplyr::filter(state == State) %>%
    ggplot2::ggplot(aes(x=year,
                      y=year_avg,
                      color=state))+
    ggplot2::geom_line()+
    ggplot2::geom_line(aes(y=region_avg,
                           color=region))+
    ggplot2::theme_bw()

  return(output_df)
}
