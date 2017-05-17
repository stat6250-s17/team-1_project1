*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Hospitals ratings and their performance compared to the
national average.

Dataset Name: HospInfo created in external file
STAT6250-02_s17-team-1_project1_data_preparation.sas, which is assumed to be 
in the same directory as this file

See included file for dataset properties
;

* environmental setup;
* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset HospInfo_analytic_file;
%include '.\STAT6250-02_s17-team-1_project1_data_preparation.sas';


title1
'Research Question: Which state has the lowest average hospitals overall ratings?'
;

title2
'Rationales: It helps us understand that which state needs improve their overall hospitals experience.'
;

footnote1
'Based on the ouput, The state PR(Puerto Rico) has lowest hospitals over tatings which is0.365(rounded).'
;
*
Methodology: Use PRINT to print the average overall ratings of each state.

Limitations: It does not show the number of hospital counts in each state, so 
some of the state's hospitals have not ratings available.

Possible Follow-up Steps: Use COUNT function to counts the state numbers.
;
proc print noobs data=HospInfo_analytic_file_temp2;
    id State;
    var Hospital_overall_rating;
run;
title;
footnote;


title1
'Research Question: What type of hospitals have the most "below the national average" patient experience ratings?'
;

title2
'Rationales: Patient experience is one of the most points that people cares about, so it tells us what type of hospitals needs improve their patient experience.'
;

footnote1
'Based on the output, Acute Care Hospitals type of hostpitals have the most "below the national average" patient experience ratings.'
;
*
Methodology: Use WHERE to find the hospitals which have "below the average" 
rating, and use COUNT to find which type of hospitals have the most numbers 
of this rating. 

Limitations: The Children type hospitals have a small number of data, so it 
may not be significant. 

Possible Follow-up Steps: Eliminate the Children type, and only analyze the 
rest of the types.
;
proc print noobs data=HospInfo_analytic_file_temp1;
    id Hospital_Type;
    var Patient_experience_comparison;
run;
title;
footnote;


title1
'Research Question: Which hospital Ownership has the most "below the national average" effectiveness of care ratings?'
;

title2
'Rationales: Effectiveness of care is one of the most points that people cares about, so it tells us what ownership type of hospitals needs improve their effectiveness of care.'
;

footnote1
'Based on the output, Voluntary non-profit-Private has the most "below the national average" effectiveness of care ratings.'
;
*
Methodology: Use WHERE to find the hospitals which have "below the average" 
rating, and use COUNT to find which type of hospitals have the most numbers 
of this rating. 

Limitations: There are some onwership types which have very few data, so it 
is not meaningful to analyze them.

Possible Follow-up Steps: Eliminate the variables which have very few data.
;
proc print noobs data=HospInfo_analytic_file_temp1;
    id Hospital_Ownership;
    var Effectiveness_comparison;
run;
title;
footnote;
