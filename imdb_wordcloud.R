install.packages("wordcloud")
library(wordcloud)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("wordcloud2")
library(wordcloud2)
install.packages("tm")
library(tm)
install.packages("dplyr")
library(dplyr)

imdb_review<-read.csv("E:/Surface ????????????/Study/?????????????????????????????????/?????????_?????????/Summer School/summer school_dataset.csv")


#Create a vector containing only the text
Review <- imdb_review$Review

# Create a corpus  
docs <- Corpus(VectorSource(Review))

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

# mannually remove undesired words
custom_stopwords <- c("amazing", "become", "best", "better", "chi", "feel", "film", "lot", "movie", "nice", "overall", "people", "really", "rings", "shang chi", "shang-chi", "shangchi", "something", "ten", "watch", "years", "just","like","also", "good", "great","movies","much","one","even","dont","thing","well","way","see","can","say","felt","will")
docs <- tm_map(docs, removeWords, custom_stopwords)

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
