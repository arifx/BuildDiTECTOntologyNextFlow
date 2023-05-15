#ROOT_FOLDER="BuildDiTECTOntologyNextFlow"
java --version
# #change working directory 
#cd $ROOT_FOLDER
pwd
mkdir robot_jar/
curl -L https://github.com/ontodev/robot/releases/download/v1.9.3/robot.jar > ./robot_jar/robot.jar
mkdir ontology-sources/
curl -L http://purl.obolibrary.org/obo/chmo.owl  > ./ontology-sources/chmo.owl
curl -L http://purl.obolibrary.org/obo/geo.owl   > ./ontology-sources/geo.owl
curl -L http://purl.obolibrary.org/obo/bfo.owl   > ./ontology-sources/bfo.owl
curl -L http://semanticscience.org/ontology/sio.owl > ./ontology-sources/sio.owl
curl -L https://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi.owl > ./ontology-sources/chebi.owl
curl -L http://purl.obolibrary.org/obo/om-2.owl  > ./ontology-sources/om-2.owl
curl -L curl -L http://www.w3.org/ns/sosa/sosa.ttl   > ./ontology-sources-test/sosa.ttl
curl -L http://purl.obolibrary.org/obo/foodon.owl  > ./ontology-sources/foodon.owl
curl -L http://purl.obolibrary.org/obo/envo.owl   > ./ontology-sources/envo.owl
curl -L http://www.w3.org/ns/sosa/sosa.ttl   > ./ontology-sources/sosa.ttl
curl -L http://www.w3.org/ns/ssn/ssn.ttl   > ./ontology-sources/ssn.ttl
curl -L http://purl.obolibrary.org/obo/ncit.owl > ./ontology-sources/ncit.owl
curl -L http://purl.obolibrary.org/obo/agro.owl > ./ontology-sources/agro.owl
curl -L http://purl.obolibrary.org/obo/obi.owl > ./ontology-sources/obi.owl
curl -L https://saref.etsi.org/core/v3.1.1/saref.ttl > ./ontology-sources/saref.ttl
mkdir imports/
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/chebi.owl   --lower-terms ./seed_files/chebi_seeds.txt --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-chebi-import.owl > ./imports/chebiimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/sio.owl   --lower-terms ./seed_files/sio_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-sio-import.owl > ./imports/sioimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/foodon.owl   --lower-terms ./seed_files/foodon_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-foodon-import.owl > ./imports/foodonimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/chmo.owl   --lower-terms ./seed_files/chmo_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-chmo-import.owl > ./imports/chmoimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/geo.owl   --lower-terms ./seed_files/geo_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-geo-import.owl > ./imports/geoimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/bfo.owl   --lower-terms ./seed_files/bfo_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-bfo-import.owl > ./imports/bfoimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/sosa.ttl   --lower-terms ./seed_files/sosa_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-sosa-import.owl > ./imports/sosaimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/ssn.ttl   --lower-terms ./seed_files/ssn_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-ssn-import.owl > ./imports/ssnimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/envo.owl   --lower-terms ./seed_files/envo_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-envo-import.owl > ./imports/envoimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/om-2.ttl   --lower-terms ./seed_files/om2_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-om2-import.owl > ./imports/om2import.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/ncit.owl   --lower-terms ./seed_files/ncit_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-ncit-import.owl > ./imports/ncitimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/obi.owl   --lower-terms ./seed_files/obi_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-obi-import.owl > ./imports/obiimport.log
java -jar ./robot_jar/robot.jar -v extract --method MIREOT --input ./ontology-sources/saref.ttl   --lower-terms ./seed_files/saref_seeds.txt  --intermediates none --copy-ontology-annotations true --output ./imports/ditect-fso-saref-import.owl > ./imports/sarefimport.log
java -jar ./robot_jar/robot.jar -vvv template --template ./ditect-template.csv \
    --prefix "fsmon: https://purl.org/fsmon/Ontology#" \
    --ontology-iri "https://purl.org/ditect/fsmon/ditect-fso-custom.owl" \
    --errors ./templates/error.csv \
    --output ./templates/ditect-fso-custom.owl
mkdir merge/    
java -jar ./robot_jar/robot.jar -v merge \
    --input ./templates/ditect-fso-custom.owl \
    --input ./imports/ditect-fso-foodon-import.owl \
    --input ./imports/ditect-fso-sio-import.owl \
    --input ./imports/ditect-fso-chmo-import.owl \
    --input ./imports/ditect-fso-geo-import.owl \
    --input ./imports/ditect-fso-sosa-import.owl \
    --input ./imports/ditect-fso-om2-import.owl \
    --input ./imports/ditect-fso-ssn-import.owl \
    --input ./imports/ditect-fso-envo-import.owl \
    --input ./imports/ditect-fso-bfo-import.owl \
    --input ./imports/ditect-fso-chebi-import.owl \
    --input ./imports/ditect-fso-ncit-import.owl \
    --input ./imports/ditect-fso-obi-import.owl \
    --input ./imports/ditect-fso-saref-import.owl \
    --include-annotations false \
    --output ./merge/ditect-fso.owl > ./merge/fso-merge.log
mkdir reasoner/     
java -jar ./robot_jar/robot.jar -v reason --reasoner ELK \
  --input ./merge/ditect-fso.owl \
  --output ./reasoner/ditect-fso-satisfiable.owl