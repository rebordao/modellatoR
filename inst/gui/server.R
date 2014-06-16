library(shiny)
library(data.table)
library(knitr)

# Sets up the max size for the files the users can upload
options(shiny.maxRequestSize=50*1024^2, shiny.trace=F) # max = 50 MB

# small hack to go back to the root folder
# TODO: check better ways to do this (do it via a package + gui)
setwd('..')

shinyServer(function(input, output, session) {

  # Build widgets to upload the data
  output$uploader1 <- renderUI({
    if (input$typeAnalysis != 'Performance Analysis') {
      fileInput("rawFile1", h4("Upload Your Data"), multiple=FALSE)
    } else {
      fileInput("rawFile1", h4("Upload Your Train Data"), multiple=FALSE)
    }  
  })
  
  output$uploader2 <- renderUI({
    fileInput("rawFile2", h4("Upload Your Test Data"), multiple=FALSE)
  })
    
  # Reads uploaded data
  dat <- reactive(
    if (is.null(input$rawFile1)) return() else {
      fread(input$rawFile1$datapath, header=T, stringsAsFactors=T, na.strings="NA")
    }
  )
  
  # Reads testset when specified
  dat.test <- reactive(
    if (is.null(input$rawFile2)) return() else {
      fread(input$rawFile2$datapath, header=T, stringsAsFactors=T, na.strings="NA")
    }
  )

  # Writes uploaded data into folder `data`
  observe(
    if (is.null(input$rawFile1)) return () else {
      write.csv(dat(),
                  paste0(getwd(), '/data/trainset.csv'))
    }
  )

  observe(
    if (is.null(input$rawFile2)) return () else {
      write.csv(dat.test(),
                  paste0(getwd(), '/data/testset.csv'))
    }
  )
  
  # Builds menu to choose the Output Variable
  output$chooseOutVar <- renderUI({
    if (input$typeAnalysis == "Exploratory Analysis" | is.null(head(dat()))) {
      return()
    } else {
      selectInput("outVar",
                  h4("Choose the Output Variable"),
                  choices=colnames(head(dat())),
                  selected=tail(colnames(head(dat())), 1),
                  multiple=F,
                  selectize=T)
    }
  })

  # Builds menu to choose the Positive Class
#   observe(
#     output$choosePosClass <- renderUI({
#       isClassifT <- class(head(dat())[[input$outVar]]) %in% c("character", "factor")
#       if (!is.null(input$rawFile1) & isClassifT) {
#       cho <- unique(dat()[[input$outVar]])
#       selectInput("posClass", h4("Choose the Positive Class"), choices=cho, multiple=F)
#     } else return()
#   })
# )

  # Sets up the training method
  # !!! don't change these choices without also changing the 
  # initialization of the list params in server.R !!!
  observe({
    if (is.null(input$outVar)) return() else {
      output$chooseMethodName <- renderUI(
        radioButtons("methodName",
                     h4("Choose the Training Method"),
                     choices=c("Linear Regression",
                               "Decision Trees",
                               "Random Forest",
                               "Neural Network"),
                     selected=c("Random Forest")
        )
      )
    }
  })

  # Builds metadata, and starts the analysis
  observe({
    
    if (input$startButton > 0) { # if the action button is clicked
    
      # Initializes list with parameters
      params <- list()
      params$projectName <- input$projectName
      params$outVar <- input$outVar
      params$methodName <- input$methodName
      
      params$methodID <- switch(input$methodName,
                                "Decision Trees" = 'dt',
                                "Random Forest" = 'rf',
                                "Linear Regression" = 'glm',
                                "Neural Network" = 'nn'
                                )
      
      # regression is T <=> classification is F
      params$regression <- !class(dat()[[params$outVar]]) %in% c("character", "factor")
      if (!params$regression) {
        params$classification <- !params$regression
        params$posClass <- input$posClass # sets up the positive class
      }
    
      # Saves params into file
      saveRDS(params, './config/params.RData')
            
      # Executes the intended analysis
      if (input$typeAnalysis == "Exploratory Analysis") {
        source('./src/01_ExploratoryAnalysis.R')
      } else if (input$typeAnalysis == "Sensitivity Analysis") {
        source('./src/02_SensitivityAnalysis.R')
      } else {
        source('./src/03_PerformanceAnalysis.R')
      }

      params <- readRDS('./config/params.RData')

      # Builds the report file and its download button
      output$downloadReport <- {
      
        firstLetter <- tolower(strsplit(input$typeAnalysis, '')[[1]][1])
        dirPath <- sprintf("%s/%s/%s/%sAnalysis_%s_%s",
                           getwd(), 'reports', sub(' ', '', input$typeAnalysis),
                           firstLetter, params$methodID, params$timestamp)
        fileName <- paste0(params$methodID, '_', params$timestamp, '.pdf')
        
        downloadHandler(filename = function() fileName,
                        content = function(file) file.copy(
                          sprintf("%s/%s", dirPath, fileName), file, overwrite=T),
                        contentType='application/pdf'
        )
      }
  }})
})