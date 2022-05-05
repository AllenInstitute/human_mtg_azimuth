library(dplyr)
library(feather)

df <- read.csv("~/Desktop/MTG_AD_metadata_full.2022-04-13.csv")
keep_cols <-
    c(
        "sample_id",
        "cell_name",
        "cell_id",
        "cellNames",
        "n_genes",
        "class",
        "subclass",
        "subclass_color",
        "cluster",
        "cluster_color",
        "supertype",
        "subclass_scANVI",
        "supertype_scANVI",
        "for_analysis"
    )

df_part <- df[keep_cols]
write_feather(df_part, "~/Desktop/MTG_AD_metadata_2022-04-13.feather")
