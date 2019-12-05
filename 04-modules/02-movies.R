# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(tools)

# Load data --------------------------------------------------------------------
load("movies.Rdata")

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  
  # Application title ----
  titlePanel("Movie browser - with modules"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Inputs: Select variables to plot ----
    sidebarPanel(
      
      # Select variable for y-axis ----
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis ----
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "critics_score"),
      
      # Select variable for color ----
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Title Type" = "title_type", 
                              "Genre" = "genre", 
                              "MPAA Rating" = "mpaa_rating", 
                              "Critics Rating" = "critics_rating", 
                              "Audience Rating" = "audience_rating"),
                  selected = "mpaa_rating")
      
    ),
    
    # Output: ----
    mainPanel(
      
      # Show scatterplot ----
      tabsetPanel(id = "movies", 
                  tabPanel("Documentaries", 
                           plotOutput("scatterplot_doc")),
                  tabPanel("Feature Films", 
                           plotOutput("scatterplot_feature")),
                  tabPanel("TV Movies", 
                           plotOutput("scatterplot_tv"))
      )
      
    )
  )
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {
  
  # Create subsets for various title types ----
  docs <- reactive({
    filter(movies, title_type == "Documentary")
  })
  
  features <- reactive({
    filter(movies, title_type == "Feature Film")
  })
  
  tvs <- reactive({
    filter(movies, title_type == "TV Movie")
  })
  
  
  # Scatterplot for docs ----
  output$scatterplot_doc <- renderPlot({
    ggplot(data = docs(), aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
  
  # Scatterplot for features ----
  output$scatterplot_feature <- renderPlot({
    ggplot(data = features(), aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
  
  # Scatterplot for tvs ----
  output$scatterplot_tv <- renderPlot({
    ggplot(data = tvs(), aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
  
}

# Create the app ---------------------------------------------------------------
shinyApp(ui = ui, server = server)
