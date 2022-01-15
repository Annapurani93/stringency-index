library(tidyverse)
library(readxl)

read_excel("stringency.xlsx")->data

data%>%
  filter(Entity=="United States"|
           Entity=="India"|
           Entity=="Brazil"|
           Entity=="United Kingdom"|
           Entity=="France")->data1

as.Date(data1$Day)->data1$Day
colnames(data1)<-c("Country","Date","Stringency")
ggplot(data1,aes(x=Date,y=Stringency))+
  geom_line(aes(group=Country,colour=Country),size=1.5)+
  theme(plot.background = element_rect(fill="black"),
        panel.background = element_rect(fill =  "black"),
        axis.text = element_text(colour="white",face = "bold"),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.margin = unit(c(.5, 1, .5, 1), "cm"),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        legend.title = element_blank(),
        legend.background = element_rect(fill =  "black"),
        legend.key = element_rect(fill =  "black"),
        legend.text = element_text(colour="white",face = "bold",size=11),
        legend.position = "top",
        plot.title=element_text(size=16, colour = "#f4f4f8", face="bold"),
        plot.subtitle=element_text(size=11, colour="white", margin=margin(b=15)),
        plot.caption=element_text(hjust=0, size=9, colour="#f4f4f8", margin=margin(t=15)))+
  labs(title="GOVERNMENTS INCREASE STRINGENCY EVEN AS COVID INFECTIONS SURGE ACROSS COUNTRIES",
       subtitle = str_wrap("The Stringency Index of the top five countries with the highest number of cumulative Covid infections has risen again. This is due to the recent surge in cases due to the Omicron variant.
                           For the uninitiated, the Stringency index is part of the Oxford COVID-19 Government Response Tracker (OxCGRT) and is a composite measure based on nine response indicators including school closures, workplace closures, cancellation of public events, restrictions on public gatherings, closures of public transport, stay-at-home requirements, public information campaigns, restrictions on internal movements, and international travel controls.
                           The index on any given day is calculated as the mean score of the nine metrics, each taking a value between 0 and 100.
                           A higher score indicates a stricter government response (i.e. 100 = strictest response). ",180),
       caption = "Data from Our World in Data| Analysis and design: @annapurani93")->plot

ggsave("StringencyIndex.png",plot,height=8,width=14)
