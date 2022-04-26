library(Seurat)
library(Azimuth)

data_path <- "/home/rohan/Local/datasets/human_mtg/"
ref <-
    readRDS(paste(data_path, "human_mtg_integrated.RDS", sep = ""))

Idents(object = ref) <- "subclass_label"
ref$class <- ref$class_label
ref$cluster <- ref$cluster_label
ref$subclass <- ref$subclass_label
ref <- subset(x = ref, downsample = 2000)
gc()

ref <- RunUMAP(
    object = ref,
    reduction = "pca",
    dims = 1:30,
    return.model = TRUE
)
gc()

ref <- AzimuthReference(
    object = ref,
    refUMAP = "umap",
    refDR = "pca",
    refAssay = "integrated",
    metadata = c("class", "subclass", "cluster"),
    dims = 1:50,
    k.param = 31,
    reference.version = "1.0.0"
)

SaveAnnoyIndex(ref[["refdr.annoy.neighbors"]],
               file = paste(data_path, "/ref_proc/idx.annoy", sep = ""))
saveRDS(ref, file = paste(data_path, "/ref_proc/ref.Rds", sep = ""))
