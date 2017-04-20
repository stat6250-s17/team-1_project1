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
* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-1_project1_data_preparation.sas';


*
Research Question: Which state has the lowest average hospitals overall ratings?

Rationales: It helps us understand that which state needs improve their overall hospitals' experience.

Methodology: Use PROC MEAN to find the average score of each state's overall ratings, and use PROC SORT to find the state that has the lowest average ratings.

Limitations: It does not show the number of hospital counts in each state, so some of the state's hospitals have not ratings available.

Possible Follow-up Steps:
;


*
Research Question: What type of hospitals have the most "below the national average" patient experience ratings?

Rationales: Patient experience is one of the most points that people cares about, so it tells us what type of hospitals needs improve their patient experience.

Methodology: Use WHERE to find the hospitals which have "below the average" rating, and use COUNT to find which type of hospitals have the most numbers of this rating. 

Limitations: 

Possible Follow-up Steps:
;


*
Research Question: Which hospital Ownership has the most "below the national average" effectiveness of care ratings?

Rationales: Effectiveness of care is one of the most points that people cares about, so it tells us what ownership type of hospitals needs improve their effectiveness of care.

Methodology: Use WHERE to find the hospitals which have "below the average" rating, and use COUNT to find which type of hospitals have the most numbers of this rating. 

Limitations:

Possible Follow-up Steps:
;
