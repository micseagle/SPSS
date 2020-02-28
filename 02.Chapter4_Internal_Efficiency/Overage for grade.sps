* Encoding: UTF-8.
*Open datafile. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
get file hl.sav. 

*Apply weight. 
weight by hhweight.

* Select children who are of primary school age; this definition is
* country-specific and should be changed to reflect the situation in your
* country.
compute primarySchoolEntryAge = 6 .

* number of grades, years in primary school .
compute primarySchoolGrades = 6 .

* number of grades, years in lower secondary school .
compute LowSecSchoolGrades = 3 .

* number of grades, years in upper secondary school .
compute UpSecSchoolGrades = 4 .

* entry age in secondary school in years, no need to customize .
compute LowSecSchoolEntryAge = primarySchoolEntryAge +  primarySchoolGrades.
compute UpSecSchoolEntryAge = primarySchoolEntryAge +  primarySchoolGrades + LowSecSchoolGrades.
compute primarySchoolCompletionAge = LowSecSchoolEntryAge - 1 .
compute LowSecSchoolCompletionAge = UpSecSchoolEntryAge - 1 .
compute UpSecSchoolCompletionAge = UpSecSchoolEntryAge + UpSecSchoolGrades - 1 .


*The denominators for this table are children currently attending primary school (left panel) and children currently attending lower secondary school (right panel).

*Children are distributed according to age against current grade of attendance, e.g. a child age 8 years (at the beginning of the school year) currently attending grade 1 will enter one of the listed categories depending on the education system of the country and official age for grade. In the example, assume that children age 8 are officially to be in grade 3. The child age 8 in grade 1 will be classified age over-age by 2 or more years.

*An additional category for Missing/DK should be added if the data contains such cases of unknown levels or grades of current attendance.

* Children attending primary school.
do if (ED10A = 1).

compute ageP = 0.
if (schage < primarySchoolEntryAge) ageP = 1.
if (schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge) ageP = 2.
if (schage = primarySchoolCompletionAge + 1) ageP = 3.
if (schage > primarySchoolCompletionAge + 1) ageP = 4.

variable labels ageP "Primary school: Percent of children by grade of attendance:".
value labels ageP 1 "Under-age"  2 "At official age" 3 "Over-age by 1 year	" 4 "Over-age by 2 or more".

compute numPrimary = 1.
variable labels numPrimary "Number of children attending primary school".

end if.

* Children attending lower secondary school.
do if (ED10A = 2).

compute ageLS = 0.
if (schage < LowSecSchoolEntryAge) ageLS = 1.
if (schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) ageLS = 2.
if (schage = LowSecSchoolCompletionAge + 1) ageLS = 3.
if (schage > LowSecSchoolCompletionAge + 1) ageLS = 4.

variable labels ageLS "Lower secondary school: Percent of children by grade of attendance:".
value labels ageLS 1 "Under-age"  2 "At official age" 3 "Over-age by 1 year" 4 "Over-age by 2 or more [2]".

compute numSecondary = 1.
variable labels numSecondary "Number of children attending lower secondary school".

end if.

recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information".

recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

recode ED10B (7 thru hi = sysmis) (else = copy).
variable labels ED10B "Grade".
value labels ED10B
1 "1 (primary/lower secondary)"
2 "2 (primary/lower secondary)"
3 "3 (primary/lower secondary)"
4 "4 (primary)"
5 "5 (primary)"
6 "6 (primary)".

*  For labels in French uncomment commands below.
* variable labels 
      numPrimary "Nombre d'enfants frÃ©quentant l'Ã©cole primaire"
	 /numSecondary "Nombre d'enfants frÃ©quentant le collÃ¨ge".

* variable labels ageP "Ã‰cole primaire: Pourcentage d'enfants par niveau de frÃ©quentation:".
* value labels ageP 1 "Sous-l'Ã¢ge officiel"  2 "Ã€ l'Ã¢ge officiel" 3 "Plus de 1 an" 4 "Plus de 2 ans ou plu [1]".

* variable labels ageLS "Premier cycle du secondaire: Pourcentage d'enfants par niveau de frÃ©quentation:".
* value labels ageLS 1 "Sous-l'Ã¢ge officiel"  2 "Ã€ l'Ã¢ge officiel" 3 "Plus de 1 an" 4 "Plus de 2 ans ou plu [2]".

* variable labels ED10B "Niveau scolaire".
* value labels ED10B
1 "1 (primaire / secondaire infÃ©rieur)"
2 "2 (primaire / secondaire infÃ©rieur)"
3 "3 (primaire / secondaire infÃ©rieur)"
4 "4 (primaire)"
5 "5 (primaire)"
6 "6 (primaire)".

* variable labels disability "DifficultÃ©s fonctionnelles de la mÃ¨re".
* add value labels disability 3 "Aucune information".
* add value labels melevel 5 "Aucune information".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = numPrimary numSecondary
           display = none
  /table   total [c] 
        + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + ED10B [c]
         + melevel [c]
         + disability [c]
         + windex5 [c]
         + ethnicity [c]
   by
             ageP[c] [rowpct.validn,'',f5.1]
           + numPrimary [s] [validn,'Number of children attending primary school',f5.0] 
           + ageLS [c] [rowpct.validn,'',f5.1]
           + numSecondary [s] [validn,'Number of children attending lower secondary school',f5.0] 
  /categories var=all empty=exclude missing=exclude
  /categories var=ageP ageLS total=yes position = after label = "Total"
  /slabels position=column
  /titles title=
    "Age for grade"												
     "Percentage of children attending primary and lower secondary school who underage, at age and overage for grade, " + "Sierra Leone 2017"
   caption = 
          "Over-age for grade (Primary)"												
          "Over-age for grade (Secondary)"												
          "na: not applicable".

* Ctables command in French.  
* ctables
  /vlabels variables = numPrimary numSecondary
           display = none
  /table   total [c] 
        + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + ED10B [c]
         + melevel [c]
         + disability [c]
         + windex5 [c]
         + ethnicity [c]
   by
             ageP[c] [rowpct.validn,'',f5.1]
           + numPrimary [s] [validn,'Nombre d'enfants frÃ©quentant l'Ã©cole primaire',f5.0] 
           + ageLS [c] [rowpct.validn,'',f5.1]
           + numSecondary [s] [validn,'Nombre d'enfants frÃ©quentant le collÃ¨ge',f5.0] 
  /categories var=all empty=exclude missing=exclude
  /categories var=ageP ageLS total=yes position = after label = "Total"
  /slabels position=column
  /titles title=
    "Tableau LN.2.5: Ã‚ge par niveau"												
     "Pourcentage d'enfants qui frÃ©quentent l'Ã©cole primaire et le premier cycle du secondaire et qui ont:  moins que l'Ã¢ge officiel, l'Ã¢ge officiel, plus que cet Ã¢ge, " + surveyname
   caption = 
          "[1] Indicateur MICS LN.10a - Plus Ã¢gÃ© pour le niveau (Primaire)"												
          "[2] Indicateur MICS LN.10b - Plus Ã¢gÃ© pour le niveau (Secondaire)"												
          "na: n'est pas applicable".


new file.
