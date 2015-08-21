library(shiny)
library(rCharts)

shinyUI(
  navbarPage("Visualized World Economy",
             theme = "cerulean.css",
             tabPanel(p(icon("globe"), "Map"),
                      sidebarLayout(position = "left",
                                    sidebarPanel(
                                      selectInput("map.region",
                                                  label = h4("Region"), 
                                                  choices = list("World" = "world",
                                                                 "Africa" = "002",
                                                                 "Americas" = "019",
                                                                 "Asia" = "142",
                                                                 "Europe" = "150",
                                                                 "Oceania" = "009"),
                                                  selected = "world"),
                                      sliderInput("map.year",
                                                  label = h4("Year"),
                                                  sep = "",
                                                  min = 1980,
                                                  max = 2015,
                                                  value = 2015),
                                      
                                      selectInput("map.subject",
                                                  label = h4("Indicator"), 
                                                  choices = list("Real GDP Growth" = 1,
                                                                 "Inflation" = 2,
                                                                 "Budget Balance / GDP" = 3,
                                                                 "Current Account Balance / GDP" = 4),
                                                  selected = 1),
                                      width = 3
                                    ),
                                    mainPanel(
                                      htmlOutput("map")
                                    )
                      )
             ),
             tabPanel(p(icon("bar-chart"), "Chart"),
                      sidebarLayout(position = "left",
                                    sidebarPanel(
                                      selectInput("chart.country",
                                                  label = h4("Country"), 
                                                  choices = list("Afghanistan", "Albania", "Algeria", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan",
                                                                 "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina",
                                                                 "Botswana", "Brazil", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon",
                                                                 "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Costa Rica", "Cote d'Ivoire", "Croatia",
                                                                 "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador",
                                                                 "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finland", "France", "FYR Macedonia", "Gabon", "Georgia",
                                                                 "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras",
                                                                 "Hong Kong SAR", "Hungary", "Iceland", "India", "Indonesia", "Iraq", "Ireland", "Islamic Republic of Iran", "Israel", "Italy",
                                                                 "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea", "Kosovo", "Kuwait", "Kyrgyz Republic",
                                                                 "Lao P.D.R.", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Lithuania", "Luxembourg", "Madagascar", "Malawi",
                                                                 "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova",
                                                                 "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nepal", "Netherlands", "New Zealand", "Nicaragua",
                                                                 "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru",
                                                                 "Philippines", "Poland", "Portugal", "Qatar", "Republic of Congo", "Romania", "Russia", "Rwanda", "Samoa", "San Marino",
                                                                 "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovak Republic", "Slovenia", "Solomon Islands",
                                                                 "South Africa", "South Sudan", "Spain", "Sri Lanka", "St. Kitts and Nevis", "St. Lucia", "St. Vincent and the Grenadines", "Sudan", "Suriname", "Swaziland",
                                                                 "Sweden", "Switzerland", "Syria", "Taiwan Province of China", "Tajikistan", "Tanzania", "Thailand", "The Bahamas", "The Gambia", "Timor-Leste",
                                                                 "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates",
                                                                 "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"),
                                                  selected = "United States"),
                                      sliderInput("chart.range", 
                                                  label = h4("Year Range"),
                                                  sep = "",
                                                  min = 1980,
                                                  max = 2015,
                                                  value = c(2006, 2015)),
                                      selectInput("chart.subject",
                                                  label = h4("Indicator"), 
                                                  choices = list("Real GDP Growth" = 1,
                                                                 "Inflation" = 2,
                                                                 "Budget Balance / GDP" = 3,
                                                                 "Current Account Balance / GDP" = 4),
                                                  selected = 1),
                                      radioButtons("chart.type",
                                                   label = h4("Chart Type"),
                                                   choices = list("Bars" = "multiBarChart",
                                                                  "Line" = "lineChart",
                                                                  "Scatter Points" = "scatterChart"),
                                                   selected = "multiBarChart"),
                                    width = 3
                                    ),
                                    mainPanel(
                                      showOutput("chart", "nvd3")
                                    )
                      )
             ),
             tabPanel(p(icon("table"), "Table"),
                      sidebarLayout(position = "left",
                                    sidebarPanel(
                                      sliderInput("tb.range", 
                                                  label = h4("Year Range"),
                                                  sep = "",
                                                  min = 1980,
                                                  max = 2015,
                                                  value = c(2006, 2015)),
                                      selectInput("tb.subject",
                                                  label = h4("Indicator"), 
                                                  choices = list("Real GDP Growth" = 1,
                                                                 "Inflation" = 2,
                                                                 "Budget Balance / GDP" = 3,
                                                                 "Current Account Balance / GDP" = 4),
                                                  selected = 1),
                                      width = 3
                                    ),
                                    mainPanel(
                                      dataTableOutput(outputId = "table")
                                    )
                      )
             ),
             tabPanel(p(icon("life-ring"), "Help"),
                      includeMarkdown("help.Rmd")
             ),
             tabPanel(p(icon("book"), "About"),
                      h4("Visualized World Economy v1.0", align = "center"),
                      h4(a("https://JerryTsien.shinyapps.io/vWorldEcon",
                           href = "https://JerryTsien.shinyapps.io/vWorldEcon"),
                         align = "center"),
                      h4("Developed by Jerry Tsien, August 20, 2015.", align = "center"),
                      br(),
                      br(),
                      br(),
                      h4("Source code available at Github:", align = "center"),
                      h4(a("https://github.com/JerryTsien/vWorldEcon",
                           href = "https://github.com/JerryTsien/vWorldEcon"),
                         align = "center"),
                      h4("Based on the IMF World Economic Outlook database, April 2015.", align = "center"),
                      h4(a("http://www.imf.org/external/pubs/ft/weo/2015/01/weodata/download.aspx",
                           href = "http://www.imf.org/external/pubs/ft/weo/2015/01/weodata/download.aspx"),
                         align = "center"),
                      tags$style(type = 'text/css',
                                 "footer{position: absolute; bottom:5%; left: 33%;}"),                                            
                      HTML('<footer><img alt="Creative Commons License" src="cc_by_sa.png" /><h5><a href="http://creativecommons.org/licenses/by-sa/4.0/">'),
                      HTML('Creative Commons Attribution-ShareAlike 4.0 International License.</a></h5></footer>')
             )
  )
)