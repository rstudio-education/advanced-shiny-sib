# Module UI -------------------------------------------------------------------
movies_module_UI <- function(id) {
  ns <- NS(id)
  
  tagList(
    plotOutput(ns("scatterplot")),
    DT::dataTableOutput(ns("moviestable"))
  )
  
}

# Module server ---------------------------------------------------------------
movies_module_server <- function(input, output, session, data, mov_title_type, user_inputs) {
  
  # Select movies with given title type ----------------------------------------
  movies_with_type <- reactive({
    filter(data, title_type == mov_title_type)
  })
  
  # Create the scatterplot object the plotOutput function is expecting --------
  output$scatterplot <- renderPlot({
    ggplot(data = movies_with_type(), aes_string(x = user_inputs()$x, y = user_inputs()$y, color = user_inputs()$z)) +
      geom_point()
  })
  
}