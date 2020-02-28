* Encoding: UTF-8.
*Open the dataset for 5-17 questionaire. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
get file = 'fs.sav'.

*Apply the weight. 
weight by fsweight.

*Select children who are 7-14 years old. 
select if (CB3 >=7 and CB3<=14).

compute attendingSchool = 0.
if (CB7 = 1) attendingSchool = 100.
variable labels attendingSchool "Percentage of children attending school".

*Number of 7-14 years old children. 
compute NumChildren = 1.
variable labels NumChildren "Number of children age 7-14".

do if (attendingSchool = 100).

*Percentage of children for whom an adult household member in the last year received a report card for the child: PR10=1.
compute receivedCard = 0.
if (PR10=1) receivedCard = 100.

 * Involvement by adult in school management in last year
- School has a governing body open to parents: PR7=1
- Attended meeting called by governing body: PR8=1
- A meeting discussed key education/financial issues: PR9[A]=1 or PR9[B]=1.

compute govBody = 0.
if (PR7=1) govBody = 100.

compute govBodyMeeting = 0.
if (PR8=1) govBodyMeeting = 100.

compute EdMeeting = 0.
if (PR9A=1 or PR9B = 1) EdMeeting = 100.

 * Involvement by adult in school activities in last year
- Attended school celebration or a sport event: PR11[A]=1
- Met with teachers to discuss child's progress: PR11[B]=1.

compute event = 0.
if (PR11A = 1) event = 100.

compute progress = 0.
if (PR11B = 1) progress = 100.

compute numAttending = 1.

end if.

compute layer1 = 0.
compute layer2 = 0.

variable labels layer1 "".
value labels layer1 0 "Involvement by adult in school management in last year".

variable labels layer2 "".
value labels layer2 0 "Involvement by adult in school activities in last year	".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

variable labels receivedCard "Percentage of children for whom an adult household member in the last year received a report card for the child [1]".
variable labels numAttending "Number of children age 7-14 years attending school".
variable labels govBody "School has a governing body open to parents [2]".
variable labels govBodyMeeting "Attended meeting called by governing body [3]".
variable labels EdMeeting "A meeting discussed key education/ financial issues [4]".
variable labels event "Attended school celebration or a sport event".
variable labels progress " Met with teachers to discuss child's progress [5]".			

recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information".

recode mdisability (sysmis = 3) (else = copy).
variable labels mdisability "Mother's functional difficulties".
add value labels mdisability 3 "No information".

variable labels fsdisability "Child's functional difficulties".

recode CB8A (0=0)(1=1)(2=2)(3,4, 5 = 3) (8,9 = 9)(else = 10) into school.
variable labels school "School attendance [A]".
value lables school
0 "Early childhood education"
1 "Primary"
2 "Lower secondary"
3 "Upper secondary"
9 "DK/Missing"
10 "Out-of-school".

*  For labels in French uncomment commands below.
* variable labels 
       attendingSchool "Pourcentage d'enfants fréquentant l'école [A]"
	  /NumChildren "Nombre d'enfants âgés de 7-14 ans"
	  /receivedCard "Pourcentage d'enfants pour lesquels un membre adulte du ménage a reçu un bulletin scolaire pour l'enfant [1]"
      /numAttending "Nombre d'enfants âgés de 7-14 ans fréquentant l'école"
      /govBody "L'école a un organe directeur ouvert aux parents [2]"
      /govBodyMeeting "Participation aux réunions  convoquée par un organe directeur [3]"
      /EdMeeting "Une réunion a abordé des questions éducatives et financieres clés [4]"
      /event "Participation aux Célébration scolaire ou événement sportif "
      /progress "Rencontré des enseignants pour discuter des progres de l'enfant [5]".
	  
* value labels 
      layer1 0 "Implication d'un adulte dans la gestion scolaire l'année derniere "	  
	 /layer2 0 "Implication d'un adulte dans des activités scolaires l'année derniere ".

* variable labels school "Fréquentation scolaire [A]".
* value lables school
      0 "Prescolaire"
      1 "Primaire"
      2 "Secondaire 1er Cycle"
      3 "Secondaire 2eme Cycle"
      9 "NSP/Manquant"
      10 "'En dehors de l'Ecole".

* variable labels 
    mdisability "Difficultés fonctionnelles de la mere"
   /fsdisability "Difficultés fonctionnelles de l'enfant".
* add value labels mdisability 3 "Aucune information".
* add value labels melevel 5 "Aucune information".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /format missing = "na" 
  /vlabels variables = layer1 layer2
           display = none
  /table   total [c] 
        + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + schage [c]
         + school [c]
         + melevel [c]
         + fsdisability [c]
         + mdisability [c]
         + windex5 [c]
         + ethnicity [c]
   by
           attendingSchool [s] [mean,'',f5.1] 
           + NumChildren [s] [validn,'',f5.0] 
           + receivedCard [s] [mean,'',f5.1] 
           + layer1 [c] > (govBody [s] [mean,'',f5.1] + govBodyMeeting [s] [mean,'',f5.1] + EdMeeting [s] [mean,'',f5.1]) 
           + layer2 [c] > (event [s] [mean,'',f5.1] + progress [s] [mean,'',f5.1]) 
           + numAttending [s] [validn,'',f5.0] 
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Parental involvement"								
     "Percentage of children attending school and, among those, percentage of children for whom an adult member of the household received a report card for the child, "
      "and involvement of adults in school management and school activities in the last year, " + "Sierra Leone MICS 2017". 						

* Ctables command in French.  
* ctables
ctables
  /format missing = "na" 
  /vlabels variables = layer1 layer2
           display = none
  /table   total [c] 
        + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + schage [c]
         + school [c]
         + melevel [c]
         + fsdisability [c]
         + mdisability [c]
         + windex5 [c]
         + ethnicity [c]
   by
           attendingSchool [s] [mean,'',f5.1] 
           + NumChildren [s] [validn,'',f5.0] 
           + receivedCard [s] [mean,'',f5.1] 
           + layer1 [c] > (govBody [s] [mean,'',f5.1] + govBodyMeeting [s] [mean,'',f5.1] + EdMeeting [s] [mean,'',f5.1]) 
           + layer2 [c] > (event [s] [mean,'',f5.1] + progress [s] [mean,'',f5.1]) 
           + numAttending [s] [validn,'',f5.0] 
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Tableau LN.3.1: Soutien a l'apprentissage des enfants a l'école"								
     "Pourcentage d'enfants fréquentant l'école et, parmi ceux-ci, le pourcentage d'enfants pour lesquels un membre adulte du ménage a reçu un bulletin scolaire pour l'enfant, "
      "et l'implication des adultes dans la gestion scolaire et les activités scolaires au cours de la derniere année, " + surveyname
   caption = 
   "[1] Indicateur MICS LN.12 - Disponibilité d'informations sur la performance scolaire des enfants"									
   "[2] Indicateur MICS LN.13 - Opportunite de participer a la gestion de l'école"									
   "[3] Indicateur MICS LN.14: Participation a la gestion de l'école"								
   "[4] Indicateur MICS LN.15 - Participation effective a la gestion de l'école"							
   "[5] Indicateur MICS LN.16 - Discussion avec les enseignants sur les progres des enfants"							
   "[A] La fréquentation de l'école n'est pas directement comparable aux taux net de fréquentation  indiqués dans les tableaux précédents, " +
  "qui utilisent l'information sur tous les enfants de l'échantillon. Ce tableau et les suivants présentent les résultats  " +
  "des modules sur la participation parentale et les compétences d'apprentissage de base administrés aux meres d'un sous-échantillon d'enfants âgés de 7 a 14 ans choisis au hasard."								
  "na: n'est pas applicable".								

new file.
