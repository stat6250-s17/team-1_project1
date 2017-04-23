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

-Provider ID: Hospital ID

-Hospital Name: Hospital Name

-Address: Hospital Address

-City: City of Hospital

-State: State of Hospital

-ZIP Code: Zip Code of Hospital

-County Name: County of Hospital

-Phone Number: Phone number of Hospital

-Hospital Type: Category of Hospital

-Hospital Ownership: Who owns the hospital (Government or private)

-Emergency Services: Does the hospital have emergency services (True or False)

-Meets criteria for meaningful use of EHRs: Criteria for Electronic Health 
Records (True or False)

-Hospital overall rating: Rate of Hospital on a scale of 1 to 5.

-Mortality national comparison: Comparison of Mortality rate to national 
average

-Safety of care national comparison: Comparison of Safety of Care to national 
average

-Readmission national comparison: Comparison of Readmission to national average

-Patient experience national comparison: Comparison of patient experience  to 
national average

-Effectiveness of care national comparison: Comparison of effectiveness of care 
to national average

-Timeliness of care national comparison: comparison of Timeliness of care to 
national average

-Efficient use of medical imaging national comparison: Comparison of efficient 
use of medical imaging to national average
;

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
