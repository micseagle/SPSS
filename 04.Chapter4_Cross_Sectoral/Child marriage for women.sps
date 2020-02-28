* Encoding: UTF-8.
*Open dataset. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
get file = 'wm.sav'.


*Filter the questionaire that has been completed. 
select if (WM17 = 1).

*Apply weight. 
weight by wmweight.


*The general formula for calculation is the percentage of women/men/people from a certain age group 
(for example 15 to 49 or 20 to 24) who first married or entered a marital union before their 15th or 18th birthday. Customize the age bracket. 
compute numWomen15_49 = 1.
compute before15_1 = 0.
if (WAGEM < 15) before15_1 = 100.

do if (WB4 >= 20).
+ compute numWomen20_49 = 1.
+ compute before15 = 0.
+ if (WAGEM < 15) before15 = 100.
+ compute before18 = 0.
+ if (WAGEM < 18) before18 = 100.
end if.

do if (WB4 < 20).
+ compute numWomen15_19 = 1.
+ compute currentlyMarried = 0.
+ if any(MA1, 1, 2) currentlyMarried = 100 .
end if.

compute layer15_49 = 1 .
compute layer20_49 = 1 . 
compute layer15_19 = 1 .

value labels 
   layer15_49 1 "Women age 15-49 years"
  /layer20_49 1 "Women age 20-49 years" 
  /layer15_19 1 "Women age 15-19 years"
  /numWomen15_49 1 "Number of women age 15-49 years" 
  /numWomen20_49 1 "Number of women age 20-49 years"
  /numWomen15_19 1 "Women age 15-19 years".
  
  
variable labels 
    before15    "Percentage married before age 15"
   /before15_1  "Percentage married before age 15 [1]" 
   /before18    "Percentage married before age 18 [2]"
   /currentlyMarried "Percentage currently  married/in union [3]".

variable labels disability "Functional difficulties (age 18-49 years)".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /format missing = "na" 
  /vlabels variables = layer15_19 layer15_49 layer20_49 numWomen15_19 numWomen15_49 numWomen20_49
           display = none
  /table  total [c]
        + hh6 [c]
        + hh7 [c]
        + hh7a [c]
        + wage [c]
        + welevel [c]
        + disability [c]
        + ethnicity [c]
        + windex5 [c]
   by
          layer15_49 [c] > (
            before15_1 [s][mean,'',f5.1]
          + numWomen15_49 [c][count,'',f5.0] )
        + layer20_49 [c] > (
            before15 [s][mean,'',f5.1]
          + before18 [s][mean,'',f5.1]
          + numWomen20_49 [c][count,'',f5.0] )
        + layer15_19 [c] > (
            currentlyMarried [s][mean,'',f5.1]
          + numWomen15_19 [c][count,'',f5.0] )
  /slabels position=column visible = no
  /categories var=all empty=exclude missing=exclude
  /titles title=
    "Child marriage for women"
    "Percentage of women age 15-49 years who first married or entered a marital union before their 15th birthday, " 
    "percentages of women age 20-49 and 20-24 years who first married or entered a marital union before their 15th and 18th birthdays, "
    "percentage of women age 15-19 years currently married or in union  " + "Sierra Leone MICS 2017". 
  .

new file.
