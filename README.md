## Human MTG data integration with Azimuth
 
 ### Data:
 Files for Azimuth integration (Jeremy)
 `\\allen\programs\celltypes\workgroups\rnaseqanalysis\DataRelease_May2022\human_MTG_reference\Azimuth_files`
 
 - `Seurat_object.RDS`: Seurat object with the count matrix and cell metadata for the reference data set.  The relevant columns cluster_[label/color], subclass_[label/color], and class_[label/color], obtained with scVI (Kyle). Filter data to ensure `QCpass = “True”`.
 - `example_Seurat_object_H21.33.019.RDS`: Seurat object for donor H21.33.019, with similar format as the reference dataset.  This can be used as example data for Azimuth.

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
