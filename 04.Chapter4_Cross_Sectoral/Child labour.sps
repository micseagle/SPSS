* Encoding: UTF-8.
***.
*Open table file for 5-17 questionaire. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.

get file = 'fs.sav'.

select if (FS17 = 1).

weight by fsweight.

if (FS4 = 90) melevel = 5.
add value labels melevel
  5 'No information [A]'.

recode CB7 (1 = 1) (else = 2) into schoolAttendance.
variable labels schoolAttendance "School attendance".
value labels schoolAttendance 1 "Attending" 2 "Not attending" .


*Children are considered to be in child labour if they fall into at least one of three categories of child labour: economic activities, household chores, hazardous conditions. These three categories are coded with the following variables:
•	Economic activities – Variables CL1A, CL1B, CL1C and CL1X describe several economic activities. Children are considered to be working in economic activities if they respond yes (CL1=1) to any of these questions
•	Household chores – Variables CL11A, CL11B, CL11C, CL11D, CL11E, CL11F and CL11X describe several household chores. Children are considered to be performing household chores if they respond yes (CL11=1) to any of these questions
•	Hazardous conditions – Variables CL4, CL5, CL6A, CL6B, CL6C, CL6D, CL6E and CL6X describe hazardous conditions. Responding yes (1) to any of those variables qualifies as hazardous conditions.
*To qualify as child labour for, both, economic activity and household chores, a threshold for the number of hours has been established. This threshold changes based on age group and the activity. For economic activity, the threshold is established in variable CL3 and is the following:
•	Age 5-11: 1 hour or more
•	Age 12-14: 14 hours or more
•	Age 15-17: 43 hours or more
For household chores, two age specific threshold are established using variables CL8, CL10 and CL12 and are the following: 
•	Age 5-14: 28 hours or more
•	Age 15-17: 43 hours or more
*Working under hazardous conditions, regardless of the number of hours already qualifies as child labour.  

* definitions of econcomic activity variables  (ea1more, ea14less, ea14more, ea43less, ea43more) .
compute economicActivity = any(1, CL1A, CL1B, CL1C, CL1X) .

do if (CB3<=11) .
+ compute numChildren5_11 = 1 .
+ compute ea1more = 0 .
+ compute ea1less = 0 .
+ if (economicActivity=1 and CL3<1) ea1less = 100 .
+ if (economicActivity=1 and CL3>=1 and CL3<97) ea1more = 100 .
end if .

do if (any(CB3,12,13,14)) .
+ compute numChildren12_14 = 1 .
+ compute ea14less = 0 .
+ compute ea14more = 0 .
+ if (economicActivity=1 and CL3<14) ea14less = 100 .
+ if (economicActivity=1 and CL3>=14 and CL3<97) ea14more = 100 .
end if.

do if (any(CB3,15,16,17)) .
+ compute numChildren15_17 = 1 .
+ compute ea43less = 0 .
+ compute ea43more = 0 .
+ if (economicActivity=1 and CL3<43) ea43less = 100 .
+ if (economicActivity=1 and CL3>=43 and CL3<97) ea43more = 100 .
end if.

compute  eaLess = sum(0, ea1less, ea14less, ea43less) .
compute  eaMore = sum(0, ea1more, ea14more, ea43more) .

*To calculate for household chores.
compute hhChores = any(1, CL7, CL9, CL11A, CL11B, CL11C, CL11D, CL11E, CL11F, CL11X) .

do if (CB3<=14) .
+ compute hhc28less = 0 .
+ compute hhc28more = 0 .
+ if (hhChores=1 and sum(CL8, CL10, CL13)<28)  hhc28less = 100 .
+ recode CL8 (97,98,99=0).
+ recode CL10 (97,98,99=0).
+ recode CL13 (97,98,99=0).
+ if (hhChores=1 and sum(CL8, CL10, CL13)>=28) hhc28more = 100 .
end if.

do if (any(CB3, 15, 16, 17)) .
+ compute hhc43less = 0 .
+ compute hhc43more = 0 .
+ recode CL8 (97,98,99=0).
+ recode CL10 (97,98,99=0).
+ recode CL13 (97,98,99=0).
+ if (hhChores=1 and sum(CL8, CL10, CL13)<43)  hhc43less = 100 .
+ if (hhChores=1 and sum(CL8, CL10, CL13)>=43) hhc43more = 100 .
end if.

compute  hhcLess = sum(0, hhc28less, hhc43less) .
compute  hhcMore = sum(0, hhc28more, hhc43more) .


*To calculate for hazardarous Conditions.
compute hazardConditions = 0 .
if (any(1, CL4, CL5, CL6A, CL6B, CL6C, CL6D, CL6E, CL6X)) hazardConditions = 100 .

compute childLabor = maximum(0, eaMore, hhcMore, hazardConditions) .

variable labels
   eaLess "Below the  age specific threshold"
  /eaMore "At or above the age specific threshold"
  /hhcLess "Below the age specific threshold"
  /hhcMore "At or above the age specific threshold"
  /hazardConditions "Children working under hazardous conditions"
  /childLabor "Total child labour [1]" .

compute layerEA = 1 .
compute layerHHC = 1 .
compute numChildren = 1 .

value labels
   layerEA   1 "Children involved in economic activities for a total number of hours during last week:"
  /layerHHC  1 "Children involved in household chores for a total number of hours during last week:"
  /numChildren 1 "Number of children age 5-17 years"
  .

recode CB3 (5 thru 11 = 1) (12 thru 14 = 2) (15 thru 17 = 3) into ageGroup .
variable labels ageGroup "Age" .
value labels ageGroup
1 "5-11"
2 "12-14"  
3 "15-17".
formats ageGroup (f1.0).

variable labels fsdisability "Child's functional difficulty".

variable labels mdisability "Mother's functional difficulties (age 18-49 years)".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = numChildren layerEA layerHHC
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + schoolAttendance [c]
         + melevel [c]
         + fsdisability [c]
         + mdisability [c]
         + ethnicity [c]
         + windex5 [c]
   by
           layerEA [c] > (
             ealess[s] [mean '' f5.1]
           + eaMore[s] [mean '' f5.1] )
         + layerHHC [c] > (
             hhcLess[s] [mean '' f5.1]
           + hhcMore[s] [mean '' f5.1] )
         + hazardConditions [s] [mean '' f5.1]
         + childLabor [s] [mean '' f5.1]
         + numChildren [c] [count '' f5.0]
  /categories var=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
     "Child labour"
      "Percentage of children age 5-17 years by involvement in economic activities or household chores during the last week, percentage " +
     "working under hazardous conditions during the last week, and percentage engaged in child labour during the last week, " + "Sierra Leone 2017". 
  .			

new file.
