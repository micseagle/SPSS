* Encoding: UTF-8.
*Open dataset. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
get file = 'mn.sav'.

*Filter the questionaire that has been completed. 
select if (MWM17 = 1).

*Apply weight. 
weight by mnweight.

*The general formula for calculation is the percentage of women/men/people from a certain age group 
(for example 15 to 49 or 20 to 24) who first married or entered a marital union before their 15th or 18th birthday. Customize the age bracket. 
compute numMen15_49 = 1.
compute before15_1 = 0.
if (MWAGEM < 15) before15_1 = 100.

do if (MWB4 >= 20).
+ compute numMen20_49 = 1.
+ compute before15 = 0.
+ if (MWAGEM < 15) before15 = 100.
+ compute before18 = 0.
+ if (MWAGEM < 18) before18 = 100.
end if.

do if (MWB4 >= 20 and MWB4 <= 24).
+ compute numMen20_24 = 1.
+ compute before15_2 = 0.
+ if (MWAGEM < 15) before15_2 = 100.
+ compute before18_2 = 0.
+ if (MWAGEM < 18) before18_2 = 100.
end if.

do if (MWB4 < 20).
+ compute numMen15_19 = 1.
+ compute currentlyMarried = 0.
+ if any(MMA1, 1, 2) currentlyMarried = 100 .
end if.

compute layer15_49 = 1 .
compute layer20_49 = 1 . 
compute layer20_24 = 1 . 
compute layer15_19 = 1 .
value labels 
   layer15_49 1 "Men age 15-49 years"
  /layer20_49 1 "Men age 20-49 years" 
  /layer20_24 1 "Men age 20-24 years" 
  /layer15_19 1 "Men age 15-19 years"
  /numMen15_49 1 "Number of men age 15-49 years" 
  /numMen20_24 1 "Number of men age 20-24 years"
  /numMen20_49 1 "Number of men age 20-49 years"
  /numMen15_19 1 "Men age 15-19 years" 
  /numMarried 1 "Number of men age 15-49 years currently married/in union".
  
  
variable labels 
    before15    "Percentage married before age 15"
   /before15_1  "Percentage married before age 15" 
   /before15_2  "Percentage married before age 15 [1]" 
   /before18_2  "Percentage married before age 18 [2]"
   /before18    "Percentage married before age 18"
   /currentlyMarried "Percentage currently  married/in union [3]".
variable labels mdisability "Functional difficulties (age 18-49 years)".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

*  For labels in French uncomment commands below.
* value labels 
   layer15_49 1 "Hommes de 15 Ã  49 ans"
  /layer20_49 1 "Hommes de 20 Ã  49 ans" 
  /layer15_19 1 "Hommes de 15 Ã  19 ans"
  /numMen15_49 1 "Nombre d'hommes d'Ã¢ge 15-49 ans" 
  /numMen20_49 1 "Nombre d'hommes d'Ã¢ge 20-49 ans"
  /numMen15_19 1 "Nombre d'hommes d'Ã¢ge 15-19 ans" 
  /numMarried 1 "Nombre d'hommes Ã¢gÃ©es de 15 Ã  49 ans actuellement mariÃ© / en union".
  
  
* variable labels 
    before15    "Pourcentage mariÃ©s avant l'Ã¢ge de 15"
   /before15_1  "Pourcentage mariÃ©s avant l'Ã¢ge de 15 [1]" 
   /before18    "Pourcentage mariÃ© avant l'Ã¢ge de 18 ans [2]"
   /currentlyMarried "Pourcentage actuellement mariÃ©s / en union [3]"
   /inPolygynous "Pourcentage de mariage polygame / union [4]" 
   /mdisability "DifficultÃ©s fonctionnelles de la mÃ¨re (18-49 ans)". 


* Ctables command in English (currently active, comment it out if using different language).
ctables
  /format missing = "na" 
  /vlabels variables = layer15_19 layer15_49 layer20_49 layer20_24 numMarried numMen15_19 numMen15_49 numMen20_49 numMen20_24
           display = none
  /table  total [c]
        + hh6 [c]
        + hh7 [c]
        + hh7a [c]
        + mwage [c]
        + mwelevel [c]
        + mdisability [c]
        + ethnicity [c]
        + windex5 [c]
   by
          layer15_49 [c] > (
            before15_1 [s][mean,'',f5.1]
          + numMen15_49 [c][count,'',f5.0] )
        + layer20_49 [c] > (
            before15 [s][mean,'',f5.1]
          + before18 [s][mean,'',f5.1]
          + numMen20_49 [c][count,'',f5.0] )
        + layer20_24 [c] > (
            before15_2 [s][mean,'',f5.1]
          + before18_2 [s][mean,'',f5.1]
          + numMen20_24 [c][count,'',f5.0] )
        + layer15_19 [c] > (
            currentlyMarried [s][mean,'',f5.1]
          + numMen15_19 [c][count,'',f5.0] )
  /slabels position=column visible = no
  /categories var=all empty=exclude missing=exclude
  /titles title=
    "Child marriage (men)"
    "Percentage of men age 15-49 years who first married or entered a marital union before their 15th birthday, " 
    "percentages of men age 20-49 and 20-24 years who first married or entered a marital union before their 15th and 18th birthdays, "
    "percentage of men age 15-19 years currently married or in union  " + "Sierra Leone MICS 2017". 
  
  * Ctables command in French.  
* ctables
  /format missing = "na" 
  /vlabels variables = layer15_19 layer15_49 layer20_49 numMarried numMen15_19 numMen15_49 numMen20_49
           display = none
  /table  total [c]
        + hh6 [c]
        + hh7 [c]
        + $mwage [c]
        + mwelevel [c]
        + mdisability [c]
        + ethnicity [c]
        + windex5 [c]
   by
          layer15_49 [c] > (
            before15_1 [s][mean,'',f5.1]
          + numMen15_49 [c][count,'',f5.0] )
        + layer20_49 [c] > (
            before15 [s][mean,'',f5.1]
          + before18 [s][mean,'',f5.1]
          + numMen20_49 [c][count,'',f5.0] )
        + layer15_19 [c] > (
            currentlyMarried [s][mean,'',f5.1]
          + numMen15_19 [c][count,'',f5.0] )
        + layer15_49 [c] > (
            inPolygynous [s][mean,'',f5.1]
          + numMarried [c][count,'',f5.0] )
  /slabels position=column visible = no
  /categories var=all empty=exclude missing=exclude
  /titles title=
    "Tableau SR.4.1M: Mariage prÃ©coce et polygynie (hommes)"
    "Pourcentage d'hommes Ã¢gÃ©es de 15 Ã  49 ans qui se sont mariÃ©s ou ont contractÃ© une union conjugale avant leur 15e anniversaire, " 
    "pourcentage de hommes Ã¢gÃ©es de 20 Ã  49 ans et de 20 Ã  24 ans qui se sont mariÃ©es ou ont contractÃ© une union conjugale avant leurs 15e et 18e anniversaires, "
    "les hommes Ã¢gÃ©es de 15 Ã  19 ans actuellement mariÃ©es ou en union, et le pourcentage de hommes qui sont dans un mariage ou une union polygyne,  " + surveyname
  caption = 
    "[1] Indicateur MICS PR.4a - Mariage prÃ©coce"														
    "[2] Indicateur MICS PR.4b - Mariage prÃ©coce"														
    "[3] Indicateur MICS PR.5 - Jeunes hommes Ã¢gÃ©s de 15 Ã  19 ans actuellement mariÃ©s ou en union"															
    "[4] Indicateur MICS PR.6 - Polygynie"	
    "na: n'est pas applicable".

new file.
