
# Benchmarking example ----------------------------------------------------

library(microbenchmark)
library(tidyverse)

df <- data.frame(v = 1:4,
                 name = letters[1:4])

# Benchmark 3 different ways of accessing a cell
  microbenchmark(df[3, 2], df[3, "name"], df$name[3], df %>% filter(v == 3))
  
  # Notice how quick the df$name[3] call is relative to the others
  

# Profiling example -------------------------------------------------------

# Use profiling to test large chunks of code
  library(profvis)
  profvis(expr = {
    # Stage 1: load in some libraries
    library(ggplot2)
    library(data.table)
    
    # stage 2: load and process data
   cars <- mtcars %>% 
     filter(cyl != 4) %>% 
     arrange(-mpg)
   
   # stage 3: plot and save
   ggplot(cars, aes(x = mpg, y = wt)) +
     geom_point(aes(size = hp)) +
     geom_smooth(se = FALSE) +
     facet_grid(~cyl)
   })
  
# Base commands to check your specs, etc.  
  Sys.info() # -- prints out system and user info
  
  R.home() # -- directory in which R is installed
  
  Sys.getenv() # -- lists all the environment variables
  
  file.path() # -- construct paths to files in a platform independent manner
  file.exists() # -- check for existence of file
  file.copy() # -- copy files from one directory to another
  dir.create() # -- create a directory/folder
  list.files() # -- list files 

  

  