
# Load data
load_nba_data <- function(filename){
  nba_data <- read.csv(filename)
  return(nba_data)
}

get_teams <- function(nba_data){
  teams <- unique(sort(nba_data$teamTricode))
  return(teams[teams != ""])
}

get_players_by_team <- function(nba_data, team){
  return(unique(nba_data[nba_data$teamTricode == team, "playerNameI", drop=TRUE]))
}

load_court_image <- function(){
  img <- jpeg::readJPEG("data/court.jpeg")
  g <- rasterGrob(img, width=unit(1,"npc"), height=unit(1,"npc"), interpolate = TRUE)
  return(annotation_custom(g, -250, 250, -52, 420))
}

plot_contour_player <- function(player_data, points, bins=12){
  base <- ggplot(data=player_data, aes(x=xLegacy, y=yLegacy)) + 
    load_court_image()
  
  if (points){
    base <- base + 
      geom_point(shape=19, colour="dodgerblue4", alpha=0.8, size=1.5)
  }
  
  attempts <- NROW(player_data)
  made_shots <- player_data[player_data$actionType == 'Made Shot',]
  n_made_shots <- NROW(made_shots)
  
  plt <- base +
    stat_density_2d(geom = "polygon", contour = TRUE,
                    aes(fill = ..level..), colour = "black", contour_var = "count",
                    bins = bins, alpha=0.7, linewidth=0.04)+
    scale_fill_distiller(palette = "Spectral", direction = -1) +
    #geom_density_2d_filled(contour_var="count", bins=12, alpha=0.7, linewidth=0.04) +
    ggtitle(sprintf("Short chart of %s", unique(player_data$playerNameI)),
            subtitle = sprintf("Number of attempts: %s (Shot accuracy = %s %%)", attempts, round(n_made_shots/attempts, 1)*100)) +
    coord_fixed(xlim=c(-250, 250), ylim=c(-52, 420)) +
    theme(plot.title = element_text(size = 25, face = "bold"),
          plot.subtitle = element_text(size = 18),
          panel.background = element_blank(),
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.minor = element_blank()
    ) +
    labs(x='', y='')
  return(plt)
}


get_players_teams <- function(nba_data){
  df <- nba_data %>% 
    filter(playerNameI != '' & teamTricode != '') %>% 
    select(playerNameI, teamTricode) %>%
    group_by(teamTricode) %>% reframe(players=unique(playerNameI)) %>%
    arrange(players) %>% as.data.frame()
  
  team_player <- split(df$players, df$teamTricode)
  return(team_player)
}

basket_court <- function(plot){
  
    ###floor:
    court <- plot + 
    return(court)
}
