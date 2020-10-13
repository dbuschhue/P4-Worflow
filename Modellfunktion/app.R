library(shiny)
library(tibble)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    plotOutput("distPlot"),
    
    sliderInput("delta",
                    "Aufgabenschwierigkeit",
                    width = '100%',
                    min = -5,
                    max = 5,
                    step = 0.1,
                    value = 0
        )
)

# Define server logic required to draw the plot
server <- function(input, output) {

    output$distPlot <- renderPlot({
        P_1 <- tibble(theta = seq(-5,5,by=0.01), P = (exp(theta-input$delta))/(1+exp(theta-input$delta)))
        ggplot(P_1, aes(theta, P)) + 
               geom_path(colour="blue", size=1) + 
               xlab(expression("Personenfähigkeit " ~ theta)) +
               ylab(expression("Wahrscheinlichkeit einer richtigen Antwort P(1|"*theta*")")) +
               ylim(0, 1)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
