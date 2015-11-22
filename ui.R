library("shiny")

shinyUI(
  fluidPage(
  pageWithSidebar(
  headerPanel("Enter distribution parameters"),
    sidebarPanel(
      tabsetPanel(
        tabPanel("About", 
                 p("This project demonstrates a simple example of the", strong("Central Limit Theorum")),
                 p("Central Limit Theorum states that",  em("when a population is repeatedly sampled for n
                   number of times, the means of the sample takes on a normal distribution with the mean
                   mu that equals the population mean and variance v that equals population variance divided by the size of the sample")),
                 p("In the input tab are several widgets which control parameters like population size, population distribution type (exponential, possion, uniform) and sample size as well as number of samples."),
                 p("Adjusting these widgets, the central Limit Theorum can be observed in various cases."),
                 p("To use this app, first select widget parameters and then press the submit button. The output is updated accordingly.")
        ),
        tabPanel("Input", 
                 h4("Population length"),
                 sliderInput("input_pop", NULL, 20, 1000, 100, 20),
                 h4("Population Type"),
                 selectInput("input_poptype", NULL, choices = c("Poisson"='pois', 
                                                                "Exponential" = 'exp', 
                                                                "Uniform" = 'unif'), 
                             selected="pois"),
                 
                 div(id="pois",
                     numericInput("input_mean", "lamda", 10, 6, 30, 2)
                 ),
                 div(
                   id = "exp", style="display:none",
                   
                   numericInput("input_rate", "rate", 1, 1, 10, 1)
                 ),
                 div(
                   id = 'unif',
                   style = "display:none",
                   numericInput("input_min", "min", 10, 5, 19, 2),
                   numericInput("input_max", "max", 20, 20, 30, 2)
                 ),
                 h4("Sample size"),
                 sliderInput("input_samplesize", NULL, 10, 100, 20, 10),
                 h4("Numer of samples"),
                 sliderInput("input_samplenum", NULL, 20, 500, 100, 20),
                 submitButton("Submit!")
                )
        )
      ),
  mainPanel(
    h3("Population plot"),
    plotOutput(outputId = "out1"),
    
    h3("Mean of samples plot"),
    plotOutput(outputId = "out2"),
    
    HTML("<script>
         $('#input_poptype').on('change', function (e){
          $('#pois').hide(); $('#exp').hide(); $('#unif').hide();
         if (this.value == 'pois'){
            $('#pois').show();
         }
         if (this.value == 'unif')
            $('#unif').show();
         if (this.value == 'exp')
            $('#exp').show();
         })</script>")
    
    )
  ))
  
  )