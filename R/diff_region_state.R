#' @title Region and State HPI Difference
#' @description Calculating the difference of hpi between region and state
#' @details This function using data 'hpi', calculating the difference of hpi
#' between region and state. You can put a state name, and  a year,
#' it will show a tibble include year, state, region, region avg, state avg and
#' diff.
#'
#' @param State Character.
#'  A state name from hpi dataset,
#'  you can choose from unique(yang7er::hpi$state)
#' @param Year Numeric.
#'  A year from 1975 to 2018,
#'  you can choose from unique(yang7er::hpi$year)
#'
#'
#' @returns  A data.frame. The information include:
#'   \itemize{
#'   \item \code{year} : The year you chosen.
#'   \item \code{state} : The state you chosen.
#'   \item \code{region} : The region to which your chosen state belongs
#'   \item \code{region avg} : Region average HPI.
#'   \item \code{state avg} : State average HPI.
#'   \item \code{diff} : Region average HPI- State average HPI.
#' }
#'
#'
#'@examples
#' diff_region_state("AK",2018)
#'
#' @export
diff_region_state <- function(State,Year){

  `%>%` <- magrittr::`%>%`



  output_df <- yang7er::hpi %>%
    dplyr::filter(state == State,
                  year == Year) %>%
  dplyr::group_by(state,year) %>%
  dplyr::mutate(diff=region_avg-year_avg) %>%
  dplyr::select(year,state,region,region_avg,year_avg,diff) %>%
  dplyr::rename("state_avg"="year_avg") %>%
  unique()

  return(output_df)
}
