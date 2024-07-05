library(shiny)


ui <- fluidPage(
  h1("Proper title"),
  h6("foo"),
  p("Para 1", p("para2"))
)

server <- function(input, output, session){}


shinyApp(ui, server)