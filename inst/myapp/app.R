library(shiny)
library(tidyverse)
library(DT)
library(plotly)
library(here)
library(shinyWidgets)
library(yang7er)


#Prepared the data
state_hpi <- yang7er::hpi


#set ui
ui <- fluidPage(
  title = "HPI by State, USA 1975-2018",
  tabsetPanel(
    #set HPI chart
    tabPanel("House price index Plot",
             icon = icon("chart-line"),
             h3("HPI by State, USA 1975-2018"),
             fluidRow(
               column(
                 4,
                 radioGroupButtons("HPI",
                                   "HPI/HPI USA Selector",
                                   choices = c("HPI", "HPI USA"),
                                   selected = "HPI",
                                   justified = TRUE)
               ),
               column(
                 6,
                 offset = 1,
               ),
             ),
             plotlyOutput("chartHPI", width = "100%"),
             sliderInput("year", "Year",
                         min = 1975,
                         max = 2018,
                         value = c(1975,2018),
                         sep = "",
                         width = "100%"
             ),
    )
  )
)

#set server
server <- function(input, output, session) {

  #set input data

  min <- reactive({input$year[1]})
  max <- reactive({input$year[2]})

  year_input <- reactive({
    state_hpi %>%
      filter(year >= min(), year <= max())

  })

  statename <- reactive({
    if (is.null(input$state)){
      year_input()
    }
    else {
      year_input() %>%
        filter(state %in% input$state)
    }

  })


  df <- reactive({  mortgage_types %>%
      filter(mortgage_type %in% input$MRselect)
  })



  #set output

  output$chartHPI <- renderPlotly({

    if(input$HPI == "HPI"){

      p <-statename() %>%
        highlight_key(~region, "Select Region(s) to show in the Plot")  %>%
        ggplot(
          mapping=aes(x = year,
                      y = region_avg,
                      color=region)) +
        geom_line()+
        labs(title = "Annual Average HPI Change by State in the United States From 1975 to 2018",
             x = "YEAR",
             y = "Average HPI (year)",
             color = "state")+
        theme_minimal()

      highlight(ggplotly(p),
                selectize = TRUE,
                persistent = TRUE)

    }

    else{

      p <-statename() %>%
        highlight_key(~region, "Select State(s) to show in the Plot")  %>%
        ggplot(
          mapping=aes(x = year,
                      y = us_year_avg)) +
        geom_line()+
        labs(title = "Annual Average HPI Change by regions in the United States From 1975 to 2018",
             x = "YEAR",
             y = "Average HPI (year)",
             color = "region")+
        theme_minimal()

      highlight(ggplotly(p),
                selectize = TRUE,
                persistent = TRUE)
    }
  })}



runApp(shinyApp(ui, server))
