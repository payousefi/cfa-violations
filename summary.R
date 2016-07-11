# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #
#
#   Code for America Fellowship 2016
#   Technical Question
#
#   by Payam Yousefi, July 11, 2016
#
#   Calculate the number of violations in each category,
#   and the earliest and latest violation date for each category.
#
#   Language: R (useful for working with datasets to generate quick data)
#   Presentation format: Markdown (or HTML, LaTeX)
#
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

# Read the CSV file
violations <- read.csv("Violations-2012.csv")

# Convert dates to sortable R date objects
dates = as.POSIXlt(violations$violation_date)

# Select columns we're interested in (category + date)
df <- data.frame(cat = violations$violation_category, date = dates)

# Calculate frequency, earliest and latest dates
freq <- as.data.frame(table(violations$violation_category))
freq$earliest <- aggregate(df$date~df$cat, df, min)[,2] # collapse data, add column
freq$latest <- aggregate(df$date~df$cat, df, max)[,2]

# Output some Markdown (can also output HTML, LaTeX), using knitr library
library("knitr")

# sends output to file (set SPLIT = TRUE to send to console for debugging)
sink("data.md", append = FALSE, split = TRUE)
kable(freq, format = "markdown", col.names = c("Category", "Violations", "Earliest Date", "Latest Date"))
