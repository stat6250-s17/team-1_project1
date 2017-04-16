
[Research question 1] what kind of hospital has the maximum average in terms of the holistic rating?
Rationale: This will help us find the best hospital ownership type.
Methodology: By using the command “PROC MEAN”, we can find the rating mean. Next, by using “PROC SORT”, we can get the means of temp data. Finally, “PROC PRINT”, to show the result.
Limitation: the rating values may not exactly be accounted for the ratio for each hospital type.
Possible Follow-up steps:
Proc means data= hospInfo;
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

[Research question 2] what are the hospitals that show the lowest average rating?
Rationale: This will lead us to know the hospitals that need care most.
Methodology: We can figure that out by applying the command “Where” command and count the least average rating of each hospital and calculate the total. Then, by applying the “PROC SORT” command in descending order, we can arrive at the hospitals that have the lowest national average rating.
Limitation: since the dataset contains more than 4000 hospitals, we need to specify where the splitting point is.
Possible Follow-up steps:
data= hospInfo;
Where column = ‘under the national average’;
run;
By creating a variable “under the national average” to find the count, we have: 
Proc sort data= temp;
by descending ‘ under the national average ’;
run;
Proc print; 


[Research question 3] In what stat is the maximum rating score among hospitals?
Rationale: This will give us an idea whether the state’s population has an impact on the hospital functionality or not. 
Methodology:  By using the “PROC MEAN” command to calculate the mean rating score of every state. Then, by applying the “PROC SORT” command, we can figure which states have the largest rating points. 
Limitation: Here, the amount of hospitals of each state is not equal and her, we would not consider how many hospitals in each state is.

Possible Follow-up steps:

Proc means data= hospInfo;
Class State;
Var Hospital_overall_rating;
Output out= temp;  
run;
Proc sort data= temp;
by descending State;
run;
Proc print noods data= temp;
id State;
Var Hospital_overall_rating;
run;

