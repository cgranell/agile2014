library(treemap)    # treemap function 

# load clean data
url <- "https://github.com/cgranell/agile2014/raw/master/data/submissions-clean.csv"
treemap.data <- read.csv(url, colClasses="character")

dim(treemap.data)
# 153 obs. of 16 variables

names(treemap.data)
# "X" "id" "title" "status" "submission.type" "keywords" "kw.1" "kw.2" "kw.3" "kw.4" "kw.5" "kw.6" "kw.7" "kw.8" "kw.9" "kw.10"

# type conversions
treemap.data[,1] <- as.integer(treemap.data[,1])
treemap.data[,2] <- as.integer(treemap.data[,2])
treemap.data[,4] <- as.factor(treemap.data[,4])
treemap.data[,5] <- as.factor(treemap.data[,5])

# counts the occurrences of a categorical variable (kw$1)
counts <- table(treemap.data$status, treemap.data$kw.1)

# transforms it to data frame 
treemap.df <- as.data.frame(counts)

colnames(treemap.df) <- c("status", "kw.1", "count")

# copy defaults settings
opar <- par() 

# open jpef file
jpeg(filename = "treemap-agile.jpeg", quality=100, width = 1400, height = 1200, units = "px")
par(mfrow=c(1, 1), mar=c(1, 1, 1, 1))

treemap(treemap.df, 
        index = c("kw.1", "status"), 
        vSize = "count" , 
        vColor = "status", 
        type = "categorical", 
        title="AGILE 2014 Treemap",  
        fontsize.labels=c(12, 8), 
        align.labels=list(c("center", "center"), c("left", "top")),
        force.print.labels=TRUE,
        lowerbound.cex.labels=1, 
        palette="PiYG",
        bg.labels="#DCDCDC00", # color is "#RRGGBBAA" and the AA portion is the trasparency
        border.col = c("black","white"), # defines line colour 
        border.lwds = c(2,1), # defines line width
        title.legend="Acceptance status",
        position.legend = "right") # remove legend)

# close jpeg
dev.off()
# restore settings
par(opar) 