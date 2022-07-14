## Human MTG data integration with Azimuth for SEA-AD project



### Data:
Reference and demo datasets (curated by Jeremy Miller)
``` 
/allen/programs/celltypes/workgroups/rnaseqanalysis/DataRelease_May2022/human_MTG_reference/Azimuth_files/
├── Seurat_object.RDS # count data + annotations and metadata
└── example_Seurat_object_H21.33.019.RDS`: Demo data for Azimuth.
```
 Datasets for evaluation (ground truth annotations: Kyle Travaglini)
 ```
 /allen/programs/celltypes/workgroups/hct/SEA-AD/RNAseq/
├── /ingest/output/MTG_AD_singleomeCR6_donor_RDS/: AD donor count data. The .Rdata files include a Seurat object.
└── /scANVI/output/MTG_AD/metadata/MTG_AD_metadata_full.2022-04-13.csv: metadata. Use cells only with `for_analysis=='True'`
```

### Scripts and notebooks
Building the reference and evaluating mapping results (Rohan Gala):
```bash
# local / HPC indicates where the script was executed. 
.
 ├── 00_integrate_human_mtg.R            #(local) Per donor variance stabilization
 ├── 01_integrate_human_mtg.R            #(HPC)   Integrate across donors
 ├── 02_export_human_mtg.R               #(local) Post process reference files 
 ├── 03_metadata_to_feather.R            #(local) Saving relevant metadata for fast read operation
 ├── 04_convert_objs.R                   #(HPC)   Convert Rdata --> RDS for lower memory footprint
 ├── 05_auto_azimuth.R                   #(local) Bypass Azimuth GUI for evaluation datasets
 ├── 06_azimuth_scanvi_human_mtg.ipynb   #(local) Overall cluster and subclass level precision-recall plots
 ├── 07_azimuth_scanvi_human_mtg_2.ipynb #(local) Donorwise subclass level precision-recall plots
 └── 08_container_benchmark.ipynb        #(local) Assess compute/ memory/network footprint intended use case
```

Mapping results made available for post-hoc investigation:
```bash
/allen/programs/celltypes/workgroups/mousecelltypes/Rohan/dat/proc/human_mtg_azimuth_eval/
├── donorwise_cluster_metrics.csv  # - precision, recall, f1, support for each donor
├── donorwise_subclass_metrics.csv # - precision, recall, f1, support for each donor
├── overall_cluster_metrics.csv    # - precision, recall, f1, support for pooled donors
├── overall_subclass_metrics.csv   # - precision, recall, f1, support for pooled donors
└── per_cell_mapping_result.csv    # - azimuth and scanvi labels per cell for cluster and subclass. 
```

### Local azimuth instance

Start docker with the correct config and reference files:
```bash
# Reference files and related config file are located at `/home/rohan/Local/datasets/human_mtg/ref_proc/`
docker run -it -p 8989:3838 -v /home/rohan/Local/datasets/human_mtg/ref_proc/:/reference_data/:ro azimuth R -e "Azimuth::AzimuthApp(config = '/reference_data/config.json')"
```

### Deploying azimuth instance online

See notes in `09_deploy_remote.md`.
