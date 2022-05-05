# Converts Rdata files into RDS files that take ~10x less disk space

library(Seurat)

src_path <- "/allen/programs/celltypes/workgroups/hct/SEA-AD/RNAseq/ingest/output/MTG_AD_singleomeCR6_donor_RDS/"
des_path <- "/allen/programs/celltypes/workgroups/mousecelltypes/Rohan/dat/proc/human_mtg_eval/"
files <- list.files(src_path)
count = 0
for (f in files) {
    print(paste('loading ...', f))
    load(paste(c(src_path, f), collapse=""))
    des_file <- sub(".RData", ".RDS", paste(c(des_path, f), collapse=""))
    print(paste('saving ...', f))
    saveRDS(brain, file=des_file)
    remove(brain)
    count = count + 1
    print(paste('done', count))
}
