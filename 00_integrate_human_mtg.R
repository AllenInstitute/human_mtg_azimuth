library(Seurat)

data_path <- "/home/rohan/Local/datasets/human_mtg/"
ob <- readRDS(paste(data_path, "Seurat_object.RDS", sep = ""))
ob <- subset(ob, QCpass == "True")
gc()


# Save object per donor to reduce memory footprint of SCTransform
ob.list <-
    SplitObject(object = ob, split.by = "external_donor_name_label")

remove(ob)
gc()

donor_labels <- names(ob.list)
for (label in donor_labels) {
    path <-
        paste(c(data_path, "donor_",
            gsub("\\.", "-", label),
            ".RDS"
        ),
        collapse = "")
    saveRDS(ob.list[label], path, compress = FALSE)
}

remove(ob.list)
gc()

for (label in donor_labels) {
    path <-
        paste(c(data_path, "donor_", gsub("\\.", "-", label), ".RDS"),
              collapse = "")
    ob <- readRDS(path)
    ob <- ob[[1]]
    ob <- SCTransform(ob)
    path <-
        paste(c(data_path, "donor_sct_", gsub("\\.", "-", label), ".RDS"),
              collapse = "")
    saveRDS(ob, path, compress = FALSE)
    remove(ob)
    gc()
}
