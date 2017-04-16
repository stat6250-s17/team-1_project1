*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding free/reduced-price meals at CA public K-12 schools
Dataset Name: FRPM1516_analytic_file created in external file
STAT6250-02_s17-team-0_project1_data_preparation.sas, which is assumed to be
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
Methodology:
Limitations:
Possible Follow-up Steps:

[Research Question 2] Which Hospitals have the most ‘below the national average’ ratings? 
Rationale: This would allow us to identify the hospitals that need the most support.
Methodology:
Limitations:
Possible Follow-up Steps:

[Research Question 3] Which State has the highest overall rating of hospitals? 
Rationale: If we compare this to state population size, we might be able to find out if population has an effect on the effectiveness of a hospital. 
Methodology:
Limitations:
Possible Follow-up Steps:
;
