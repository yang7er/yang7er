#'@title Get data HPI
#'@description the function of get the HPI data
#'@details A dataset containing the year,month,state,price_index,us_avg,year_avg,us_year_avg,region,region_avg
#'
#'@format A data frame with 26877 rows and 9 variables:
#'\itemize{
#'   \item \code{year}:year
#'   \item \code{month}:month
#'   \item \code{state}:states in US
#'   \item \code{price_index}:house price index
#'   \item \code{us_avg}:us annual average HPI
#'   \item \code{year_avg}:every stats's anaual average HPI
#'   \item \code{us_year_avg}:us annual average HPI
#'   \item \code{region}:state belongs in which region
#'   \item \code{region_avg}:every region's anaual average HPI
#' }
#'@examples get_hpi
#'@source \url{https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/state_hpi.csv"}
#'
#'@export
get_hpi <- function(){

   url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/state_hpi.csv"

  `%>%` <- magrittr::`%>%`

  region1 <- c("WA","OR","CA","NV","AZ","UT","ID","AK","HI") %>%
    tibble::as_tibble() %>%
    dplyr::mutate(region="Pacific West Area")
  region2 <- c("MT","WY","CO","NM","TX","KS","OK","NE","SD","ND") %>%
    tibble::as_tibble() %>%
    dplyr::mutate(region="Plains Area")
  region3 <-c("MN","IA","MO","IL","WI","MI","IN","OH","KY") %>%
    tibble::as_tibble() %>%
    dplyr::mutate(region="Midwest Area")
  region4 <- c("AR","LA","MS","TN","AL","GA","FL","SC","NC") %>%
    tibble::as_tibble() %>%
    dplyr::mutate(region="Sourtheast Area")
  region5 <- c("ME","VT","NH","MA","CT","RI","NY","PA","WV","VA","MD","DE","NJ","DC") %>%
    tibble::as_tibble() %>%
    dplyr::mutate(region="Northeast Area")

  region <- region1 %>%
    rbind(region2,region3,region4,region5) %>%
    dplyr::rename("state" = "value")

  hpi <- readr::read_csv(url) %>%
    janitor::clean_names() %>%
    dplyr::group_by(year,state) %>%
    dplyr::mutate(year_avg = mean(price_index),
           us_year_avg = mean(us_avg))%>%
    dplyr::left_join(region) %>%
    dplyr::group_by(year,region) %>%
    dplyr::mutate(region_avg=mean(price_index))

  rm(region1,region2,region3,region4,region5,region)

  return(hpi)

}
