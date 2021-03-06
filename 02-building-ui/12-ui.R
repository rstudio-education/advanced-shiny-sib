# Load packages ----------------------------------------------------------------
library(shiny)

# Define function --------------------------------------------------------------
videoThumbnail <- function(video_url, title, description) {
  div(class = "thumbnail",
    div(class = "embed-responsive embed-responsive-16by9",
      tags$iframe(class = "embed-responsive-item", src = video_url, allowfullscreen = NA)
    ),
    div(class = "caption",
      h3(title),
      div(description)
    )
  )
}

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  h1("Random videos"),
  fluidRow(
    column(6,
      videoThumbnail("https://www.youtube.com/embed/hou0lU8WMgo",
        "You are technically correct",
        "The best kind of correct!"
      )
    ),
    column(6,
      videoThumbnail("https://www.youtube.com/embed/4F4qzPbcFiA",
        "Admiral Ackbar",
        "It's a trap!"
      )
    )
  )
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {}

# Run the app -------------------------------------------------------
shinyApp(ui, server)
