* Encoding: UTF-8.
*Open datafile and foundational learning module is from 5-17 questionaire. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
GET FILE='fs.sav'.

* The table presents three indicators, one of which may require customisation: MICS Indicator LN.22b is measured on children with age for primary grades 2 and 3. 
* Following the standard used throughout the standard LN tables, 
* the indicator is set age age 7 and 8, as children start school at age 6. 
* For example, if primary grade 1 is set at age 7 in a country, this indicator should instead be measured on age group 8-9.

*Apply weight. 
weight by fsweight.

*The denominator includes all children with a completed module (FL29=01).
select if (FL29 = 1).

 * Percentage of children who:
- Read 90% of words in a story correctly: FL19>=90%
- Correctly answer three literal comprehension questions: FL22[A]=1 and FL22[B]=1 and FL22[C]=1
- Correctly answer two inferential comprehension questions: FL22[D]=1 and FL22[E]=1
- Demonstrate foundational reading skills: All of the above.

*Calculate for children who can Read 90% of words in a story correctly: FL19>=90%.
do if (FL7 = 1 or FL9 = 1).
count target = FL19W1 FL19W2 FL19W3 FL19W4 FL19W5 FL19W6 FL19W7 FL19W8 FL19W9 FL19W10
                        FL19W11 FL19W12 FL19W13 FL19W14 FL19W15 FL19W16 FL19W17 FL19W18 FL19W19 FL19W20
                        FL19W21 FL19W22 FL19W23 FL19W24 FL19W25 FL19W26 FL19W27 FL19W28 FL19W29 FL19W30 
                        FL19W31 FL19W32 FL19W33 FL19W34 FL19W35 FL19W36 FL19W37 FL19W38 FL19W39 FL19W40
                        FL19W41 FL19W42 FL19W43 FL19W44 FL19W45 FL19W46 FL19W47 FL19W48 FL19W49 FL19W50
                        FL19W51 FL19W52 FL19W53 FL19W54 FL19W55 FL19W56 FL19W57 FL19W58 FL19W59 FL19W60
                        FL19W61 FL19W62 FL19W63 FL19W64 FL19W65 FL19W66 FL19W67 FL19W68 FL19W69 FL19W70 
                        FL19W71 FL19W72 (' ').
end if.

recode target (sysmis = 0) (else = copy).

* Replace 72 below with total number of words in your survey.
compute readCorrect = 0.
if (target >= 0.9 * 72 and FL10=1) readCorrect = 100.
variable labels readCorrect " ".

*Calculate for children who can correctly answer three literal comprehension questions: FL22[A]=1 and FL22[B]=1 and FL22[D]=1.
compute aLiteral = 0.
if (FL22A=1 and FL22B=1 and FL22D=1) aLiteral = 100.
variable labels aLiteral " ".

*Correctly answer two inferential comprehension questions: FL22[C]=1 and FL22[E]=1. Please find the relevant inferential question based on the reading questions. 
compute aInferential = 0.
if (FL22C=1 and FL22E=1) aInferential = 100.
variable labels aInferential " ".

compute readingSkill = 0.
if (readCorrect = 100 and aLiteral = 100 and aInferential = 100) readingSkill = 100.
variable labels readingSkill " ".
	

compute numChildren = 1.
variable labels numChildren " ".
value labels numChildren 1 " ".	

recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information".

recode mdisability (sysmis = 3) (else = copy).
variable labels mdisability "Mother's functional difficulties".
add value labels mdisability 3 "No information".

variable labels fsdisability "Child's functional difficulties".

recode CB8A (0=0)(1=10)(2=20)(3,4,5 = 30) (8,9 = 99)(else = 100) into school.
variable labels school "School attendance".
value lables school
0 "Early childhood education"
10 "Primary"
20 "Lower secondary"
30 "Upper secondary"
99 "DK/Missing"
100 "Out-of-school".

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

compute notAvailable = 0.
if (FL7 <> 1 and FL9 <> 1) notAvailable = 100.
variable labels notAvailable "Percentage of children for whom the reading book was not available in appropriate language".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".	

compute tot = 1.
variable labels tot "".
value labels tot 1 "Total".	


*compute attendance. 
Compute attnd=$sysmis. 
If CB7=1 attnd=1.
If CB7=2 attnd=0.
Value labels attnd 0 "not attending" 1 "attending". 

ctables
  /format missing = "na" 
  /vlabels variables = numChildren readCorrect aLiteral aInferential readingSkill notAvailable HL4 tot
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
          hl4 [c] > (readCorrect [s] [mean,'Percentage who correctly read 90% of words in a story',f5.1] + 
                       aLiteral [s] [mean,'Percentage who correctly answered comprehension questions: Three literal',f5.1]  + 
                       aInferential [s] [mean,'Percentage who correctly answered comprehension questions: Two inferential',f5.1] + 
                       readingSkill [s] [mean,'Percentage of children who demonstrate foundational reading skills',f5.1] + 
                       numChildren [s] [validn,'Number of children age 7-14 years',f5.0]) +
          tot [c] > (readCorrect [s] [mean,'Percentage who correctly read 90% of words in a story',f5.1] + 
                       aLiteral [s] [mean,'Percentage who correctly answered comprehension questions: Three literal',f5.1]  + 
                       aInferential [s] [mean,'Percentage who correctly answered comprehension questions: Two inferential',f5.1] + 
                       readingSkill [s] [mean,'Percentage of children who demonstrate foundational reading skills [1],[2],[3]',f5.1] + 
                       notAvailable [s] [mean,'Percentage of children for whom the reading book was not available in appropriate language',f5.1] + 
                       numChildren [s] [validn,'Number of children age 7-14 years',f5.0])
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Foundational Reading skills"																
    "Percentage of children aged 7-14 who demonstrate foundational reading skills by successfully completing three foundational reading tasks, by sex, " + "Sierra Leone MICS 2017".
	