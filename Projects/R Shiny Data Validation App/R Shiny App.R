library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(tidyverse)
library(readr)
library(ggplot2)
library(jsonlite)
library(DT)
library(stringr)
#install.packages("readxl")
library(readxl)
library(shinythemes)
library(Dict)
library(XML)

  url_choices <- c("Chicago Food Inspection Data 1 (CSV ,)" = "https://uofi.box.com/shared/static/lwwzlv2sulip1p8qoqqghmw0pouso0wk.csv",
                   "Chicago Food Inspection Data 2 (CSV ,)" = "https://uofi.box.com/shared/static/k6h51rdj07jmmiv11q3vmehgr2200eua.csv",
                   "Chicago Food Inspection Data 3 (CSV Tab)" = "https://uofi.box.com/shared/static/zyn1kls0xxpjl3ld0m9w6cl2s3343gov.csv",
                   "CCSO Jail Data (Others ?)" = "https://uofi.box.com/shared/static/lurfpdqk63au11yzra4a88sxizda0iz5.dat",
                   #I changed CCSO Jail Data's link to a box one.
                   "ADS Demo (CSV ,)" = "https://uofi.box.com/shared/static/9b9ecldtxkr23wb3uc36wwbn2l5ylpyx.csv",
                   "Speed Dating (CSV ,)" = "https://uofi.box.com/shared/static/w8vjq29rig8pdvussyg3997h1gwhkimq.csv",
                   "US Presidential Elections (CSV ,)" = "https://uofi.box.com/shared/static/qmhzgom3e1y0lnqd720rnbhp34xyfd6d.csv",
                   "Rental Inspection Grade (Data Batch #1) (CSV ,)" = "https://uofi.box.com/shared/static/l9o50efbnemdnaxury4hg45cj8b2truu.csv", 
                   "Rental Inspection Grade (Data Batch #2) (Others ,)" = "https://uofi.box.com/shared/static/2e2s3l35l2johejjvf0an39g9ucpxfw2.txt",
                    #I changed these two Rental inspection grade link into box one
                   "Rental Inspection Grade (Data Batch #3)" = "https://uofi.box.com/shared/static/8u9xc3vx7opqobd7mwgqys5vvl4p769i.txt", 
                   "Rental Inspection Grade (Data Batch #4)" = "https://uofi.box.com/shared/static/35wer6vc2y7h3frd66tqshsgh2rgo5cg.CSV", 
                   "Rental Inspection Grade (Data Batch #5)" = "https://uofi.box.com/shared/static/4x9rp0fqncuezgh9neowk8h4byhtvi9k.json", 
                   "Rental Inspection Grade (Data Batch #6)" = "https://uofi.box.com/shared/static/pkgt04cxxj25tj9hj0zf2gghrpayzkyz.json",
                   "NBA stint1 (JSON ,)"="https://uofi.box.com/shared/static/fk1q6htmes532jz2obi89zj2v7bobh37.json",
                   "NBA stint2 (JSON ,)"="https://uofi.box.com/shared/static/aix57cgzs4bhzsvorpv924rrv1w57wod.json",
                   "NBA stint3 (JSON ,)"="https://uofi.box.com/shared/static/6a4nbioxh8yek5oppb06jn4429n7fekr.json",
                   "NBA stint4 (JSON ,)"="https://uofi.box.com/shared/static/9ap7efzs42xldrhr1cpt1ql53ip1v25u.json",
                   "Baby Names Iowa (TXT ,)" = "https://uofi.box.com/shared/static/yye6p5kgq0l1dtz6bqz364mr6iz3c3bw.txt",
                   "Baby Names Illinois (TXT ,)" = "https://uofi.box.com/shared/static/ttc01y8x71eadmzc9ramd16ksuq2xckk.txt",
                   "Baby Names Indiana (CSV ,)" = "https://uofi.box.com/shared/static/0ymjj08wid1l19ehy5tx9hjq2xnbse64.csv",
                   "Baby Names Kentucky (TXT Tab)" = "https://uofi.box.com/shared/static/nhfxo34324uratwl3fezx08fcdoknayj.txt",
                   "Baby Names Missouri (CSV ,)" = "https://uofi.box.com/shared/static/p2synnz72z6se94int717w9jhgflmynb.csv",
                   "Baby Names Wisconsin (TXT ,)" = "https://uofi.box.com/shared/static/arv2amejhnyglkc684mgeyp0mcom27tl.txt",
                   "Baby Names National (CSV ,)" = "https://uofi.box.com/shared/static/c2whskv4x21w9pok3qxfh2kdz7jxk1g4.csv",
                   "Speed Dating (CSV ,)" = "https://uofi.box.com/shared/static/w8vjq29rig8pdvussyg3997h1gwhkimq.csv",
                   "US Congress Data (JSON ?)"="https://theunitedstates.io/congress-legislators/legislators-current.json",
                   "Delivery Stores (Others Whitespace)"="https://uofi.box.com/shared/static/o2bqah52ioj0p0q4msvna7ixk8d9lsh4",
                   "other" = "other",
                   "Owners Address" = "https://uofi.box.com/shared/static/6rvh7umhjuqkzlqnf4r3mu0ol865yd8p",
                   "Trips (TXT Tab)" = "https://uofi.box.com/shared/static/0pyqnfpl40kr5do7fue8t85vva11ynjm.txt",
                   "Covid Data (CSV ,)" = "https://github.com/nytimes/covid-19-data/raw/master/us-states.csv",
                   "Nuisance Complaints (Others Tab)" = "https://data.urbanaillinois.us/api/views/tsn9-95m3/rows.tsv?accessType=DOWNLOAD&bom=true",
                   "Urbana Market at the Square Vendor Products (CSV ,)" = "https://data.urbanaillinois.us/api/views/6gtk-bwms/rows.csv?accessType=DOWNLOAD",
                   #added the data set Daily Crime Log
                   "Daily Crime Log (CSV ,)" = "https://uofi.box.com/shared/static/7uah46fdogn8gdc1zy06efuxsfpqif4g.csv",
                   #I added "zoom script"  data
                   "Zoom Script (Others ?)" = "https://uofi.box.com/shared/static/9fi7g4kc9db009nla5abq25lp2o8lkqa.vtt",
                   #I added FBI Table 6 data
                   "Table 6" = "https://uofi.box.com/shared/static/bmy3oaer6we9zts1bsfyidmki8uko6um")

#created the basic UI with the functions to let users enter the URL
ui = navbarPage(title = "440 Data Engineers",
                tabPanel(title = "Data File Importing",
                         #main page
                         fluidPage(
                           themeSelector(),
                           setBackgroundColor(
                             color = "Tan",
                             gradient = "linear",
                             direction = "bottom"),
                           uiOutput("style"),
                           #https://stackoverflow.com/questions/61632272/r-shiny-light-dark-mode-switch
                           tags$head(
                             tags$style(
                               HTML(
                                 "
                                .dataTables_length label,
                                .dataTables_filter label,
                                .dataTables_info {
                                    color: black!important;
                                    background: #f8f8ff!important; #allows 'show [] entries' text, 'search:' text, and 'showing 1 to x of n entries text to be seen in both light and dark mode
                                    }
                        
                                .paginate_button {
                                    background: white!important;
                                }
                        
                                thead {
                                    color: black;
                                    background: #f8f8ff!important; #allows table's column names to be seen in both light and dark mode
                                    }
                        
                                "
                               )
                             )
                           ),
                           h1("Data File Importing", style = "font-family:Arial"),
                           h4("Welcome to the 440 Data Engineers' RShiny App! We understand that data engineering can be time-consuming and tedious, so we made an app to do the work for you. First, upload your data or choose one of the data sets already included in the app. Then using the app, either validate your data, clean your data, or both.", style = "font-family:Arial"),
                           sidebarLayout(
                             
                             sidebarPanel(
                               # Enter URL or choose from existing datasets
                               
                               selectizeInput("url",
                                              label = "Enter your URL, upload a file, or choose from one of the below datasets",
                                              selected = NULL,
                                              options = list(create = TRUE),
                                              choices = c("Use the dropdown list" = "",
                                                          # to add additional data sets, please add them to the url_choices vector down in the code under server = function(input, output, session)
                                                          url_choices[sort(names(url_choices), decreasing = FALSE)])),
                               uiOutput("urlother"),
                               fileInput("urlupload", "Upload file"),
                               selectizeInput("type",
                                              label = "What is the file extension?",
                                              selected = NULL,
                                              options = list(create = TRUE),
                                              choices = c("Choose the file extension" = "", str_sort(c("CSV", "TXT", "JSON", "XLSX","TSV")),"Others")),
                               #Can be ignored if the file extension is JSON
                               selectizeInput("delim",
                                              label = "Choose delimiter",
                                              selected = NULL,
                                              options = list(create = TRUE), 
                                              choices = c("Choose delimiter" = "", str_sort(c("Comma", "Semicolon", "Tab", "Whitespace", "Colon","Slash", "Pipe", "Backslash", "Braces")))),
                               checkboxInput("checkbox", "Data already includes headers?", value = TRUE),
                               numericInput("num", "Select the number of rows to display:", value = 20),
                               actionButton("Submit" , label = "Submit"),
                              actionButton("rest_input", label = "Reset") #to reset choices idea
                             ),
                             mainPanel(
                               dataTableOutput("table"),
                               uiOutput("style_checkbox")
                             )
                           )
                         )
                ),
                
                #for validating strategies
                tabPanel(title = "Data Validating Strategies",
                         fluidPage(
                           h1("Data Validation Strategies", style = "font-family:Arial"),
                           sidebarLayout(
                             sidebarPanel(
                               # Enter URL or choose from existing datasets
                               
                               selectInput("val_type",
                                           label = "Choose your validation strategies:",
                                           choices = c("Use the dropdown list" = "", str_sort(c("Filtering and Arranging", "Counting Frequencies and Duplicates", "Computing Summary Statistics", "Visualizing Distributions", "Column Selection", "Row Selection")))),
                               
                               selectInput("variable", "Which variable do you want to validate?", choices = NULL),
                              
                               
                               selectInput("col", "Which column(s) do you want to select? Please correctly spell the column(s) name, Separated by \",\" :", choices = NULL, multiple = TRUE),
                               
                               actionButton("Submit" , label = "Submit")
                             ),
                             mainPanel(
                               dataTableOutput("validation")
                             )
                           )
                           
                         )
                ),
                
                #for cleaning approach
                tabPanel(title = "Data Cleaning Approaches",
                         fluidPage(
                           h1("Data Cleaning Approaches", style = "font-family:Arial"),
                           sidebarLayout(
                             sidebarPanel(
                               # Enter URL or choose from existing datasets
                               
                               selectInput("clean_approach",
                                           label = "Choose your cleaning approaches:",
                                           choices = c("Use the dropdown list" = "", str_sort(c("Removing Duplicate Observations", "Fixing Rounding Errors and Inconsistent Units of Measurement",
                                                       "Removing or Replacing Missing Values", "Limiting a Distribution to its Realistic Set of Observations",
                                                       "Correcting and Subsetting with Dates", "Correcting Misspelled Words or Abbreviations", "Make Lowercase", "Make Uppercase")))),
                               textInput("variable_clean", "Which variable do you want to clean the dataset with? Please correctly spell the variable name:"),
                               
                               actionButton("Submit" , label = "Submit")
                             ),
                             mainPanel(
                               dataTableOutput("cleaning")
                             )
                           )
                           
                         )
                ),
                navbarMenu("More",
                           tabPanel(title = "Data Summarization",
                                    fluidPage(
                                      h1("Data Summarization", style = "font-family:Arial"),
                                      h4("This tab allows the user to summarize a variable by a certain statistic, which includes mean and variance.", style = "font-family:Arial"),
                                      sidebarLayout(
                                        sidebarPanel(
                                          selectInput(inputId = "function",
                                                      label = "Choose your summarize function:",
                                                      choices = c("Use the dropdown list" = "", str_sort(c("Sum", "Mean",
                                                                  "Median", "Variance",
                                                                  "Standard Deviation", "Number of Observations")))),
                                          textInput(inputId = "group",
                                                    label = "Group data by:"),
                                          actionButton("Submit" , label = "Submit"),
                                          
                                          textInput(inputId = "ChildrenName", label = "Enter your Child's Name to Check How Many kids Have the Same Name with Your Kid's"),
                                          
                                          
                                          actionButton("Submit", label = "Submit"),
                                        ),
                                        mainPanel(
                                          dataTableOutput("summarize"),
                                          
                                          plotOutput(outputId = "ChildrenName")
                                        )
                                      )
                                      
                                    )),                 
                           tabPanel("Data Structure Information",
                                    fluidPage(
                                      h1("Data Structure Information", style = "font-family:Arial"),
                                      h4("This area will allow the user to check a certain variables type, such as whether is a character, numeric, or a date", style = "font-family:Arial"),
                                      sidebarLayout(
                                        sidebarPanel(
                                          textInput("variable", "Which variable do you want to check? Please correctly spell the variable name:"),
                                          actionButton("Submit" , label = "Submit")
                                        ),
                                        mainPanel(
                                          dataTableOutput("structure_var")
                                        )
                                      ),
                                      verbatimTextOutput("structure", placeholder = TRUE))),
                           
                           tabPanel("Comment this app",
                                    fluidPage(
                                      h1("Comment", style = "font-family:Arial"),
                                      h4("Comment and rate this app for futher improvement."),
                                      sidebarLayout(
                                        sidebarPanel(
                                          selectInput(inputId = "Rate", label = "Please Rate your satisfaction level of this app.",
                                                      choices = c("Excellent", "Good", "General", "Bad", "Very Bad")),
                                          textInput(inputId = "best_function", label = "What was your favorite part of the app"),
                                          textInput(inputId = "poor_function", label = "What did you dislike about the app"),
                                          textInput(inputId = "New_function", label = "Please leave any suggestions to improve the app (e.g. New function)"),
                                          textInput(inputId = "User Email", label = "Please leave your Email for us to contact you further when the app is updated"),
                                          actionButton("Submit", label = "Submit")
                                          
                                        ),
                                      mainPanel(
                                        dataTableOutput("Comments")
                                      ),
                                      ),
                                    ),
                             
                           ),
                           
                           
                           tabPanel("App Theme settings", 
                                    uiOutput("style"),
                                    actionButton("Black_mode", "Black mode"),
                                    actionButton("Light_mode","Light mode"),
                                    actionButton("+", "Larger font size", icon("plus")),
                                    actionButton("-", "Smaller font size", icon("minus"))),
                           tabPanel(tags$a(href = "https://github-dev.cs.illinois.edu/stat440-fa21/stat440-fa21-final-project/issues", icon("question-sign", lib ="glyphicon")))),
               tabPanel("About", "Hello! We are Fall 2021 students at the University of Illinois at Urbana-Champaign enrolled in STAT 440 (Statistical Data Management). In this course, we have developed fundamental data wrangling skills in order to create this functioning app! Every student in this course has made a contribution to this app in order for you to have a great experience. We want to thank our Instructor, Christopher Kinson, for guiding us and teaching us valuable data wrangling skills.

We hope that your experience with this app is a great success!"))

                           

                #Creating pages that does other functions? Hopefully?



server = function(input, output, session) {
  
  ind_night <- as.difftime(format(Sys.time(), format = "%H:%M"),units = "hours", format = "%H:%M") <= 7 | as.difftime(format(Sys.time(), format = "%H:%M"),units = "hours", format = "%H:%M") >= 18

  current_theme <- reactiveVal(ind_night)
  
  observeEvent(input$Black_mode,{
    print("Dark Mode enabled")
    current_theme(TRUE)
    output$style <- renderUI({
      includeCSS("css-files/darkly.min.css")
    })
  })

  observeEvent(input$Light_mode,{
    print("Light Mode enabled")
    current_theme(FALSE)
    output$style <- renderUI({
      includeCSS("css-files/flatly.min.css")
    })
  })
  
  output$style <- renderUI({
    if (!is.null(input$style)) {
      current_theme(input$style)
      if (input$style) {
        includeCSS("css-files/darkly.min.css")
      } else {
        includeCSS("css-files/flatly.min.css")
      }
    }
  })
 
 
  observeEvent(input$urlupload, {
    updateSelectInput(session, "url", label = "Enter your URL, upload a file, or choose from one of the below datasets",
                      choices = c("Use the dropdown list" = "",
                                  "File upload" = input$urlupload$datapath,
                                  url_choices[sort(names(url_choices), decreasing = FALSE)]),
                      selected = input$urlupload$datapath)
  })

  importedData = NULL
  observe({
    if(input$url == "other")
    {
      output$urlother <- renderUI({
        textInput("urlother", "If the url you want is not on our list, type it here:" , value = " ")
      })
    }
  })
  
  
  data1 =reactive({
    
    if (input$url != "") {
      # Fix "Chicago Food Inspection Data 3" (CSV file but delimiter is Tab) to display properly in the  table  
      if (input$type == "CSV" & input$delim == "Tab") {   
        print("The file extension is CSV, and delimitor is Tab")
        delim = "\t"
        data = read_delim(input$url, delim = delim)
      } else if (input$type == "CSV" ) {
        print("Data type is CSV")
        data = read_csv(input$url)
      } else if (input$type == "JSON") {
        print("Data type is JSON")
        data = fromJSON(input$url)
      } else if (input$type == "TXT") {
        print("Data type is TXT")
        data = read(input$url)
      } else if (input$type == "others") {
        print("Data type is others")
        if (input$delim == "Comma")
          delim = ","
        else if (input$delim == "Semicolon")
          delim = ";"
        else if (input$delim == "Tab")
          delim = "\t"
        else if (input$delim == "Whitespace")
          delim = " "
        else if (input$delim == "Slash")
          delim = "/"
       else if (input$delim == "Pipe")
        delim = "|"
       else if (input$delim == "Backslash")
         delim = "\\"
       else if (input$delim == "Braces")
         delim = "{}"
       else if (input$delim == "Colon")
         delim = ":"
        else
          delim = input$delim
        data = read_delim(input$url, delim = delim)
      } else {
        data = NA
      }
      data = as.data.frame(data)
      for (j in 1:ncol(data)) {
        if (is.character(data[1,j])) {
          for (i in 1:nrow(data)) {
            if (!is.na(data[i,j]) & nchar(data[i,j]) > 30) 
              data[i,j] = paste(strtrim(data[i,j], 30), "...", sep = "")
          }
        }
      }
      if (!is.na(data)) 
        data
    }
    
  })
  
  observeEvent(input$Submit,{
    if(input$url != "other"){
      output$table = renderDataTable({
        data = if (input$url != "") {
          # Fix "Chicago Food Inspection Data 3" (CSV file but delimiter is Tab) to display properly in the  table  
          if (input$type == "CSV" & input$delim == "Tab") {   
            print("The file extension is CSV, and delimiter is Tab")
            delim = "\t"
            if (input$checkbox == TRUE){
              data = read_delim(input$url, delim = delim)
            } else if (input$checkbox == FALSE){
              data = read_delim(input$url, delim = delim, col_names=FALSE)
            }
          } else if (input$type == "CSV" ) {
            print("Data type is CSV")
            if (input$checkbox == TRUE){
              data = read_csv(input$url)
            } else if (input$checkbox == FALSE){
              data = read_csv(input$url, col_names=FALSE)
            }
          } else if (input$type == "JSON") {
            print("Data type is JSON")
            data = fromJSON(input$url)
          } else if (input$type == "TXT") {
            print("Data type is TXT")
            data = read_csv(input$url)
          } else if (input$type == "XLSX") {
            print("Data type is XLSX")
            data = read_xlsx(input$url)
          } else if (input$type == "TSV"){
            print("Data type is TSV")
            data = read_tsv(input$url)
          } else if (input$type == "others") {
            print("Data type is others")
            if (input$delim == "Comma")
              delim = ","
            else if (input$delim == "Semicolon")
              delim = ";"
            else if (input$delim == "Tab")
              delim = "\t"
            else if (input$delim == "Whitespace")
              delim = " "
            else if (input$delim == "Colon")
              delim = ":"
            else if (input$delim == "Pipe")
              delim = "|"
            else if (input$delim == "Backslash")
              delim = "\\"
            else if (input$delim == "Slash")
              delim = "/"
           else if (input$delim == "Braces")
              delim = "{}"
            else
              delim = input$delim
            data = read_delim(input$url, delim = delim)
          } else {
            data = NA
          }
          data = as.data.frame(data)
          for (j in 1:ncol(data)) {
            if (is.character(data[1,j])) {
              for (i in 1:nrow(data)) {
                if (!is.na(data[i,j]) & nchar(data[i,j]) > 30) 
                  data[i,j] = paste(strtrim(data[i,j], 30), "...", sep = "")
              }
            }
          }
          if (sum(is.na(data)) != sum(dim(data)[1]* dim(data)[2]))
            head(data, n = input$num) # Show the number of rows users want to show
          importedData <<- data
        }
       
        #control the number of data rows that we'd like to display
        #if inserted number exceeds the limit then display full set
        #coerce number to integer
        displayrow<-as.integer(input$num)
        if (displayrow>1 & displayrow<=nrow(data))
        {
          sampledata=data[c(1:displayrow),]
        }
        else
        {
          sampledata=data
        }       
       
        # add a filter for each column
        DT::datatable(sampledata,
                      extensions = "Scroller",
                      filter = "top",
                      # add horizontal scrolling for datatable
                      options = list(scrollX = TRUE)
        )
      })
    }
  })
  
  observe({
    # Code from above to retrieve imported dataset
    data = if (input$url != "") {
      # Fix "Chicago Food Inspection Data 3" (CSV file but delimiter is Tab) to display properly in the  table  
      if (input$type == "CSV" & input$delim == "Tab") {   
        print("The file extension is CSV, and delimiter is Tab")
        delim = "\t"
        if (input$checkbox == TRUE){
          data = read_delim(input$url, delim = delim)
        } else if (input$checkbox == FALSE){
          data = read_delim(input$url, delim = delim, col_names=FALSE)
        }
      } else if (input$type == "CSV" ) {
        print("Data type is CSV")
        if (input$checkbox == TRUE){
          data = read_csv(input$url)
        } else if (input$checkbox == FALSE){
          data = read_csv(input$url, col_names=FALSE)
        }
      } else if (input$type == "JSON") {
        print("Data type is JSON")
        data = fromJSON(input$url)
      } else if (input$type == "TXT") {
        print("Data type is TXT")
        data = read_csv(input$url)
      } else if (input$type == "XLSX") {
        print("Data type is XLSX")
        data = read_xlsx(input$url)
      } else if (input$type == "TSV"){
        print("Data type is TSV")
        data = read_tsv(input$url)
      } else if (input$type == "XML"){
        print("Data type is XML")
        data = xmlParse(input$url)
      } else if (input$type == "others") {
        print("Data type is others")
        if (input$delim == "Comma")
          delim = ","
        else if (input$delim == "Semicolon")
          delim = ";"
        else if (input$delim == "Tab")
          delim = "\t"
        else if (input$delim == "Whitespace")
          delim = " "
        else if (input$delim == "Colon")
          delim = ":"
        else if (input$delim == "Pipe")
          delim = "|"
        else if (input$delim == "Backslash")
         delim = "\\"
        else if (input$delim == "Slash")
          delim = "/"
       else if (input$delim == "Braces")
          delim = "{}"
        else
          delim = input$delim
        data = read_delim(input$url, delim = delim)
      } else {
        data = NA
      }
      data = as.data.frame(data)
      for (j in 1:ncol(data)) {
        if (is.character(data[1,j])) {
          for (i in 1:nrow(data)) {
            if (!is.na(data[i,j]) & nchar(data[i,j]) > 30) 
              data[i,j] = paste(strtrim(data[i,j], 30), "...", sep = "")
          }
        }
      }
      if (sum(is.na(data)) != sum(dim(data)[1]* dim(data)[2]))
        head(data, n = input$num) # Show the number of rows users want to show
      importedData <<- data
      
      # Creates variable selection for Data validation page
      updateVarSelectInput(session, "variable", "Which variable do you want to validate?", data = importedData)
      # Make variable selection easier
      updateVarSelectInput(session, "col", "Which column(s) do you want to select?", data = importedData)
    }
  })
  
  
  output$validation = renderDataTable({
    # Bring down imported data from Data File Importing
    # data = ...
    if (input$val_type != '') {
      # Check that data is not empty and validation strategy is selected
      # if (!is.na(data) && input$val_type != '') {
      if (input$val_type == "Filtering and Arranging") {
        print('Filtering and Arranging')
        importedData %>% #arranging
          arrange(input$variable)
        
      } else if (input$val_type == "Counting Frequencies and Duplicates") {
        print('Counting Frequencies and Duplicates (Categorical)')
        # add code here
        duplicate <- vector()
        frequencies <- vector()
        check <- data1()
        for (i in length(check)) {
          if (check[i] %in% frequencies) {
            frequencies$check[i] = frequencies$check[i] + 1
            if (check[i] %in% duplicate) {
              print("Here")
            } else {
              duplicate <- append(duplicate, check[i])
            }
          } else {
            frequencies$check[i] = 1
          }
        }

        print("Duplicates:", duplicate)
        print("Frequency:", frequencies)
      } else if (input$val_type == "Computing Summary Statistics") {
        print('Computing Summary Statistics (Numeric)')
        data_temp=data1()
        summary(data_temp)
      } else if (input$val_type == "Visualizing Distributions") {
        print('Visualizing Distributions')
        selectedColumn <- unlist(strsplit(input$col, ","))
        plot(importedData$selectedColumn[2],
             importedData$selectedColumn[1],
             xlim=range(importedData$selectedColumn[2],na.rm=TRUE),
             ylim=range(importedData$selectedColumn[1],na.rm=TRUE),
             type = "p",
             main = "Visualization")
        # add code here
      } else if(input$val_type == "Column Selection"){
        selectedColumn <- unlist(strsplit(input$col, ","))
        importedData <- importedData  %>% 
          select(c(selectedColumn))
      } else if(input$val_type == "Row Selection"){
        selectedRow <- unlist(strsplit(input$row, ","))
        importeddata <- importeddata %>%
          select(c(selectedRow))
        } else {
        # other methods to be added?
      }
      
    }
  })
  
  output$cleaning = renderDataTable({
    importedData
    
    #If the user misspelled the variable, it would find the closest variable in the data set to it
    if(variable_clean != c(colnames(importedData))){
      importedData %>%
        variable_clean = agrep(variable_clean, c(colnames(importedData)), max = 2, value = TRUE)
    }
    
    # Notifies the User if the Data File has not been imported
    if (input$clean_approach != " " && is.null(importedData)) {
      data.frame("EMPTY_DATA_FILE" = "Please Import a Data File")
      
      #Removing Missing Values
    } else if (input$clean_approach == "Removing or Replacing Missing Values") {
      importedData %>%
        drop_na()
      #Remove Duplicate Observations
    } else if (input$clean_approach == "Removing Duplicate Observations") {
      importedData %>%
        distinct()
    } else if (input$clean_approach == "Fixing Rounding Errors and Inconsistent Units of Measurement"){
      print('Fixing Rounding Errors and Inconsistent Units of Measurement')
      # Correcting and Subsetting with Dates
      importedData %>%
        mutate_if(is.numeric, round, digits = 3)
    } else if (input$clean_approach == "Correcting and Subsetting with Dates") {
      i <- which(sapply(importedData, function(x)
        ! all(is.na(as.Date(
          as.character(x),
          format = c("%d/%m/%Y", "%d-%m-%Y", "%Y/%m/%d", "%Y-%m-%d")
        )))) == TRUE)
      n = length(i)
      for (p in 1:n) {
        importedData[,i[p]] <-lubridate::mdy(importedData[,i[p]])
      }
      importedData
    } 
    # I added method to place selected variable in lower case
    else if (input$clean_approach == "Make Lowercase") {
      importedData %>%
        variable_clean = tolower(variable_clean)
    }
    #added method to place variable in uppercase
    else if (input$clean_approach == "Make Uppercase") {
      importedData %>%
        variable_clean = toupper(variable_clean)
    }
    else {
      # other methods to be added? Misspelled and abreviations?
    }
    
  })
  
  # print the structure of the data
  output$structure <- renderPrint({
    str(importedData)
    # add head, tail, and summary of data
    head(importedData)
    tail(importedData)
    summary(importedData)
  })

  output$ChildrenName <- renderPlot({
    Name = read.csv("https://uofi.box.com/shared/static/c2whskv4x21w9pok3qxfh2kdz7jxk1g4.csv")
    data = Name %>% filter(name == input$ChildrenName)
    ggplot(data) + geom_bar(aes(x = sex, y = freq), stat = "identity") + facet_wrap(~ year) + labs(x = "Sex", y = "Frequency", title = "Frequency of the Name")
  })
  
}
# Run the application
shinyApp(ui, server)
