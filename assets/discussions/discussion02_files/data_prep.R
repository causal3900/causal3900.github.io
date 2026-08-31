genAI_dta <- read_csv("https://raw.githubusercontent.com/obastani/GenAICanHarmLearning/refs/heads/main/main_regressions/final_data.csv")

genAI_dta$teacher <- as.factor(genAI_dta$teacher)
genAI_dta$Session <- as.factor(genAI_dta$Session)
genAI_dta$Year <- as.factor(genAI_dta$Year)
genAI_dta$Grader <- as.factor(genAI_dta$Grader)


genAI_dta$education_parent_college <- genAI_dta$education_parent >=6

write.csv(genAI_dta,file = "assets/discussions/discussion02_files/GenAI_Learning.csv")
