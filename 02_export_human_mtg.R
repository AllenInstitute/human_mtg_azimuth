library(Seurat)
library(Azimuth)

data_path <- "/home/rohan/Local/datasets/human_mtg/"
ref <-
    readRDS(paste(data_path, "human_mtg_integrated.RDS", sep = ""))

Idents(object = ref) <- "subclass_label"
ref$class <- factor(ref$class_label)
ref$cluster <- factor(ref$cluster_label)
ref$subclass <- factor(ref$subclass_label)
ref <- subset(x = ref, downsample = 2000)
gc()

clusters<-ref@meta.data[c('cluster','cluster_color')]
clusters <- clusters[!duplicated(clusters), ]

subclasses<-ref@meta.data[c('subclass','subclass_color')]
subclasses <- subclasses[!duplicated(subclasses), ]

classes<-ref@meta.data[c('class','class_color')]
classes <- classes[!duplicated(classes), ]

class_cmap <- CreateColorMap(ref, ids = classes$class,
                             colors = classes$class_color)

subclass_cmap <- CreateColorMap(ref, ids = subclasses$subclass,
                                colors = subclasses$subclass_color)

cluster_cmap <- CreateColorMap(ref, ids = clusters$cluster,
                              colors = clusters$cluster_color)



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


# Not sure how to transfer colors with 'slot' with SetColorMap
# Setting a single 'color' cmap through AzimuthReference argument does not work.
# Following is a hacky solution for now
ref@tools$AzimuthReference@colormap$cluster <- cluster_cmap
ref@tools$AzimuthReference@colormap$class <- class_cmap
ref@tools$AzimuthReference@colormap$subclass <- subclass_cmap

SaveAnnoyIndex(ref[["refdr.annoy.neighbors"]],
               file = paste(data_path, "/ref_proc/idx.annoy", sep = ""))
saveRDS(ref, file = paste(data_path, "/ref_proc/ref.Rds", sep = ""))
