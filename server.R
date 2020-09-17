#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
server = function(input, output) {
    output$COVID_plot <- renderPlot({
        plot(COVID$date,COVID[[input$features]], xlab='Date',
             ylab='Data of COVID', main='COVID vs time')
        scatter.smooth(COVID$date,COVID[[input$features]]
        )
    })
    output$stock_plot <- renderPlot({
        plot(stocks$Date, stocks[[input$stock]],
             xlab='Date', ylab='Stock', main='Stock vs time')
        scatter.smooth(stocks$Date, stocks[[input$stock]]
        )
    })
    output$google_plot <- renderPlot({
        plot(VecPlots$GOOG.Close,VecPlots[[input$google]],
             xlab = 'Google',ylab='COVID',main='Google vs COVID')
        scatter.smooth(VecPlots$GOOG.Close,VecPlots[[input$google]]
        )
    })
    output$zoom_plot <- renderPlot({
        plot(VecPlots$ZM.Close,VecPlots[[input$zoom]],
             xlab = 'Zoom',ylab='COVID',main='Zoom vs COVID')
        scatter.smooth(VecPlots$ZM.Close,VecPlots[[input$zoom]]
        )
    })
    output$tesla_plot <- renderPlot({
        plot(VecPlots$TSLA.Close,VecPlots[[input$tesla]],
             xlab = 'Tesla',ylab='COVID',main='Tesla vs COVID')
        scatter.smooth(VecPlots$TSLA.Close,VecPlots[[input$tesla]]
        )
    })
}
