*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Hospitals ratings and their preformance compared to the 
national average.

Dataset Name: HospInfo_analytic_file created in external file
STAT6250-02_s17-team-1_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset HospInfo_analytic_file;
%include '.\STAT6250-02_s17-team-1_project1_data_preparation.sas';


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

proc print noobs data=HospInfo_analytic_file_temp(obs=10);
    id Hospital_Ownership;
    var Hospital_overall_rating;
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

proc print noobs data=temp;
    id State;
    var Hospital_overall_rating;
run;
