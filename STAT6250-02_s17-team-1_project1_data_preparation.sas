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

*Data manipulation steps;

*
'Research Question: Which Hospital Ownership Type has the highest average of overall rating?'
;
*
'Rationale: This could let us determine which type of hospital is better.'
;
*
footnote1
'Based on the output, Voluntary non-profit - Church have the highest overall rating of 2.88.'
;

Methodology: Can use PROC means to get the average of overall rating for each Hospital_Ownership Type.
Also use PROC sort

Limitations: The values will not account for the proportion of each hospital type or the hospitals
that do not have the available data, which is set to 0.

Possible Follow-up Steps: Try a count function for number of each hospital type and compare 0s of each
type of hospital.

;

proc means data=HospInfo_analytic_file;
class Hospital_Ownership;
var Hospital_overall_rating;
output out=HospInfo_analytic_file_temp;
run;

proc sort data=HospInfo_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending Hospital_overall_rating;
run;

proc print noobs data=HospInfo_analytic_file_temp(obs=10);
    id Hospital_Ownership;
    var Hospital_overall_rating;
run;

proc sort data=temp;
    by descending Hospital_Ownership;
run;

*
'Research Question: How many hospitals have a 'below the national average' rating for mortality?'
;

'Rationale: This would allow us to how well hospitals are doing with keeping patients alive.'
;
*
footnote1
'based on the output, only 7.09% of hospitals are below the national average for mortality.'
;
*
Methodology: By using proc freq, we can see the number of hospitals that have a below the national 
average rating and the percentage.

Limitations: There are hospitals that don't have available data, so the results could be skewed.

Possible Follow-up Steps: could try to subset of hospital type.
;

proc freq data=HospInfo_analytic_file; 
tables Mortality_comparison;
run;



*
'Research Question: Which State has the highest average overall rating of hospitals?'
;

'Rationale: If we compare this to state population size, we might be able to find out if population has 
an effect on the effectiveness of a hospital.'
;
*
footnote1
'Based on the output, New Hampshire has the higest overall rating.'
;
Methodology: Use proc means to find the average score of each state and proc sort to find the ones that
have the highest average.

Limitations: Does not take into account porportion of number of hospitals in each state. Data also includes
US territories.

Possible Follow-up Steps:Could try to filter out US territories or figure out a ratio.
;


proc means data=HospInfo_analytic_file;
    class State;
    var Hospital_overall_rating;
    output out=temp;
run;

proc sort data=temp(where=(_STAT_="MEAN"));
    by descending Hospital_overall_rating;
run;

proc print noobs data=temp;
    id State;
    var Hospital_overall_rating;
run;

Proc sort data= temp;
by descending Hospital_Type;
run;
