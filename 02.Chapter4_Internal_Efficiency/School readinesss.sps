* Encoding: UTF-8.
*Open datafile. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
get file hl.sav.

weight by hhweight. 

* Select children who are attending first grade of primary education regardless of age.
select if (ED10A = 1 and ED10B = 1).


*Number of children who are attending first grade of primary school. 
compute numChildren = 1.
variable labels numChildren  "".
value labels numChildren 1 "Number of children attending first grade of primary school".

compute firstGrade  = 0.
if (ED16A = 0) firstGrade =  100.
variable labels firstGrade "Percentage of children attending first grade who attended preschool in previous year".

recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = numChildren
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + melevel [c]
         + disability [c]
         + ethnicity [c]
         + windex5 [c]
   by
           firstGrade [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "School readiness"	
    "Percentage of children attending first grade of primary school who attended pre-school the previous year, " + "Sierra Leone 2017"
   caption=
    "School readiness"
  .

* Ctables command in French.  
* ctables
  /vlabels variables = numChildren
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + melevel [c]
         + disability [c]
         + ethnicity [c]
         + windex5 [c]
   by
           firstGrade [s] [mean,'',f5.1]
         + numChildren [c] [count,'',f5.0]
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Tableau LN.2.1: Préparation à l'école"	
    "Pourcentage d'enfants inscrits en première année d'école primaire ayant fréquenté l'école maternelle l'année précédente, " + surveyname
   caption=
    "[1] Indicateur MICS LN.3 - Préparation à l'école"
  .

new file.
