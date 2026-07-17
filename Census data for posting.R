# Install packages if you don't have them yet 
library(tidycensus) 
library(dplyr) 
# 1. Set your Census API key # install = TRUE saves it so you don't have to re-enter it every session 
census_api_key("INSERT YOUR KEY HERE", install = TRUE, overwrite = TRUE)
 
# 2. Identify the tables and variables that you want to pull the data from 
acs_vars <- c(
  medicaid_pct   = "S2701_C05_001",  # cell for "with Medicaid/means-tested                    
  hispanic_pct   = "DP05_0071P",
  spanish_ell_pct = "S1601_C02_004",  # C02_004 = Percent, Population 5+, Spanish.
  poverty_pct    = "S1701_C03_001"
)
oh_data <- get_acs( geography = "zcta",  # could also be "tract", "block group", "state", "zcta", etc. 
                    variables = acs_vars, #variables work much better than whole table in terms of speed
                    year = 2023, # most recent 5-year ACS 
                    survey = "acs5" # or "acs1" for 1-year estimates (only available for larger areas) 
) 
#3 Ohio ZIP codes generally start with 43, 44, or 45 
oh_filtered <- oh_data %>%filter(substr(GEOID, 1, 2) %in% c("43", "44", "45"))

# 4. Look at it to be sure the data seems correct 
head(oh_filtered) 
nrow(oh_filtered)

# 5. Save to CSV
write.csv(oh_filtered, "ohio_acs.csv", row.names = FALSE)
getwd()
