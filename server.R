library("shiny")


shinyServer(
 function(input, output){
   
   population <- function() {
     population_size = input$input_pop
     population_type = input$input_poptype
     
     
     if (population_type == 'unif'){
       runif(population_size, input$input_min, input$input_max)
     }
     else if(population_type == 'exp'){
       rexp(population_size, input$input_rate)
     }
     else if(population_type == 'pois'){
       rpois(population_size, input$input_mean)
     }
   }
   
   # sample from population
   
   output$out1 <- renderPlot({
     Population <- population()
     hist(Population, col="blue", main = c("Histogram of Population\n", 
                                           sprintf(fmt = "mean=%.2f var=%.2f", mean(Population), var(Population))),
     )
   })
   
   output$out2 <- renderPlot({
     p <- population()
     sample_size = input$input_samplesize
     sample_num = input$input_samplenum
        samples = c()
        for (i in 1:sample_num){
          m = mean(sample(x = p, size = sample_size, replace = T))
          samples = c(samples, m)
        }
     hist(samples, col="blue", main = c("Histogram of means of sample\n", 
                          sprintf(fmt = "mean=%.2f var=%.2f", mean(samples), var(samples)))
          
          )
     
   })
 }
)