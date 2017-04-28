*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Hospitals ratings and their preformance compared to the 
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
Research Question 1: what types of  hospital Ownership that has the most "below the national 
average" in safety ratings?
Rationales: This will show us what ownership type of hospitals that did not meet the saftey average.
Methodology: By applying the "WHERE" statemnet, we can get the hospitals that have "below the average" 
rating. Next, we could utilize the "COUNT" command to know what the type of hospitals that need to improve their safety. 
Limitations: We may end up analyzing only some of the hospitals because the safety evaluation is 
not available in all types of hospitals. 
Possible Follow-up Steps: Eliminate the variables which have very few data.
;
proc print data=HospInfo_Updated;
    var Hospital_Onwership safety_comparison;
    where safety_comparison="Below the National average";
    output out=temp;
run;

proc sort data=temp;
    by descending Hospital_Ownership;
run;

proc print noobs data=temp;
    id Hospital_Ownership;
    var safety_comparison;
run;


*
Research Question 2: What are the lowest "below the national average" effectiveness of care ratings in terms of 
hospital Ownership type ?
Rationales: It will give us an idea of what type of   hospitals function  effectively.  
Methodology: in this case, we would use the "WHERE" command to calculate the hospitals that have "below the average" 
rating, Then , we need to apply the "COUNT" command to find which type of hospitals have the lowest numbers 
of this rating. 
Limitations: The ownership types vary and are not proportioned equally.
Possible Follow-up Steps: 
;
proc print data=HospInfo_Updated;
    var Hospital_Onwership Effectiveness_comparison;
    where Effectiveness_comparison="Below the National average";
    output out=temp;
run;

proc sort data=temp;
    by descending Hospital_Ownership;
run;

proc print noobs data=temp;
    id Hospital_Ownership;
    var effectiveness_comparison;
run;


*
Research Question 3: what kind of hospital has the lowest average in terms of the holistic rating?
Rationales: This will help us find the struggluing hospital ownership types. 
Methodology: By using the command “PROC MEAN”, we can find the rating mean. Next, by using “PROC SORT”, 
we can get the means of temp data. Finally, “PROC PRINT”, to show the result.
Limitations: the rating values may not exactly be accounted for the ratio for each hospital type.
Possible Follow-up Steps: 
;
Proc means data= hospInfo_Updated;
Class Hospital_Type;
Var Hospital_overall_rating;
Output out= temp;
run;
Proc sort data= temp;
by descending Hospital_Type;
run;
Proc print noods data= temp;
id Hospital_Type;
Var Hospital_overall_rating;
run;

