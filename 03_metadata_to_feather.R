library(dplyr)
library(feather)

data_path <- "~/Desktop/"

df <- read.csv(paste0(data_path, "MTG_AD_metadata_full.2022-04-13.csv"))
keep_cols <-
    c(
        "sample_id",
        "subclass_scANVI",
        "supertype_scANVI",
        "for_analysis"
    )

df <- df[keep_cols]
df <- df[df$for_analysis == "True", ]
write_feather(df, paste0(data_path, "MTG_AD_metadata_2022-04-13.feather"))
