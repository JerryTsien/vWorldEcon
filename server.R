library(shiny)
library(data.table)
library(googleVis)
library(rCharts)
library(reshape2)
#library(markdown)

# Initialize
src <- read.csv(".//data//imf.csv",
                header = TRUE,
                sep = ";",
                na.strings = c("n/a", "--", ""),
                stringsAsFactors = FALSE)
for(i in 3:length(src)){
  src[, i]  <- suppressWarnings(as.numeric(src[, i]))
  }
names(src) <- gsub("X", "", names(src))
indicators <- data.frame(code = c("NGDP_RPCH", "PCPIPCH", "GGXCNL_NGDP", "BCA_NGDPD"),
                  desc = c("Growth", "Inflation", "Budget", "Current Account"))
  
shinyServer(
  function(input, output){
    
    # Render geomap
    output$map <- renderGvis({
      map.data <- src[src$WEO.Subject.Code == 
                        indicators$code[as.numeric(input$map.subject)], ]
      map.yr <- as.character(input$map.year)
      map.data <- map.data[, c("Country", map.yr)]
      map.info <- paste(indicators$desc[as.numeric(input$map.subject)],
                        "in", 
                        as.character(input$map.year),
                        sep = ".")
      names(map.data)[2] <- map.info
      gvisGeoChart(map.data,
                   locationvar = "Country", 
                   colorvar = map.info,
                   options = list(region = input$map.region)
                   )
      }) 
    
    # Render chart
    output$chart <- renderChart2({
      chart.desc <- as.character(indicators$desc[as.numeric(input$chart.subject)])
      chart.info <-paste(chart.desc, input$chart.country, sep = " - ")
      chart.data <- src[src$WEO.Subject.Code == 
                          indicators$code[as.numeric(input$chart.subject)], ]
      chart.data <- chart.data[chart.data$Country == input$chart.country, ]
      chart.rg <- (input$chart.range[1]):(input$chart.range[2]) - (1980 - 3)
      chart.data <- chart.data[, c(2, chart.rg)]
      chart.data <- melt(chart.data,
                         id.vars = c("Country"),
                         variable.name = "Year",
                         value.name = chart.info)
      plot <- nPlot(x = "Year",
                    y = chart.info,
                    data = chart.data,
                    type = input$chart.type)
      plot$chart(margin = list(left = 100)) 
      plot$yAxis(axisLabel = chart.desc) 
      plot$xAxis(axisLabel = "Year") 
      plot
    })

    # Render data table
    output$table <- renderDataTable(
      {
        tb.data <- src[src$WEO.Subject.Code == 
                         indicators$code[as.numeric(input$tb.subject)], ]
        tb.rg <- (input$tb.range[1]):(input$tb.range[2]) - (1980 - 3)
        tb.data <- tb.data[, c(2, tb.rg)]
        tb.data <- data.table(tb.data)
      },
      options = list(lengthMenu = c(10, 20, 50, 100, 200),
                     pageLength = 50,
                     order = list(0, 'asc'),
                     orderClasses = TRUE)
      )
})