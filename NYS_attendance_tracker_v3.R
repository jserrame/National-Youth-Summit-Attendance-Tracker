### National Youth Summit Zoom Attendance Tracker
### - by Aira Serrame, April 26, 2021
## Attendee registration = 569; Attendee engagement frequency = 1487; variables = 31
## National Youth Summit Raffle Contest: the attendee who fully attended the most number of Zoom sessions will be awarded
## $100 Loblaws gift card. The winner will be announced on April 30.

library(tidyverse)
library(dplyr)

nys_rawdata <- read_csv("Data/NYS_attendance.csv")

summary(nys_rawdata)
head(nys_rawdata)

#taking relevant data only
nys_clean <- nys_rawdata %>% 
  select(Meeting_Name, First_name, Last_name, Email) %>% 
  mutate(name = paste(First_name, Last_name)) %>% 
  select(-c(First_name, Last_name))

nys_clean$name <- gsub(" ", "_", nys_clean$name)

#removing sessions that are not part of the contest
nys_clean = filter(nys_clean, !(Meeting_Name %in% c("Break", "Day 1 Information/Tech Support Booth", 
                                                    "Day 2 Information/Tech Support Booth",
                                                    "Virtual Tradeshow",
                                                    "Closing Day 1",
                                                    "Welcome and Opening Remarks",
                                                    "Présentation Jack: Parler de Santé Mentale (Voici le lien pour la nouvelle session en français https://impactcovid2021.us2.pathable.com/meetings/virtual/JRiHnNeWXw59wDLoD)",
                                                    "Closing Day 2")))

nys_clean$Meeting_Name <- gsub(" ", "_", nys_clean$Meeting_Name)

write.csv(nys_clean, file = "nys_clean.csv")

#removing the names of National Youth Summit committee (they're disqualified from the contest)
nys_clean2 <- nys_clean %>% 
  filter(!(name %in% c("Aira_Serrame", "Valerie_S", "Nicole_S", "Patricia_M", "Kowmitha_S", "Peter_S",
                       "Chris_", "Ayesha_R", "Lily_F", "Jessica_M", "Niya_A", "Asli_", "DeRico_S", "Yasamin_M")))


nys_total_attendance <- as.data.frame(table(nys_clean2$name))

write.csv(nys_total_attendance, file = "nys_total_attendance.csv")






