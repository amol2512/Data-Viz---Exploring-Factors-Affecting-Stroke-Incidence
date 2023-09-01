install.packages('dplyr')
install.packages('nycflights13')
library(nycflights13)
library(tidyverse)

Exercise 5.2.4

#1
filter(flights, arr_delay >= 120)

#2
filter(flights, dest %in% c("IAH", "HOU"))

#3
airlines
filter(flights, carrier %in% c("AA", "DL", "UA"))

#4
filter(flights, month >= 7, month <= 9)

#5
filter(flights, arr_delay > 120, dep_delay <= 0)

#6
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)

#7
summary(flights$dep_time)
filter(flights, dep_time <= 600 | dep_time == 2400)
filter(flights, dep_time %% 2400 <= 600)

Exercise 5.3.1

#1
arrange(flights, dep_time) %>%
  tail()
arrange(flights, desc(is.na(dep_time)), dep_time)

#2
arrange(flights, desc(dep_delay)) -- HA 51, JFK to HNL
arrange(flights, dep_delay)  -- Flight B6 97 (JFK to DEN)

Exercise 5.4.1

#3
x <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(x))

The any_of() function selects variables by utilizing a character 
vector instead of unquoted variable names. This approach is valuable
as it is easier to create character vectors with the names of variables
through programming, compared to generating unquoted variable names, 
which can be typed in more easily.


Exercise 5.5.2

#1
flights <- mutate(flights,
                  dep_time_mins = dep_time %/% 100 * 60 + dep_time %% 100,
                  sched_dep_time_mins = sched_dep_time %/% 100 * 60 +
                    sched_dep_time %% 100)

select(flights, starts_with('dep_time'), starts_with('sched'))

#3
select(flights, dep_time_mins, sched_dep_time_mins, dep_delay)

-- One would expect that the departure delay, represented by the variable "dep_delay", 
would be equivalent to the difference between the scheduled departure time, represented
by the variable "sched_dep_time", and the actual departure time, represented by the 
variable "dep_time": dep_time - sched_dep_time = dep_delay. However, the discrepancy
in the data could be the result of flights that were scheduled to depart before midnight 
but experienced a delay after midnight. 


Exercise 5.6.7 

#5
flights %>%
  filter(arr_delay > 0) %>%
  group_by(carrier) %>%
  summarise(average_arr_delay = mean(arr_delay, na.rm=TRUE)) %>%
  arrange(desc(average_arr_delay))

-- OO has the worst delay.

















