shinyUI(fluidPage(
  # Application title
  titlePanel("NBA players shots from 2022-2023 Season", 
             windowTitle = "NBA dataset"),
  fluidRow(
    column(10, 
           includeMarkdown("markdown/about.md")
    )
  ),
  div(p(strong("Author:"), "Sergio Lois", a(icon("linkedin"), href="http://www.linkedin.com/in/slois"))),
  div(p(strong("Code available at GitHub:"), a(icon("github"), href="https://github.com/slois/nba_contour"))),
  div(p(strong("Data source:"), "Kaggle dataset (NBA Plays from 2022-2023 Season).")),
  div(p(strong("License:"), "CC-BY-4.0")),
  hr(),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="teamInput", 
                  label="Select NBA team:", 
                  choices=get_teams(nba_data), selected = "DAL"),
      selectInput(inputId="playerInput",
                  label="Select player:", 
                  choices=c("No players to select")),
      checkboxGroupInput("action_types", 
                         "Action types to show:", 
                         c("Made Shot"="Made Shot", "Missed Shot"="Missed Shot"),
                         selected = c("Made Shot", "Missed Shot")),
      checkboxInput("points", "Show shots", FALSE),
      sliderInput("bins", "Number of contour bins:",
                  min = 0, max = 20, value = 12),
      tags$p(span("Players who have registered few shots or a high number of contour bins may result in artefactual graphics.", style = "color:red"))
    ),
    mainPanel(
      # Create a new row for the table.
      plotOutput("hitsPlot",width = 600, height=600)#,
      #DT::dataTableOutput("table")
    )
  )
))