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
;

* environmental setup;

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
    	dbms=xls
    ;
run;
filename tempfile clear;

* check raw Hospital dataset for duplicates with respect to its composite key;
proc sort 
	nodupkey 
	data=HospInfo_raw 
	dupout=HospInfo_raw_dups 
	out=_null_
    ;
    by 
    	Provider_ID
    ;
run;


* build analytic dataset from FRPM dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files
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

* 
Use proc means to compute the mean rating of hospital_ownership type
and use proc sort  of hospital_rating to order ratings from high to low,
which will be used as the part of the data anlysis by NL
;

proc means 
    noprint
	data=HospInfo_analytic_file
	  mean
    ;
    class 
    	Hospital_Ownership
    ;
    var 
    	Hospital_overall_rating
    ;
    output 
    	out=HospInfo_analytic_file_temp
    ;
run;

proc sort 
	data=HospInfo_analytic_file_temp(where=(_STAT_="MEAN"))
    ;
    by 
    	descending Hospital_overall_rating
    ;
run;

*
Use proc means to compute the mean rating of each state
and use proc sort  of hospital_rating to order ratings from high to low,
which will be used as the part of the data anlysis by NL
;

proc means
    noprint
	data=HospInfo_analytic_file
	mean
    ;
    class 
    	State
    ;
    var 
    	Hospital_overall_rating
    ;
    output 
    	out=HospInfo_analytic_file_temp
    ;

run;

proc sort 
	data=HospInfo_analytic_file_temp(where=(_STAT_="MEAN"))
    ;
    by
    	descending Hospital_overall_rating
    ;
run;

* 
Use proc sort  to sort the data by the hospital type to calculate  the hospital types that have "below the average" 
rating the ,which will be used as the part of the data anlysis by AA
;

proc sort 
	data=HospInfo_analytic_file
    ;
    by 
    	descending Hospital_Type
    ;
run;

* Use proc sort to sort the data by the hospital ownership in order to  what the type of hospitals that need to 
improve their safety,which will be used as the part of the data anlysis by AA
;

proc sort 
	data=HospInfo_analytic_file
    ;
    by 
    	descending Hospital_Ownership
    ;
run;

* 
Using proc means in the data to find the means for Hospital_overall_rating
variable, which will be used as the part of the data anlysis by AA
;

Proc means
	mean
	noprint 
	data=HospInfo_analytic_file
    ;
    Class 
    	Hospital_Type
    ;
    Var 
   	Hospital_overall_rating
    ;
    Output 
    	out= temp
    ;
run;
 

*
Use SORT to sort the average overall ratings, which will be used as the part of 
the data anlysis by RL
;
data HospInfo_analytic_file_temp1;
    set HospInfo_analytic_file;
run;

proc sort 
	data=HospInfo_analytic_file_temp1
    ;
    by 
    	descending State
    ;
run;

*
Use SORT to sort the data by the hospital type, which will be used as the
part of the data analysis by RL
;

proc sort 
	data=HospInfo_analytic_file_temp1
    ;
    by 
    	descending Hospital_Type
    ;
run;

*
Use SORT to sort the data by the hospital ownership, which will be used as 
the part of the data analysis by RL
;

proc sort 
	data=HospInfo_analytic_file_temp1
    ;
    by 
    	descending Hospital_Ownership
    ;
run;
