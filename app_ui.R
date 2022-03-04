library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")


intro_page <- tabPanel(
  "Introduction",
  tags$body(
    mainPanel(
      h1("Introduction"),
      p("This shiny application displays an interactive disease modeling 
        simulation of the COVID-19 spread. This application allows users to select 
        different social distancing interventions and choose between the absence
        or presence of mask mandates to explore how these factors influence the spread of COVID-19. 
        
        
        " 
      )
      
    )
    
  ))




# Select a social distancing intervention
sd_pick <- selectInput(
  inputId = "sd_pick",
  label = " Enforce Strict Social Distancing Intervention",
  choices = list(
    "None" = 0.996,
    "Small gathering cancellation" = 0.1, 
    "School closures" = 0.4,
    "Airport restriction" = 0.5
  ),
  selected = "none", 
  multiple = FALSE
)

# Mandate mask or no mask
inf_pick <- radioButtons(
  inputId = "inf_pick",
  label = "Public Mask Mandate",
  choices = list(
    "No" = 0.996,
    "Yes" = 0.33
  ),
  selected = 0.996
)


dcm_page <-
  tabPanel(
    "Deterministic Model",
    titlePanel("Deterministic Model"),
    sidebarLayout(
      sidebarPanel(sd_pick, inf_pick),
      mainPanel(
        plotOutput("dcm")
      )
    )
  )




icm_page <- tabPanel(
  "Stochastic Model",
  titlePanel("Stochastic Model"),
  sidebarLayout(
    sidebarPanel(sd_pick, inf_pick),
    mainPanel(
      p("Note: Please be patient, models take awhile to load."),
      plotOutput("icm")
    )
  )
)


interpretation_page <- tabPanel(
  "Interpretation",
  titlePanel("Interpretation"),
  tags$body(
    mainPanel(
      h3("Parameters"), 
      p(
        "The parameters set:
        999 susceptible people (s.num), 4 infected people (i.num), 500 iterations (n.steps)."), 
      
      p("Act.rate is the likelihood of encountering someone infected with COVID-19 The social
      distance intervention policy changes the Act.rate. In the 
      Enforce Strict Social Distancing Intervention widget, selecting “None” means
      that there is no social distancing intervention enforced, so people are in close 
      proximity to each other, allowing the virus to spread quickly. This causes there be
      a high 99.6% likelihood of encountering an infected person (act.rate = 0.996). 
      
      Selecting “Small gathering cancellation” means there are restrictions for people to gather
      in small or large places. This causes the COVID-19 transmission to greatly drop and there is now
      only a 10% likelihood of encountering an infected person (act.rate = 0.1). 
      
      Selecting “School closures” means there are in-person closures of schools and institutions to
      reduce transmission. This causes there to be 40% likelihood of encountering an infected person (act.rate = 0.4). 
      
      Selecting “Airport Restriction” means there are traveling restrictions at the airport, 
      causing the  the chance of encountering an infected person to be 50% (act.rate = 0.5)."),
      
      p("Inf.prob is the probability of transmitting the disease in an interaction with others. 
      The presence or absence of masks mandates will change this value. 
      The absence of masks causes there to be a  99.6% chance of transmission (inf.prob = 0.996).
      The presence of masks causes there to be a  33% chance of transmission (inf.prob = 0.33)."),
       
      
      p("Rec.rate is the recovery rate in days. Rec.rate =  0.07 means that it will take 
        someone 14 days to recover after being infected (1/14 = 0.07)."), 
      
      
      
      h3("Deterministic Model (DCM)"), 
      
      p("Based on this model below, when there is no social distancing intervention
      enforced and there is no public mask mandate, there was the highest number of
      people infected with COVID-19 (the red line represents i.num = infected number of people)"), 
      
      img( src = "highest_infected.png", width = "500px", height = "400px"),
      
      p(" When both or either the mask mandate and any social distancing intervention was enforced, 
      the number of in the number of infected people greatly decreased. The model below
      shows the lines are the flattest and the number of infected people is very low when 
      both public mandated masks and cancelled small gatherings were enforced." ),
      
      img( src = "low_infected.png", width = "500px", height = "400px"),
      
      h3("Stochastic Model (IMC)"), 
      
      p("In the IMC model, the curve for number of infected people drops and
      flattens when both mask mandates and social distancing policies are enforced."), 
      
    
      p("This model below shows when both school closure intervention and mask mandate 
        are enforced."),
      
      img( src = "imc_school.png", width = "500px", height = "400px"),
      
      p("This model below shows when both airport restriction intervention and mask mandate 
        are enforced."),
      
      img( src = "imc_airport.png", width = "500px", height = "400px"),
      
      p("When comparing these two models, the school closure has
      a greater number of susceptible people than the airport restrictions. In addition,
      the airport restriction infection curve shifted to left and has a higher peak.
      This may mean that those who get infected got infected in a shorter amount of time."), 
      
      
      p("These two models are under the conditions of no social distancing intervention
      enforced and the presence of public mask mandate enforced. A difference I observed between the IMC and DMC models 
      is that the IMC model overall show fewer number of infections than the DCM model."),
      
      img( src = "imc.png", width = "500px", height = "400px"),
      img( src = "dcm.png", width = "500px", height = "400px"),
      
      
      h3("Limitations"),
      p("There are many limitations to these models. This data is based on estimates
      and is not constantly up-to-date to our most recent COVID-19 situation, with
      vaccinations, various changing policy mandates and more. Model estimates
      are most likely underestimating the number of infections because there are many people
      who are asymptomatic and did not get tested. In addition,
      the models are assumed that there were initially 4 infected people with a population of 999 people,
      but in reality there is more than 4 infected people and 
      the population is greater than 999 people."),
      
      
      
      
    )))


ui <- fluidPage(
  navbarPage(
    "COVID-19 Disease Modeling",
    intro_page,
    dcm_page,
    icm_page,
    interpretation_page
  )
)