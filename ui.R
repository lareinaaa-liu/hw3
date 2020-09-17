#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(shinydashboard)
library(quantmod)
library(semantic.dashboard)

getSymbols('ZM', src='yahoo', from='2020-01-22', to='2020-09-15')
getSymbols('GOOG',from='2020-01-22', to='2020-09-15')
getSymbols('TSLA', src='yahoo', from='2020-01-22', to='2020-09-15')

stocks=as.xts(data.frame(GOOG[,'GOOG.Close'],ZM[,'ZM.Close']
                         ,TSLA[,'TSLA.Close']))
write.zoo(stocks,'stocks.cvs',index.name = 'Date',sep=',')
head(stocks)

AllDates = intersect((COVID$date),(stocks$Date))
VecPlots = data.frame(Date=AllDates,
                      deathIncrease=COVID$deathIncrease[match(AllDates,COVID$date)],
                      hospitalizedIncrease=COVID$hospitalizedIncrease[match(AllDates,COVID$date)],
                      positiveIncrease=COVID$positiveIncrease[match(AllDates,COVID$date)],
                      GOOG.Close=stocks$GOOG.Close[match(AllDates,stocks$Date)],
                      ZM.Close=stocks$ZM.Close[match(AllDates,stocks$Date)],
                      TSLA.Close=stocks$TSLA.Close[match(AllDates,stocks$Date)]
)

ui = dashboardPage(title = 'Demo App', theme = 'slate',
                   dashboardHeader(title = "My dashboard",color = 'blue'),
                   dashboardSidebar(size = 'thin',color = 'teal',
                                    sidebarMenu(
                                        menuItem("COVID", tabName = "covid", icon = icon("lungs-virus")),
                                        menuItem("Stock", tabName = "stock", icon = icon("business-time")),
                                        menuItem('Correlation',tabName = 'COVID vs Stock',
                                                 icon = icon('connectdevelop'),
                                                 menuSubItem('GOOG',tabName = 'Google'),
                                                 menuSubItem('ZM',tabName = 'Zoom'),
                                                 menuSubItem('TSLA',tabName = 'Tesla'))
                                    )
                   ),
                   dashboardBody(
                       tabItems(
                           tabItem("covid",
                                   box(plotOutput('COVID_plot'),width = 8),
                                   box(
                                       selectInput('features','Data of COVID:',
                                                   c('deathIncrease','hospitalizedIncrease',
                                                     'positiveIncrease')),width=2
                                   )
                           ),
                           tabItem('stock',
                                   box(plotOutput('stock_plot'),width = 8),
                                   box(
                                       selectInput('stock','Stock:',
                                                   c('GOOG.Close','ZM.Close',
                                                     'TSLA.Close')),width = 2
                                   )
                           ),
                           tabItem('Google',
                                   box(plotOutput('google_plot'),width = 8),
                                   box(
                                       selectInput('google','Data of COVID:',
                                                   c('deathIncrease','hospitalizedIncrease',
                                                     'positiveIncrease')),width = 2
                                   )
                           ),
                           tabItem('Zoom',
                                   box(plotOutput('zoom_plot'),width = 8),
                                   box(
                                       selectInput('zoom','Data of COVID:',
                                                   c('deathIncrease','hospitalizedIncrease',
                                                     'positiveIncrease')),width = 2
                                   )
                           ),
                           tabItem('Tesla',
                                   box(plotOutput('tesla_plot'),width = 8),
                                   box(
                                       selectInput('tesla','Data of COVID:',
                                                   c('deathIncrease','hospitalizedIncrease',
                                                     'positiveIncrease')),width = 2
                                   )
                           )
                       )
                   )
)
