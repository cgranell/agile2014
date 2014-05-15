# load raw data
url <- "https://github.com/cgranell/agile2014/raw/master/data/submissions.csv"
submissions <- read.csv(url, colClasses="character", strip.white=TRUE)

dim(submissions)
# 153 obs. of 5 variables

names(submissions)
# "Submission.ID" "Title" "Acceptance.Status" "Submission.Type" "Keywords" 

# convert columns names into lowercase  
names(submissions) <- tolower(names(submissions))
# cleaning col names and type conversion   
names(submissions)[1] <- "id"
names(submissions)[3] <- "status"
submissions$id <- as.integer(submissions$id)
submissions$status <- as.factor(submissions$status)
submissions$submission.type <- as.factor(submissions$submission.type)

num.submissions <- nrow(submissions)
num.submissions # 153

# extract the lsit of keywords per submission and insret each ne into a different column 
#   1. create a data.frame preallocated with 11 columns: submission id and 10 columns for 10 keywords 
keywords.data <- data.frame(
    id=integer(num.submissions), 
    kw.1=character(num.submissions),
    kw.2=character(num.submissions), 
    kw.3=character(num.submissions), 
    kw.4=character(num.submissions), 
    kw.5=character(num.submissions), 
    kw.6=character(num.submissions), 
    kw.7=character(num.submissions), 
    kw.8=character(num.submissions), 
    kw.9=character(num.submissions), 
    kw.10=character(num.submissions), 
    stringsAsFactors=FALSE)


for(i in 1:num.submissions) {
#   2. For each submission, extract id and list of keywords, split them, and add  
    id <- papers[i, 1]
    keywords <- sapply(strsplit(papers[i, 5],";"), function (x) {
        ifelse (x=="", NA, gsub("^\\s+|\\s+$", "", x))
    })
    keywords <- as.vector(keywords)
#   3. If a submission has less than 10 keywords, then add whitespaces
    keywords[length(keywords)+1:10] <- ""
#   4. Add a new row (submission id + 10 keywords) to the newly-created data.frame
    keywords.data[i, ] <- c(id, keywords)
}


keywords.data[,1] <- as.integer(keywords.data[,1])

#   5. Merge both data frames by the common column: submission id
submissions.clean <- merge(submissions, keywords.data, by="id")

dim(submissions.clean) 
# 153 obs. of 15 variables

# Not run: Save clean data (data frame) into a local file 
write.csv(submissions.clean, "./data/submissions-clean.csv")
