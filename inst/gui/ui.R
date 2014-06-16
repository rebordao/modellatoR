library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h1("modell@tor", style="color:orange")),
  
  sidebarLayout(

    sidebarPanel(
      
      # Widget to set up the name of project
      textInput("projectName", h4("Write the Name of Your Project")),

      # Widget to set up the type of the analysis
      radioButtons("typeAnalysis",
                   h4("Choose the Analysis"),
                   choices=c("Exploratory Analysis",
                             "Performance Analysis", 
                             "Sensitivity Analysis")
      ),
            
      # Widget to upload the train and test sets
      uiOutput("uploader1"),
      conditionalPanel(
        "input.typeAnalysis == 'Performance Analysis'",
        uiOutput("uploader2")
      ),
            
      # Widget to choose the output variable
      uiOutput("chooseOutVar"),
      
      # Widget to choose the positive class (for a classification task)
      uiOutput("choosePosClass"),
      
      # Widget to choose the training method
      conditionalPanel(
        "input.typeAnalysis != 'Exploratory Analysis'",
        uiOutput("chooseMethodName")
      ),
      
      # Button to start the analysis
      actionButton("startButton", "Click Here To Start Analysis"),
      
      # Download link for the report
      downloadLink("downloadReport", label=h4("Download Report"))
    ),
    
    mainPanel(
    
      h1("Introducing modell@tor", style="color:orange"),
      
      p(a(strong("modell@tor"), href="https://github.com/rebordao/modellator",
        target='_blank'), "is a tool for semi-automatic Statistical Analysis
        that allows people to understand better their data. It's built around
        the concept that people only have to do the preprocessing and choose a
        model. The rest is automatically done by our software."),
    
      p("It's licensed under a", a(
        "MIT License", href="http://opensource.org/licenses/MIT", target="_blank"),
        "and freely available at",
        a("github", href="https://github.com/rebordao/modellator", target='_blank'),
        img(src = "bigorb.png", height = 72, width = 72)),
      
      h1("How To Use It", style="color:orange"),
    
      p("On the left sidebar choose your model by starting top down and,
        when you're ready, click on the button on the botton. Then wait until
        the report is done and available for download.")
    ),
  )
))