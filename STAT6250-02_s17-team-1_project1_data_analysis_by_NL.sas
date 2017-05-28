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


title1
'Research Question: Which Hospital Ownership Type has the highest average of overall rating?'
;

title2
'Rationale: This could let us determine which type of hospital is better.'
;

footnote1
'Based on the output, Voluntary non-profit - Church have the highest overall rating of 2.88.'
;

footnote2
'There are only 344 observations for this type, other Hospital Ownership types with more observations
have a lower overall mean.'
;

footnote3
'Also since it is a Voluntary non-profit - Church, religion and the type of people who go here could
have an impact on the overall scoring.'
;

*
Methodology: Use PROC PRINT to print just the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: The values will not account for the proportion of each hospital 
type or the hospitals that do not have the available data, which is set to 0.

Possible Follow-up Steps: Try a count function for number of each hospital type
and compare 0s of each type of hospital.
;

proc print 
    noobs
        data=HospInfo_analytic_file_temp
    ;
    id 
	Hospital_Ownership
    ;
    var 
        Hospital_overall_rating
    ;
run;
title;
footnote;



title1
'Research Question: How many hospitals have a below the national average rating for mortality?'
;

title2
'Rationale: This would allow us to how well hospitals are doing with keeping patients alive.'
;

footnote1
'based on the output, only 7.09% of hospitals are below the national average for mortality.'
;

footnote2
'Factors could be there are less patients who are terminal or less mal practice in surgeries.'
;

footnote3
'There is also large number of observations that do not have any values, which skews the results.'
;

*
Methodology: By using proc freq, we can see the number of hospitals that have a
below the national average rating and the percentage.

Limitations: There are hospitals that don't have available data, so the results
could be skewed.

Possible Follow-up Steps: could try to subset of hospital type.
;

proc freq 
    data=HospInfo_analytic_file
    ; 
    tables 
        Mortality_comparison
    ;
run;
title;
footnote;



title1
'Research Question: Which State has the highest average overall rating of hospitals?'
;

title2
'Rationale: If we compare this to state population size, we might be able to find out if population has 
an effect on the effectiveness of a hospital.'
;

footnote1
'Based on the output, New Hampshire has the higest overall rating.'
;

footnote2
'The top three states are New Hampshire, Maine, and Rhode Island.'
;

footnote3
'Geographical location could definitely be a significant factor since all three states are near each other.'
;

*
Methodology: Use PROC PRINT to print just the first ten observations from
the temporary dataset created in the corresponding data-prep file.

Limitations: Does not take into account porportion of number of hospitals in 
each state. Data also includes US territories.

Possible Follow-up Steps:Could try to filter out US territories or figure out
a ratio.
;

proc print 
    noobs 
        data=HospInfo_analytic_file_temp2(obs=10)
    ;
    id 
        State
    ;
    var 
        Hospital_overall_rating
    ;
run;
title;
footnote;
