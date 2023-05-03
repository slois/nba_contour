shinyServer(function(input, output, session) {


  observeEvent(input$teamInput,
               {
                 updateSelectInput(session, input = "playerInput",
                                   choices=get_players_by_team(nba_data, input$teamInput),selected = "L. Doncic"
                 )
               })

  selected_nba_data <- reactive({
    nba_data[nba_data$teamTricode == input$teamInput & nba_data$playerNameI == input$playerInput & nba_data$actionType %in% input$action_types,]
  })
  
  #output$table <- DT::renderDataTable(
  #  DT::datatable(selected_nba_data()[,c("playerNameI", "teamTricode", "game_id", "period", "home", "scoreHome", "away", "scoreAway", "actionType", "subType", "shotDistance", "scoreVal")]))
  
  output$hitsPlot <- renderPlot({
    plot_contour_player(selected_nba_data(), points=input$points, bins = input$bins)
  })
})