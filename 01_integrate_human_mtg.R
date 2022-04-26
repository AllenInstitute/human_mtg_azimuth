# Part 2 for integration. Requires >200 Gb memory.
library(Seurat)

data_path <-
    "/allen/programs/celltypes/workgroups/mousecelltypes/Rohan/dat/proc/human_mtg/"
donor_labels = c("H18.30.002",
                 "H19.30.001",
                 "H19.30.002",
                 "H200.1023",
                 "H18.30.001")

print("Loading objects into a list ...")
oblist = list()
for (label in donor_labels) {
    path <-
        paste(c(data_path, "donor_sct_", gsub("\\.", "-", label), ".RDS"),
              collapse = "")
    oblist <- append(oblist, readRDS(path))
}
print("Loaded all objects successfully")


print("Preparing for integration ...")
print(Sys.time())
features <- SelectIntegrationFeatures(object.list = oblist,
                                      nfeatures = 3000)
oblist <- PrepSCTIntegration(object.list = oblist,
                             anchor.features = features)
gc()
print('Completed preparation')



print("Finding integration anchors ...")
print(Sys.time())
anchors <- FindIntegrationAnchors(
    object.list = oblist,
    anchor.features = features,
    normalization.method = "SCT",
    dims = 1:30
)
gc()
path <- paste(c(data_path, "anchors.RDS"), collapse = '')
saveRDS(anchors, path, compress = FALSE)
print("Anchors found and saved")

remove(oblist)
remove(features)
gc()

print("Integrating with anchors ...")
print(Sys.time())
integrated <- IntegrateData(
    anchorset = anchors,
    normalization.method = "SCT",
    dims = 1:30
)

print("Calculating principle components ...")
print(Sys.time())
integrated <- RunPCA(integrated, verbose = FALSE)
path <-
    paste(c(data_path, "human_mtg_integrated.RDS"), collapse = "")

saveRDS(integrated, path)
print("Integration complete!")
print(Sys.time())
