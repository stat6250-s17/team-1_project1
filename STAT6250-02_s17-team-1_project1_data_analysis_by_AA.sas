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
'Research Question: what types of  hospital Ownership that has the most "below the national 
average" in safety ratings?'
;

title2
'Rationales: This will show us what ownership type of hospitals that did not meet the saftey average.'
;

footnote1
'The result above shows whether each type of hospital ownership obtained the safety requiremnts or not. The SAS code sorted the values 
based on the (safety_comparison) variable.'
;
*
Methodology: By applying the "WHERE" statemnet, we can get the hospitals that have "below the average" 
rating. Next, we could utilize the to know what the type of hospitals that need to improve their safety.

Limitations: We may end up analyzing only some of the hospitals because the safety evaluation is 
not available in all types of hospitals.

Possible Follow-up Steps: Eliminate the variables which have very few data.
;
proc print data=HospInfo_Updated;
    var Hospital_Onwership safety_comparison;
    where safety_comparison="Below the National average";
    output out=temp;
run;

proc print noobs data=temp;
    id Hospital_Ownership;
    var safety_comparison;
run;
title;
footnote;


title1
'Research Question: What are the lowest "below the national average" effectiveness of care ratings in terms of 
hospital Ownership type?'
;

title2
'Rationales: It will give us an idea of what type of hospitals function  effectively.'
;

footnote1
'Based on the above output,  we can find how hospitals are effective by sortin each type of hospital and calcuate their means.'
;
*
Methodology: in this case, we would use the "WHERE" command to calculate the hospitals that have "below the average" 
rating so we can find which type of hospitals have the lowest numbers 
of this rating. Then, we can aapply the “PROC PRINT” statement.

Limitations: The ownership types vary and are not proportioned equally.

Possible Follow-up Steps: We may need to redefine some variables.
;
proc print data=HospInfo_Updated;
    var Hospital_Onwership Effectiveness_comparison;
    where Effectiveness_comparison="Below the National average";
    output out=temp;
run;

proc print noobs data=temp;
    id Hospital_Ownership;
    var effectiveness_comparison;
run;
title;
footnote;


title1
'Research Question: what kind of hospital has the lowest average in terms of the holistic rating?'
;

title2
'Rationales: This will help us find the struggluing hospital ownership types.'
;

footnote1
'Based on the output, SAS gives us the rating order in each of each tyoe of hospitalwhich is 2.88.'
;
*
Methodology:  By using “PROC PRINT” statement, we can show the overall hospital rating which will help us find  the lowest average  .

Limitations: the rating values may not exactly be accounted for the ratio for each hospital type.

Possible Follow-up Steps: We may need to try  rearranging the "Hospital_Type" variable.
;
Proc print noods data= temp;
id Hospital_Type;
Var Hospital_overall_rating;
run;
title;
footnote;
