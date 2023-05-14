nextflow run ./KG_script/MSI-process-KG.nf \
--input_folder dataset/ \
--runKG_output_folder result/KG/ \
--main_kg reasoner/ditect-fso-satisfiable.owl \
--merge_output_path result/full_msi_kg.owl \
--script_dir KG_script \
--copy_output_path result/copy
nextflow run ./KG_script/MSIF-process-KG.nf \
--input_folder dataset/ \
--runKG_output_folder result/KG/ \
--main_kg reasoner/ditect-fso-satisfiable.owl \
--merge_output_path result/full_msif_kg.owl \
--script_dir KG_script \
--copy_output_path result/copy