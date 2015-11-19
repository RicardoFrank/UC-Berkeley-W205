sudo -u hdfs hdfs dfs -mkdir -p /user/rbarrera/hospital_compare
sudo -u hdfs hdfs dfs -mkdir -p /data/w205tables

cd /data

wget https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

unzip Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s\?content_type\=application%2Fzip\;\ charset\=binary

rm Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s\?content_type\=application%2Fzip\;\ charset\=binary

mkdir ex1

tail -n +2 Hospital\ General\ Information.csv > /data/ex1/HGI.csv
tail -n +2 Readmissions\ and\ Deaths\ -\ Hospital.csv > /data/ex1/RDH.csv
tail -n +2 Readmissions\ and\ Deaths\ -\ State.csv > /data/ex1/RDS.csv
tail -n +2 Readmissions\ and\ Deaths\ -\ National.csv > /data/ex1/RDN.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ Hospital.csv > /data/ex1/TECH.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ National.csv > /data/ex1/TECN.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ State.csv > /data/ex1/TECS.csv
tail -n +2 hvbp_hcahps_05_28_2015.csv > /data/ex1/survey.csv
tail -n +2 Measure\ Dates.csv > /data/ex1/MD.csv

sudo -u hdfs hdfs dfs -put /data/ex1/HGI.csv /user/rbarrera/hospital_compare/HGI.csv
sudo -u hdfs hdfs dfs -put /data/ex1/RDH.csv /user/rbarrera/hospital_compare/RDH.csv
sudo -u hdfs hdfs dfs -put /data/ex1/RDS.csv /user/rbarrera/hospital_compare/RDS.csv
sudo -u hdfs hdfs dfs -put /data/ex1/RDN.csv /user/rbarrera/hospital_compare/RDN.csv
sudo -u hdfs hdfs dfs -put /data/ex1/TECN.csv /user/rbarrera/hospital_compare/TECN.csv
sudo -u hdfs hdfs dfs -put /data/ex1/TECH.csv /user/rbarrera/hospital_compare/TECH.csv
sudo -u hdfs hdfs dfs -put /data/ex1/TECS.csv /user/rbarrera/hospital_compare/TECS.csv
sudo -u hdfs hdfs dfs -put /data/ex1/survey.csv /user/rbarrera/hospital_compare/survey.csv
sudo -u hdfs hdfs dfs -put /data/ex1/MD.csv /user/rbarrera/hospital_compare/MD.csv
