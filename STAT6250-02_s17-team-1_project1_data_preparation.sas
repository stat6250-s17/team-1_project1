*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.

[Dataset Name] Hospital General Information

[Experimental Units] Hospitals by Provider ID

[Number of Observations] 4807

[Number of Features] 20

[Data Source]The file https://www.kaggle.com/cms/hospital-generalinformation/do
wnloads/hospitalgeneralinformation.zip was downloaded and edited to produce 
file HospInfo-Updated.xls by deleting all footnote columns, adding _ to all 
columntitles, and adding a tab for label descriptions.

[Data Dictionary]"Data Field Descriptions" in file HospInfo-Updated.xls

[Unique ID Schema] Provider ID is a primary key


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-1_project1/blob/master/HospInfo-Updated.xls?raw=true
;

* load raw Hospital dataset over the wire;
filename tempfile TEMP;
proc http

    method="get"
    url="&inputDatasetURL"
    out=tempfile
    ;
run;
proc import
    file=tempfile
    out=HospInfo_raw
    dbms=xls;
run;
filename tempfile clear;

* check raw Hospital dataset for duplicates with respect to its composite key;
proc sort nodupkey data=HospInfo_raw dupout=HospInfo_raw_dups out=_null_;
    by Provider_ID;
run;

* build analytic dataset from FRPM dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
;
data HospInfo_analytic_file;
    retain
        Provider_ID
		Hospital_Name
		State
		Hospital_Type
		Hospital_Ownership
		Hospital_overall_rating
		Mortality_comparison
		Safety_comparison
		Readmission_comparison
		Patient_experience_comparison
		Effectiveness_comparison
		Timeliness_comparison
		Efficient_use_of_medical_imaging

    ;
    keep
        Provider_ID
		Hospital_Name
		State
		Hospital_Type
		Hospital_Ownership
		Hospital_overall_rating
		Mortality_comparison
		Safety_comparison
		Readmission_comparison
		Patient_experience_comparison
		Effectiveness_comparison
		Timeliness_comparison
		Efficient_use_of_medical_imaging
    ;
    set HospInfo_raw;
run;




