# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)

# Load data and module code ----------------------------------------------------
load("movies.Rdata")
source("03-moviesmodule.R")

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
                  tabPanel("Documentaries", movies_module_UI("doc")),
                  tabPanel("Feature Films", movies_module_UI("feature")),
                  tabPanel("TV Movies", movies_module_UI("tv"))
      )
      
    )
  )
)

# Define -----------------------------------------------------------------------
server <- function(input, output, session) {
  
  # Save user inputs as reactive expressions ---
  user_inputs <- reactive(input)
  
  # Create the scatterplot object the plotOutput function is expecting ----
  callModule(movies_module_server, "doc", data = movies, mov_title_type = "Documentary", user_inputs)
  callModule(movies_module_server, "feature", data = movies, mov_title_type = "Feature Film", user_inputs)
  callModule(movies_module_server, "tv", data = movies, mov_title_type = "TV Movie", user_inputs)
  
}

# Create the app ---------------------------------------------------------------
shinyApp(ui = ui, server = server)
