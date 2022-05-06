## Human MTG data integration with Azimuth
 
 ### Data:
 Files for Azimuth reference and demo (Jeremy)
 `\\allen\programs\celltypes\workgroups\rnaseqanalysis\DataRelease_May2022\human_MTG_reference\Azimuth_files`
 
 - `Seurat_object.RDS`: Seurat object with the count matrix and cell metadata for the reference data set.  The relevant columns cluster_[label/color], subclass_[label/color], and class_[label/color], obtained with scVI (Kyle). Filter data to ensure `QCpass = “True”`.
 - `example_Seurat_object_H21.33.019.RDS`: Seurat object for donor H21.33.019, with similar format as the reference dataset.  This can be used as example data for Azimuth.

 Files for Azimuth evaluation (Kyle)
 - `/allen/programs/celltypes/workgroups/hct/SEA-AD/RNAseq/ingest/output/MTG_AD_singleomeCR6_donor_RDS/` - path contains per donor .Rdata files which include a Seurat object.
 - `/allen/programs/celltypes/workgroups/hct/SEA-AD/RNAseq/scANVI/output/MTG_AD/metadata/MTG_AD_metadata_full.2022-04-13.csv` - metadata. Use cells only with `for_analysis=='True'`

### Integration scripts
 - `00_integrate_human_mtg.R` was run locally
 - `01_integrate_human_mtg.R` was run on HPC
 - `02_export_human_mtg.R` was run locally

### Azimuth instance:
Reference files and related config file are located at `/home/rohan/Local/datasets/human_mtg/ref_proc`

1. Start docker with the correct config and reference files:
```
docker run -it -p 8989:3838 -v /home/rohan/Local/datasets/human_mtg/ref_proc/:/reference_data/:ro azimuth R -e "Azimuth::AzimuthApp(config = '/reference_data/config.json')"
```
2. Map onto Remote machine 
```
remote_rohan_map 8989 8989
```
3. On remote machine, use ngrok to expose http connection:
```
ngrok http 8989
```

### Evaluation of Azimuth results
 - `03_metadata_to_feather.R` was run locally
 - `04_convert_objs.R` was run on HPC
 - `05_auto_azimuth.R` was run on locally
 - `06_azimuth_scanvi_human_mtg.ipynb` was run locally

Evaluation result files are stored at `/allen/programs/celltypes/workgroups/mousecelltypes/Rohan/dat/proc/human_mtg_azimuth_eval`
```bash
.
├── donorwise_cluster_metrics.csv  # - precision, recall, f1, support for each donor
├── donorwise_subclass_metrics.csv # - precision, recall, f1, support for each donor
├── overall_cluster_metrics.csv    # - precision, recall, f1, support for pooled donors
├── overall_subclass_metrics.csv   # - precision, recall, f1, support for pooled donors
└── per_cell_mapping_result.csv    # - azimuth and scanvi labels per cell for cluster and subclass. 
```
