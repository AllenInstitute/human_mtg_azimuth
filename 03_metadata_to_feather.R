library(dplyr)
library(feather)

df <- read.csv("~/Desktop/MTG_AD_metadata_full.2022-04-13.csv")
keep_cols <-
    c(
        "sample_id",
        "subclass_scANVI",
        "supertype_scANVI",
        "for_analysis"
    )

df <- df[keep_cols]
df <- df[df$for_analysis=="True", ]
write_feather(df, "~/Desktop/MTG_AD_metadata_2022-04-13.feather")
