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

footnote2
'There are some states which have zero data or very data, and it is not possible to say a state which has zero overall rating is the worst state because there is no data.'
;

footnote3
'Additionally, it is meaningless to compare two states with two different observation numbers; therefore, more data are needed to make significant comparison.'
;
*
Methodology: Use PRINT SUMMARY to print the average overall ratings of each state.

Limitations: It does not show the number of hospital counts in each state, so 
some of the state's hospitals have not ratings available.

Possible Follow-up Steps: Use FREQ function to counts the state numbers.
;
proc summary data=HospInfo_analytic_file_temp1
    print;
	var Hospital_overall_rating;
	class State;
	output out=HospInfo_analytic_file_temp2
	    mean=AvgRating;
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
'Based on the output, Acute Care Hospitals type of hospitals have the most "below the national average" patient experience ratings.'
;

footnote2
'Acute care hospitals do need to imrpvoe their patient experience; however, it is still not accurate to make this conclusion becasue the total number of observations are still small.'
;

footnote3
'Patient experience is also very hard to judge because everybody has different criteria about this.'
;
*
Methodology: Use WHERE to find the hospitals which have "below the average" 
rating, and use FREQ to find which type of hospitals have the most numbers 
of this rating. 

Limitations: The Children type hospitals have a small number of data, so it 
may not be significant. 

Possible Follow-up Steps: Eliminate the Children type, and only analyze the 
rest of the types.
;
proc freq data=HospInfo_analytic_file_temp1;
    where Patient_experience_comparison='Below the National average';
	tables Hospital_Type;
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

footnote2
'It seems that when people do job without financial purpose they have the lowest effectiveness, and this probably applies to many other industries.'
;

footnote3
'State and federal government owned hospitals are doing better than local and hospital district.'
;
*
Methodology: Use WHERE to find the hospitals which have "below the average" 
rating, and use FREQ to find which type of hospitals have the most numbers 
of this rating. 

Limitations: There are some onwership types which have very few data, so it 
is not meaningful to analyze them.

Possible Follow-up Steps: Eliminate the variables which have very few data.
;
proc freq data=HospInfo_analytic_file_temp1;
    where Effectiveness_comparison='Below the National average';
	tables Hospital_Ownership;
run;
title;
footnote;
