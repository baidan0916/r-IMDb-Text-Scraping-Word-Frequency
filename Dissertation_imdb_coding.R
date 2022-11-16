library(rvest)
library(xml2)

web <- 'https://www.imdb.com/title/tt9376612/reviews?ref_=tt_urv'
website <- read_html(web)
website

review_data_html <- html_nodes(website,'.lister-item-content')
#Converting the title data to text
review_data <- html_text(review_data_html)
head(review_data)

