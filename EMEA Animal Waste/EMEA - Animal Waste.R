# Load necessary libraries
library("dplyr")
library("tidyr")
library("ggplot2")
library("reshape2")
library("forecast")
library("moments")

# Read the data
animal_waste_data <- read.csv("C:\\Users\\Rajeswari Sohith\\Downloads\\Rajeswari Bellamkonda\\UNdata_Export.csv")

# Filter data for EMEA countries
emea_countries <- c("Armenia", "Ethiopia", "France", "Germany", "Hungary", "Pakistan", "Poland", "Spain", "Tunisia", "United Kingdom")
emea_data <- animal_waste_data %>%
  filter(Country %in% emea_countries)

# 1. Descriptive Statistical Analysis
# Calculating summary statistics
summary_stats <- emea_data %>%
  group_by(Country, Year) %>%
  summarise(mean_quantity = mean(Quantity),
            median_quantity = median(Quantity),
            sd_quantity = sd(Quantity),
            skewness = skewness(Quantity),
            kurtosis = kurtosis(Quantity))

# Display summary statistics
cat("------- Descriptive Statistical Analysis -------\n")
print(summary_stats)
cat("----------------------------------------------\n\n")

# 2. Correlation Analysis
# Calculating correlation matrix
production_imports_data <- emea_data %>%
  filter(Commodity %in% c("Animal waste - Production", "Animal waste - Imports"))

pivot_data <- production_imports_data %>%
  pivot_wider(names_from = Commodity, values_from = Quantity)

pivot_data[, -1] <- lapply(pivot_data[, -1], function(x) {
  as.numeric(as.character(x))
})

cols_with_zero_var <- names(which(sapply(pivot_data[, -1], sd) == 0))
pivot_data <- pivot_data[, !names(pivot_data) %in% cols_with_zero_var]



correlation_matrix <- cor(pivot_data[, -1], use = "pairwise.complete.obs")

melted_correlation <- reshape2::melt(correlation_matrix)

correlation_plot <- ggplot(data = melted_correlation, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "red", high = "green") +
  theme_minimal() +
  labs(title = "Correlation Heatmap: Production vs Imports", x = "Variable", y = "Variable")

# Display correlation matrix and heatmap
cat("------- Correlation Analysis -------\n")
cat("Correlation Matrix:\n")
print(correlation_matrix)

cat("\nCorrelation Heatmap:\n")
print(correlation_plot)
cat("---------------------------------\n\n")

# 3. Hypothesis Testing
# Perform hypothesis tests for specific countries
test_result_year <- function(country_name) {
  data_2020 <- emea_data$Quantity[emea_data$Year == 2020 & emea_data$Country == country_name]
  data_2014 <- emea_data$Quantity[emea_data$Year == 2014 & emea_data$Country == country_name]
  
  if (length(unique(data_2020)) > 1 && length(unique(data_2014)) > 1) {
    result <- t.test(data_2020, data_2014)
    return(result)
  } else {
    return("Insufficient or constant data for the specified years.")
  }
}

test_result_for_unitedkingdom <- test_result_year("United Kingdom")
test_result_for_germany <- test_result_year("Germany")


# Display hypothesis test results
cat("------- Hypothesis Testing -------\n")


cat("\nHypothesis Test Result for United Kingdom:\n")
print(test_result_for_unitedkingdom)

cat("Hypothesis Test Result for Germany:\n")
print(test_result_for_germany)

cat("---------------------------------\n\n")

# 4. Regression Analysis 
# Performing regression analysis
regression_model <- lm(Quantity ~ Year + Country, data = emea_data)

# Display regression analysis summary
cat("------- Regression Analysis -------\n")
print(summary(regression_model))
cat("----------------------------------\n\n")

# 5. Time Series Analysis (SARIMA Model)
# Building SARIMA model
ts_data <- ts(emea_data$Quantity[emea_data$Country == "Ethiopia"], frequency = 1)
sarima_model <- auto.arima(ts_data, seasonal = TRUE)

# Display SARIMA model details
cat("------- Time Series Analysis (SARIMA Model) -------\n")
print(sarima_model)
cat("----------------------------------------------\n\n")
