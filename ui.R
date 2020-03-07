library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)
library(dplyr)
library(nnet)


dashboardPage(
  dashboardHeader(title="Euna Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("widget", tabName = "widget", icon = icon("box")),
      menuItem("practice", tabName = "practice", icon=icon("pencil-alt")),
      menuItem("Database", tabName = "Database", icon = icon("database")),
      menuItem("EDA", tabName = "EDA", icon = icon("chart-pie")),
      menuItem("Modeling", tabName = "Modeling", icon = icon("chart-line"))
    )
  ),
  dashboardBody(
    tabItems(
      #first tab(widget)-----------------------------------------
      tabItem(tabName = "widget",
              fluidRow(
                column(3,
                       h3("Buttons"),
                       actionButton(inputId = "action",
                                    label = "Action")),
                column(3,
                       checkboxGroupInput(inputId = "checkGroup",
                                          label = h3("Checkbox group"),
                                          choices = list("Choice 1" = 1,
                                                         "Choice 2" = 2,
                                                         "Choice 3" = 3),
                                          selected = 1)),
                column(3,
                       dateInput(inputId = "date",
                                 label = h3("Date input"),
                                 value = "2019-02-23"))),
              fluidRow(
                column(3,
                       dateRangeInput("dates", h3("Date range"))),
                column(3,
                       fileInput("file", h3("File input"))),
                column(3,
                       numericInput("num",
                                    h3("Numeric input"),
                                    value = 1))),
              fluidRow(
                column(3,
                       selectInput(inputId = "select", #inputId:server.R과 연동되는 이름
                                   label = h3("select box"), #label:화면에 보여질 이름
                                   choices = list("Choice 1" = 1, "Choice 2" = 2,
                                                  "Choice 3" = 3), selected = 1)), #selected/value:초기값
                column(3,
                       sliderInput(inputId = "slider1",
                                   label = h3("Sliders"),
                                   min = 0, max = 100, value = 50),
                       
                       sliderInput("slider2", "",
                                   min = 0, max = 100, value = c(25,75))),
                
                column(3,
                       textInput("text", h3("Text input"),
                                 value = "Enter text..."))
              )),
      #second tab(practice)----------------------------------------
      tabItem(tabName = "practice",
              fluidRow(box(width=6,
                           selectInput("species", #ui에서 InputId를 species로 설정(->Input값을 사용하기 위해 server에서는 input$사용)
                                       label="Choose Species type in Data iris",
                                       choices = c("None", as.character(unique(iris$Species))), #unique:중복없이 유일한 관측치만 남기기
                                       selected = "None")),
                       box(width=6,
                           textOutput("selected_species"))) #input값으로 text를 render하고, selected species라는 output이름 생성/
      ),
      #third tab(database)----------------------------
      tabItem(tabName = "Database",
              fluidRow(column(6,
                              fileInput("data", "Load data(Only csv!!)",
                                        multiple = F, #multiple:여러 파일 허용?
                                        accept = c('.csv')))), #accept:허용할 파일 형식
              fluidRow(box(width=12,DT::dataTableOutput("iris_df"), #dataTableOutput,renderDataTable:DT패키지 안에 존재
                           style="height:400px; overflow-y: scroll; overflow-x: scroll;"))), #???
      #fourth tab(EDA)------------------------
      tabItem(tabName = "EDA",
              fluidRow(box(width = 4,
                           uiOutput("xvar"),
                           uiOutput("yvar"),
                           uiOutput("species_chk"),
                           actionButton(inputId="draw",
                                        label = "draw plot")
                           ),
                       box(width=8,
                           plotOutput("plot_iris"))))
    )
  )
)
