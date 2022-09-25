## code to prepare `hpi` dataset goes here

library(janitor)
library(tidyverse)

url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/state_hpi.csv"

region1 <- c("WA","OR","CA","NV","AZ","UT","ID","AK","HI") %>%
  as_tibble() %>%
  mutate(region="Pacific West Area")
region2 <- c("MT","WY","CO","NM","TX","KS","OK","NE","SD","ND") %>%
  as_tibble() %>%
  mutate(region="Plains Area")
region3 <-c("MN","IA","MO","IL","WI","MI","IN","OH","KY") %>%
  as_tibble() %>%
  mutate(region="Midwest Area")
region4 <- c("AR","LA","MS","TN","AL","GA","FL","SC","NC") %>%
  as_tibble() %>%
  mutate(region="Sourtheast Area")
region5 <- c("ME","VT","NH","MA","CT","RI","NY","PA","WV","VA","MD","DE","NJ","DC") %>%
  as_tibble() %>%
  mutate(region="Northeast Area")

region <- region1 %>%
  rbind(region2,region3,region4,region5) %>%
  rename("state" = "value")

hpi <- read_csv(url) %>%
  clean_names() %>%
  group_by(year,state) %>%
  mutate(year_avg = mean(price_index),
         us_year_avg = mean(us_avg))%>%
  left_join(region) %>%
  group_by(year,region) %>%
  mutate(region_avg=mean(price_index))



usethis::use_data(hpi, overwrite = TRUE)
