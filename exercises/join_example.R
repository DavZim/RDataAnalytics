library(dplyr)
library(nycflights13)
library(readr)

# load the missing airports
df_missing_airports <- read_csv("data/missing_airports.csv")

# add the missing airports to the data_frame
df_airports <- rbind(airports %>% select(faa, lat, lon), 
                     df_missing_airports %>% select(faa, lat, lon))

# prepare the flights dataset
df_flights <- flights %>% 
  select(origin, dest)

# prepare the origin location
df_origin <- df_airports %>% 
  select(origin = faa, 
         origin_lat = lat,
         origin_lon = lon)

# prepare the destination location
df_dest <- df_airports %>% 
  select(dest = faa, 
         dest_lat = lat,
         dest_lon = lon)

# combine the location information of the origin to the df_flights dataset
df_flights <- left_join(df_flights, df_origin, by = "origin")

# combine the location information of the destination to the df_flights dataset
df_flights <- left_join(df_flights, df_dest, by = "dest")

df_flights
summary(df_flights)
