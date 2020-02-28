* Encoding: UTF-8.
 * Responses to questions EC6-EC15 are used to determine whether children are developmentally on track in four domains: 
   Literacy-numeracy: Developmentally on track if at least two of the following are true: 
  EC6=1 (Can identify/name at least ten letters of the alphabet), 
  EC7=1 (Can read at least four simple, popular words), 
  EC8=1 (Knows the name and recognizes the symbol of all numbers from 1 to 10).
 * Physical: Developmentally on track if one or both of the following is true: 
  EC9=1 (Can pick up a small object with two fingers, like a stick or a rock from the ground), 
  EC10=2 (Is not sometimes too sick to play).
 * Social-emotional: Developmentally on track if at least two of the following are true: 
  EC13=1 (Gets along well with other children), 
  EC14=2 (Does not kick, bite, or hit other children), 
  EC15=2 (Does not get distracted easily).
 * Learning: Developmentally on track if one or both of the following is true: 
  EC11=1 (Follows simple directions on how to do something correctly), 
 EC12=1 (When given something to do, is able to do it independently).

 * MICS indicator TC.53 is calculated as the percentage of children who are developmentally on track in at least three of the four component domains (literacy-numeracy, physical, social-emotional, and learning).

***.

* Call include file for the working directory and the survey name.
include "surveyname.sps".

* open children dataset.
get file = 'ch.sav'.

include "CommonVarsCH.sps".

* Select completed interviews.
select if (UF17 = 1).

* Select children 36+ months old.
select if (UB2 >= 3).

* Weight the data by the children weight.
weight by chweight.

* Generate number of children age 36-59 months.
compute numChildren = 1.
value labels numChildren  1 "".
variable labels numChildren "Number of children age 3-4 years".

* Compute indicators.
recode EC6 (1 = 100) (else = 0).
recode EC7 (1 = 100) (else = 0).
recode EC8 (1 = 100) (else = 0).

count langcog = EC8 EC7 EC6 (100).

recode langcog (2,3 = 100) (0,1 = 0) into langcog2.
variable labels langcog2 "Literacy-numeracy".

recode EC9  (1 = 100) (else = 0).
recode EC10 (2 = 100) (else = 0).

count physical = EC10 EC9 (100).

recode physical (1,2 = 100) (0 = 0) into physical2.
variable labels physical2 "Physical".

recode EC13 (1 = 100) (else = 0).
recode EC14 (2 = 100) (else = 0).
recode EC15 (2 = 100) (else = 0).

count socemo = EC15 EC14 EC13 (100).

recode socemo (2,3 = 100) (0,1 = 0) into socemo2.
variable labels socemo2 "Social-Emotional".

recode EC11 (1 = 100) (else = 0).
recode EC12 (1 = 100) (else = 0).

count learn = EC12 EC11 (100).

recode learn (1,2 = 100) (0 = 0) into learn2.
variable labels learn2 "Learning".

count develop = langcog2 physical2 socemo2 learn2 (100).

recode develop (3,4 = 100) (0,1,2 = 0)  into target.

variable labels target "Early child development index score [1]".

recode UB8 (1 = 1) (9 = 8) (else = 2).
variable labels UB8 "Attendance to early childhood education".
value labels UB8
  1 "Attending"
  2 "Not attending "
  8 "Missing".
										  
variable labels ub2 "Age".
value labels ub2 3 "3" 4 "4".

compute layer = 0.
variable labels layer "".
value labels layer 0 "Percentage of children age 3-4 years who are developmentally on track for indicated domains".

compute total = 1.
variable labels total "Total".
value labels total 1" ".

variable labels cdisability "Functional difficulties".

* For labels in French uncomment commands below.
* variable labels
   ub8 "Fréquentation d'un programme prescolaire "
  /learn2 "Apprentissage"
  /socemo2 "Socio-Emotionnel "
  /physical2 "Physique"
  /langcog2 "Lecture-Calcul"
  /target "Score de l'indice de développement du jeune enfant [1]"
  /numChildren "Nombre d'enfants de 3-4 ans"
  /cdisability "Difficultés fonctionnelles".
* value labels 
   layer 0 "Pourcentage d'enfants de 3-4 ans qui sont sur la bonne voie de développement dans dans les domaines indiqués"
  /ub8  1 "Fréquente"  2 "Ne fréquente pas " 9 "Manquant".
  
* For labels in Spanish uncomment commands below.
* variable labels
  ub8 "Asistencia a educación temprana"
  /learn2 "Aprendizaje"
  /socemo2 "Social-Emocional "
  /physical2 "Físico"
  /langcog2 "Alfabetización- conocimientos numéricos"
  /target "Puntuación del Índice de desarrollo temprano infantil [1]"
  /numChildren "Número de niños/as de 3-4 años de edad"
  /cdisability "Dificultades funcionales".
* value labels 
   layer 0 "Porcentaje de niños de 3-4 años de edad que están en el desarrollo adecuado de los ámbitos indicados"
  /ub8  1 "Asiste"  2 "No asiste" "Missing".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = layer
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + ub2 [c]
         + ub8 [c]
         + melevel [c]
         + cdisability [c]
        + ethnicity [c]
        + windex5[c]
   by
          layer [c] > ( 
             langcog2 [s] [mean '' f5.1]
           + physical2 [s] [mean '' f5.1]
           + socemo2 [s] [mean '' f5.1]
           + learn2 [s] [mean '' f5.1] )
         + target[s] [mean '' f5.1]
         + numChildren [s] [sum '' f5.0]
  /categories variables=all empty=exclude
  /slabels position=column visible = no
  /titles title=
     "Table TC.11.1: Early child development index"
     "Percentage of children age 3-4 years who are developmentally on track in literacy-numeracy, physical, " +
     "social-emotional, and learning domains, and the early child development index score, " + surveyname
   caption=
     "[1] MICS indicator TC.53 - Early child development index"
  .

* Ctables command in French.
* ctables
  /vlabels variables = layer
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + ub2 [c]
         + ub8 [c]
         + melevel [c]
         + cdisability [c]
        + ethnicity [c]
        + windex5[c]
   by
          layer [c] > ( 
             langcog2 [s] [mean '' f5.1]
           + physical2 [s] [mean '' f5.1]
           + socemo2 [s] [mean '' f5.1]
           + learn2 [s] [mean '' f5.1] )
         + target[s] [mean '' f5.1]
         + numChildren [s] [sum '' f5.0]
  /categories variables=all empty=exclude
  /slabels position=column visible = no
  /titles title=
     "Tableau TC.11.1: Indice de développement de la petite enfance"
     "Pourcentage d'enfants de 3-4 years qui sont sur la bonne voie de développement dans au moins trois des quatre domaines suivants : " +
     "lecture -calcul, physique, socio-émotionnel, apprentissage et score de l'indice de développement du jeune enfant, " + surveyname																										
   caption=
     "[1]  Indicateur MICS TC.53 - Indice de développement du jeune enfant ;  Indicateur ODD 4.2.1"
  .
  
* Ctables command in Spanish.
* ctables
  /vlabels variables = layer
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + ub2 [c]
         + ub8 [c]
         + melevel [c]
         + cdisability [c]
        + ethnicity [c]
        + windex5[c]
   by
          layer [c] > ( 
             langcog2 [s] [mean '' f5.1]
           + physical2 [s] [mean '' f5.1]
           + socemo2 [s] [mean '' f5.1]
           + learn2 [s] [mean '' f5.1] )
         + target[s] [mean '' f5.1]
         + numChildren [s] [sum '' f5.0]
  /categories variables=all empty=exclude
  /slabels position=column visible = no
  /titles title=
     "Tabla TC.11.1: Índice de desarrollo temprano infantil"
     "Porcentaje de niños/as de 3-4 años de edad que están en desarrollo adecuado en los ámbitos de alfabetización- " +
     "conocimientos de números, físico, social-emocional y aprendizaje, y la puntuación del índice de desarrollo de la niñez temprana, " + surveyname
   caption=
     "[1] MICS indicador TC.53 - Índice de desarrollo temprano infantil; Indicador ODS 4.2.1"
  .

new file.
