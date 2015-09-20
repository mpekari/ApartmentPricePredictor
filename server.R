### Apartment Price Predictor
### Author: Matti Pekari
### Description: This Shiny application predicts the price  
### of an apartment with inputted attributes.

library(shiny)
library(kernlab)

# Load the predictive model from a file
model <- load("apartment_prices_model_svm.rda")

shinyServer(
    function(input, output) {
        output$prediction <- renderPrint({

            # Read input values into a data frame
            data <- data.frame( Zip=input$zip, 
                                Rooms=3, 
                                m2=input$m2, 
                                Year=input$year, 
                                Floor=input$floor,
                                Elevator=input$elevator,
                                Condition=input$condition)

            # Generate a prediction for the apartment price
            prediction <- predict(get(model), data, type = "decision")[[1]]
            
            # Round the predicted price to integer
            round(x = prediction, digits = 0)            
        })      
    }
)