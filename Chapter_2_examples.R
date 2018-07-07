
# Chapter 2 exercise ------------------------------------------------------

dir.create("Data")
datapath <- "Data"

# Grab census data to use for example
  url <- "https://www.census.gov/2010census/csv/pop_change.csv"
  download.file(url, file.path(datapath, "pop_change_2010_USA.csv"))
  
  pop_df <- read_csv(file.path(datapath, "pop_change_2010_USA.csv"), skip = 2)

  # Reshape to get it into a tidy format we can easily plot
  pop_long <- pop_df %>% 
    gather(`1910_POPULATION`:`2010_CHANGE`, key = "varname", value = "population") %>% 
    separate(varname, c("Year", "Stat"), sep = "_") %>% 
    spread(Stat, population) %>% 
    mutate(year = as.numeric(Year))
  
  # Plot the data to see what is going on
  # Using free scales to see how different states are contracting/expanding
  pop_long %>% 
    filter(!(STATE_OR_REGION %in% c("United States", "Midwest", "Northeast", "South", "West"))) %>%
    group_by(STATE_OR_REGION) %>% 
    mutate(tot_pop = sum(POPULATION)) %>% 
    ungroup() %>% 
    mutate(sortOrder = as.factor(STATE_OR_REGION), 
           sortOrder = fct_reorder(sortOrder, tot_pop, .desc = TRUE)) %>% 
  ggplot(., aes(x = year, y = POPULATION)) +
    geom_line(colour = "gray50") +
    geom_point(shape = 21, size = 2, colour = "gray60", fill = "white") +
    facet_wrap(~sortOrder, scales = "free")+
    scale_x_continuous(breaks = seq(1910, 2010, 30))
  

  