* Encoding: UTF-8.
* The table presents three indicators, one of which may require customisation: MICS Indicator LN.22b is measured on children with age for primary grades 2 and 3. 
* Following the standard used throughout the standard LN tables, 
* the indicator is set age age 7 and 8, as children start school at age 6. 
* For example, if primary grade 1 is set at age 7 in a country, this indicator should instead be measured on age group 8-9.

*Open datafile. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
GET FILE='fs.sav'.

*Apply weight. 
weight by fsweight.

*The denominator includes all children with a completed module (FL29=01).
select if (FL29 = 1).

 * Percentage of children who successfully complete:
- A number reading task: All FL23=1
- A number discrimination task: All FL24=1
- An addition task: All FL25=1
- A pattern recognition and completion task: All FL27=1
- Demonstrate foundational numeracy skills: All of the above.

*A number reading task: All FL23=1.
count numberReadTarget = FL23A FL23B FL23C FL23D FL23E FL23F (1).
compute numberRead = 0.
if (numberReadTarget = 6) numberRead = 100.
variable labels numberRead "Percentage of children who successfully completed tasks of: Number reading".

*-A number discrimination task: All FL24=1.
compute numberDiscr  = 0.
*if (FL24A = "7" and FL24B = "24" and FL24C = "58" and FL24D = "67" and FL24E = "154" ) numberDiscr = 100.
if (FL24A = 1 and FL24B = 1 and FL24C = 1 and FL24D = 1 and FL24E = 1) numberDiscr = 100.
variable labels numberDiscr "Percentage of children who successfully completed tasks of: Number discrimination".

*An addition task: All FL25=1.
compute numberAdd  = 0.
*if (FL25A = "5" and FL25B = "14" and FL25C = "10" and FL25D = "19" and FL25E = "36") numberAdd = 100.
if (FL25A = 1 and FL25B = 1 and FL25C = 1 and FL25D = 1 and FL25E =1) numberAdd = 100.
variable labels numberAdd "Percentage of children who successfully completed tasks of: Addition".

*A pattern recognition and completion task: All FL27=1.
compute numberPattern = 0.
*if (FL27A = "8" and FL27B = "16" and FL27C = "30" and FL27D = "8" and FL27E = "14") numberPattern = 100.
*if (FL27A = 1 and FL27B = 1 and FL27C = 1 and FL27D = 1 and FL27E = 1) numberPattern = 100.
* Sierra Leone specific - remove D and E.
if (FL27A = 1 and FL27B = 1 and FL27C = 1) numberPattern = 100.
variable labels numberPattern "Pattern recognition and completion".

*Number of children who are not learning math. 
compute numSkill = 0.
if (numberRead = 100 and numberDiscr = 100 and numberAdd = 100 and numberPattern = 100) numSkill = 100.
variable labels numSkill "Percentage of children who demonstrate foundational numeracy skills".
	

*Number of children 7-14 years old. 
compute numChildren = 1.
variable labels numChildren "Number of children age 7-14 years".
value labels numChildren 1 "Number of children age 7-14 years".	

*Recode for mother's education. 
recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information".

*Recode for mother's functional difficulties. 
recode mdisability (sysmis = 3) (else = copy).
variable labels mdisability "Mother's functional difficulties".
add value labels mdisability 3 "No information".

variable labels fsdisability "Child's functional difficulties".

*Recode school attendance. 
recode CB8A (0=0)(1=10)(2=20)(3,4,5 = 30) (8,9 = 99)(else = 100) into school.
variable labels school "School attendance".
value lables school
0 "Early childhood education"
10 "Primary"
20 "Lower secondary"
30 "Upper secondary"
99 "DK/Missing"
100 "Out-of-school".

*Recode school attendance status and grade. 
compute schoolAux = school.
if ((CB8A = 1 or CB8A = 2) and CB8B < 97)  schoolAux1 = school + CB8B.
if ((CB8A = 1 or CB8A = 2) and CB8B >= 97) schoolAux1 = 99.
if (CB8A = 1 and (CB8B = 2 or CB8B = 3)) schoolAux2 = 11.1.

value labels schoolAux
0      "Early childhood education"
10    "Primary"
11     "  Grade 1"
11.1  "  Grade 2-3 [3]"
12     "    Grade 2"
13     "    Grade 3"
14     "  Grade 4"
15     "  Grade 5"
16     "  Grade 6"
20    "Lower secondary"
21     "  Grade 1"
22     "  Grade 2"
23     "  Grade 3"
30     "Upper secondary"
99     "DK/Missing"
100   "Out-of-school".

* Define Multiple Response Sets.
mrsets
  /mcgroup name = $school
           label = 'School attendance'
           variables = schoolAux schoolAux1 schoolAux2.

compute schageAux = schage.
if (schage = 7 or schage = 8) schageAux1 = 6.1.

value labels schageAux
 6    "6"
 6.1 "7-8 [2]"
 7    "   7"
 8    "   8"
 9    "9"
 10  "10"
 11  "11"
 12  "12"
 13  "13"
 14  "14".

* Define Multiple Response Sets.
mrsets
  /mcgroup name = $schage
           label = 'Age at beginning of school year'
           variables = schageAux schageAux1.

* Only the total pane includes the column "Percentage of children for whom the reading book was not available in appropriate language". 
* The algorithm for this is: (CB7/ED9=1 and FL9>3) or (CB7/ED9=2 or blank and FL7>3). 
* Note the categories accepted for FL9 and FL7 are those for which no reading book was available). 
* This must be customised in syntax.
compute notAvailable = 0.
if (FL7 <> 1 and FL9 <> 1) notAvailable = 100.
variable labels notAvailable " ".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".	

compute tot = 1.
variable labels tot "".
value labels tot 1 "Total".	

*  For labels in French uncomment commands below.
* variable labels school "Fréquentation scolaire".
* value lables school
0 "Prescolaire"
10 "Primaire"
20 "Secondaire 1er Cycle"
30 "Secondaire 2eme Cycle"
99 "NSP/Manquant"
100 "En dehors de l'école".

* value labels schoolAux
0      "Prescolaire"
10    "Primaire"
11     "  Niveau 1"
11.1  "  Niveau 2-3 [3]"
12     "    Niveau 2"
13     "    Niveau 3"
14     "  Niveau 4"
15     "  Niveau 5"
16     "  Niveau 6"
20    "Secondaire 1er Cycle"
21     "  Niveau 1"
22     "  Niveau 2"
23     "  Niveau 3"
30     "Secondaire 2eme Cycle"
99     "NSP/Manquant"
100   "En dehors de l'école".

* variable labels mdisability "Difficultés fonctionnelles de la mère".
* add value labels mdisability 3 "Aucune information".

* Ctables command in English (currently active, comment it out if using different language).


*compute attendance. 
Compute attnd=$sysmis. 
If CB7=1 attnd=1.
If CB7=2 attnd=0.
Value labels attnd 0 "not attending" 1 "attending". 

*Customized table. 
ctables
  /format missing = "na" 
  /vlabels variables = numChildren numberRead numberDiscr numberAdd numberPattern numSkill HL4 tot
           display = none
  /table   total [c] 
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + $schage [c]
         + $school [c]
         + melevel [c]
         + fsdisability [c]
         + mdisability [c]
         + windex5 [c]
         + ethnicity [c]
   by
          hl4 [c] > (numberRead [s] [mean,'Percentage of children who successfully completed tasks of: Number reading',f5.1] + 
                       numberDiscr [s] [mean,'Percentage of children who successfully completed tasks of: Number discrimination',f5.1]  + 
                       numberAdd [s] [mean,'Percentage of children who successfully completed tasks of: Addition',f5.1] + 
                       numberPattern [s] [mean,'Percentage of children who successfully completed tasks of: Pattern recognition and completion',f5.1] + 
                       numSkill [s] [mean,'Percentage of children who demonstrate foundational numeracy skills',f5.1] + 
                       numChildren [s] [validn,'Number of children age 7-14 years',f5.0]) +
          tot [c] > (numberRead [s] [mean,'Percentage of children who successfully completed tasks of: Number reading',f5.1] + 
                       numberDiscr [s] [mean,'Percentage of children who successfully completed tasks of: Number discrimination',f5.1]  + 
                       numberAdd [s] [mean,'Percentage of children who successfully completed tasks of: Addition',f5.1] + 
                       numberPattern [s] [mean,'Percentage of children who successfully completed tasks of: Pattern recognition and completion',f5.1] + 
                       numSkill [s] [mean,'Percentage of children who demonstrate foundational numeracy skills [1],[2],[3]',f5.1] + 
                       numChildren [s] [validn,'Number of children age 7-14 years',f5.0])
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Foundatioanl Numeracy skills"																
    "Percentage of children aged 7-14 who demonstrate foundational numeracy skills by successfully completing three foundational numeracy tasks, by sex, " + "Sierra Leone MICS 2017"
   caption = 
   "[1] 1 MICS indicator LN.22d - Foundational reading and number skills"																			
   "[2] MICS indicator LN.22e - Foundational reading and number skills"																			
   "[3] MICS indicator LN.22f - Foundational reading and number skills; SDG indicator 4.1.1".			
* Ctables command in French.  
* ctables
  /format missing = "na" 
  /vlabels variables = numChildren numberRead numberDiscr numberAdd numberPattern numSkill HL4 tot
           display = none
  /table   total [c] 
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + $schage [c]
         + $school [c]
         + melevel [c]
         + fsdisability [c]
         + mdisability [c]
         + windex5 [c]
         + ethnicity [c]
   by
          hl4 [c] > (numberRead [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Lecture des nombres',f5.1] + 
                       numberDiscr [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Discrimination des nombres',f5.1]  + 
                       numberAdd [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Addition',f5.1] + 
                       numberPattern [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Reconnaissance et Achèvement de modèle',f5.1] + 
                       numSkill [s] [mean,'Pourcentage d'enfants démontrant des compétences en calcul',f5.1] + 
                       numChildren [s] [validn,'Nombre d'enfants âgés de 7-14 ans ',f5.0]) +
          tot [c] > (numberRead [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Lecture des nombres',f5.1] + 
                       numberDiscr [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Discrimination des nombres',f5.1]  + 
                       numberAdd [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Addition',f5.1] + 
                       numberPattern [s] [mean,'Pourcentage d'enfants ayant accompli avec succès les tâches suivantes: Reconnaissance et Achèvement de modèle',f5.1] + 
                       numSkill [s] [mean,'Pourcentage d'enfants démontrant des compétences en calcul [1],[2],[3]',f5.1] + 
                       numChildren [s] [validn,'Nombre d'enfants âgés de 7-14 ans ',f5.0])
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Tableau LN.4.2: Compétences en calcul"																
    "Pourcentage d'enfants âgés de 7 à 14 ans qui démontrent des compétences fondamentales en numératie en accomplissant avec succès trois tâches fondamentales en numératie, selon le sexe, " + surveyname
   caption = 
   "[1] Indicateur MICS LN.22d - Compétences de base en Lecture de base et Calcul"																			
   "[2] Indicateur MICS LN.22e - Compétences de base en Lecture de base et Calcul"																			
   "[3] Indicateur MICS LN.22f - Compétences de base en Lecture de base et Calcul; Indicateur SDG 4.1.1".	
new file.
