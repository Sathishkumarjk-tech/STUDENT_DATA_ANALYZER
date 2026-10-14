# Student Data Analyzer
# Run: source("main.R")

data_file <- "students.csv"
if (!file.exists(data_file)) {
  stop("students.csv was not found. Open the project folder as your working directory.")
}

students <- read.csv(data_file, stringsAsFactors = FALSE)
required_columns <- c("Name", "Tamil", "English", "Maths")
if (!all(required_columns %in% names(students))) {
  stop("CSV must contain: Name, Tamil, English, Maths")
}

subjects <- c("Tamil", "English", "Maths")
students$Total <- rowSums(students[subjects])
students$Average <- round(students$Total / length(subjects), 2)
students$Grade <- ifelse(students$Average >= 90, "A",
                  ifelse(students$Average >= 75, "B",
                  ifelse(students$Average >= 60, "C",
                  ifelse(students$Average >= 40, "D", "F"))))

cat("\n--- STUDENT PERFORMANCE REPORT ---\n")
print(students, row.names = FALSE)
cat("\nClass average:", round(mean(students$Average), 2), "\n")
cat("Highest average:", max(students$Average), "\n")
cat("Lowest average:", min(students$Average), "\n")

write.csv(students, "student_report.csv", row.names = FALSE)
cat("\nReport saved to student_report.csv\n")
