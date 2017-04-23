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


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-1_project1_data_preparation.sas';


*
[Research Question 1] Which Hospital Ownership Type has the highest average of overall rating? 

Rationale: This could let us determine which type of hospital is better.

Methodology: Can use PROC MEANS to get the average of overall rating for each Hospital_Ownership Type
and output the results to a temporary dataset "temp". Use PROC SORT extract and sort just the means of temp dateset, and use
PROC PRINT to print to view the observations

Limitations: The values will not account for the proportion of each hospital type

Possible Follow-up Steps:

;


proc means data=HospInfo;
    class Hospital_Ownership;
    var Hospital_overall_rating;
    output out=temp;
run;

proc sort data=temp;
    by descending Hospital_Type;
run;

proc print noobs data=temp;
    id Hospital_Type;
    var Hospital_overall_rating;
run;

*
[Research Question 2] Which Hospitals have the most ‘below the national average’ ratings? 

Rationale: This would allow us to identify the hospitals that need the most support.

Methodology: By using Where function we could see which Hospitals have 'below the national average'
as a recorded observation. Then we could use another function to count the total below average.
Next we could use a Proc Sort by descending to find the Hospitals with the most 'below the national average' percentage.

Limitations: There are over 4000 Hospital observations, so we would need to figure out a cut off.

Possible Follow-up Steps:

;

Data=HospInfo;
where Column = 'below the national average';
run;
*figure out how to find count and create new variable "below the national average count";
proc sort data=temp;
    by descending 'below the national average count';
run;

proc print=
;
*
[Research Question 3] Which State has the highest overall rating of hospitals? 

Rationale: If we compare this to state population size, we might be able to find out if population has 
an effect on the effectiveness of a hospital. 

Methodology: Use proc means to find the average score of each state and proc sort to find the ones that
have the highest average.

Limitations: Does not take into account porportion of number of hospitals in each state.

Possible Follow-up Steps:;


proc means data=HospInfo;
    class State;
    var Hospital_overall_rating;
    output out=temp;
run;

proc sort data=temp;
    by descending State;
run;

proc print noobs data=temp;
    id State;
    var Hospital_overall_rating;
run;

