library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")
require(EpiModel)


server <- function(input, output) {
  
  #Deterministic Model (SIR model)
  output$dcm <- renderPlot({
    
    
    sd_param <- param.dcm(inf.prob = as.numeric(input$inf_pick), 
                          act.rate = as.numeric(input$sd_pick), 
                          rec.rate = 0.07)
    init <- init.dcm(s.num = 999, i.num = 4,r.num = 0)
    control <- control.dcm(type = "SIR", nsteps = 515, dt = 0.5)
    mod_sd <- dcm(sd_param, init, control)
    
    plot(mod_sd, alpha = 0.75, lwd = 4, main = "DCM Model") 
    
  })
  
  
  # Stochastic/Individual Contact Model (ICM)

  output$icm <- renderPlot ({
    param.icm <- param.icm(
      inf.prob = as.numeric(input$inf_pick),
      act.rate = as.numeric(input$sd_pick), 
      rec.rate = 0.07)
    init.icm <- init.icm(s.num = 999, i.num = 4, r.num = 0)
    control.icm <- control.icm(type = "SIR", nsteps = 515, nsims = 100)
    sim <- icm(param.icm, init.icm, control.icm)
    
    plot(sim, alpha = 0.75, lwd = 4, main = "ICM Model") 
  })
  
}
