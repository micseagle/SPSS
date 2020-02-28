* Encoding: UTF-8.
***.
*Open datafile. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.
get file = 'hl.sav'.

*Apply the relevant weight. 
weight by hhweight.

* Select children who are of primary school age; this definition is
* country-specific and should be changed to reflect the situation in your
* country.

* include definition of primarySchoolEntryAge .

* Customize primary school entry age .
compute primarySchoolEntryAge = 6 .

* number of grades, years in primary school .
compute primarySchoolGrades = 6 .

* number of grades, years in lower secondary school .
compute LowSecSchoolGrades = 3 .

* number of grades, years in upper secondary school .
compute UpSecSchoolGrades = 4 .

*Calculate the completing age for primary. 
compute primarySchoolCompletionAge = primarySchoolEntryAge + primarySchoolGrades - 1 .

*Customize the entry age for lower secondary. 
compute LowSecSchoolEntryAge = primarySchoolEntryAge +  primarySchoolGrades.

*Customize the completing age for lower secondary. 
compute LowSecSchoolCompletionAge = LowSecSchoolEntryAge +  LowSecSchoolGrades -1 .

*Customize the entry age for upper secondary. 
compute UpSecSchoolEntryAge = primarySchoolEntryAge +  primarySchoolGrades + LowSecSchoolGrades.

*Customize the completing age for upper secondary. 
compute UpSecSchoolCompletionAge = UpSecSchoolEntryAge + UpSecSchoolGrades - 1 .


recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information [B]".

recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information [B]".


*The gross intake rate to the last grade of primary school (and similar for lower secondary school) is the ratio of the total number of students currently 
attending the last grade of primary school for the first time (i.e. who are not repeating the grade) to the total number of children of primary school completion age 
(age at the beginning of the school year appropriate for the last grade of primary school):
100 * (number of children attending the last grade of primary school - repeaters) / (number of children of primary school completion age at the beginning of the school year).
 * - Children attending the last grade of primary school are those with ED10A=1 and ED10B=last grade of primary.
 * - Repeaters are those in the last grade of primary in both ED10A/B and ED16A/B (ED10A=1 and ED10B=the last grade of primary and ED16A=1 and ED16B=the last grade of primary).
 * - The denominator is children whose age at the beginning of the school year is equal to the age corresponding to the last grade of primary school.

* Primary.
* number of repeaters.
compute repeatersP = 0.
if ((ED10A = 1 and ED10B = primarySchoolGrades)  and ED16A = ED10A and ED16B  = ED10B) repeatersP = 1.
* number of children in last primary grade.
compute inLastGradeP = 0.
if ((ED10A = 1 and ED10B = primarySchoolGrades) and repeatersP = 0) inLastGradeP  = 1.

* number of children o primary school completion age.
compute denominatorP = 0.
if (schage = primarySchoolCompletionAge) denominatorP  = 1.

* Lower secondary.
* number of repeaters.
compute repeatersLS = 0.
if ((ED10A = 2 and ED10B = LowSecSchoolGrades)  and ED16A = ED10A and ED16B  = ED10B) repeatersLS = 1.
* number of children in last low secondary grade.
compute inLastGradeLS = 0.
if ((ED10A = 2 and ED10B = LowSecSchoolGrades) and repeatersLS = 0) inLastGradeLS  = 1.

* number of children of  low secondary completion age.
compute denominatorLS = 0.
if (schage = LowSecSchoolCompletionAge) denominatorLS  = 1.

* Upper secondary.
compute repeatersUS = 0.
if ((ED10A = 3 and ED10B = UpSecSchoolCompletionAge)  and ED16A = ED10A and ED16B  = ED10B) repeatersUS = 1.
* number of children in last low secondary grade.
compute inLastGradeUS = 0.
if ((ED10A = 3 and ED10B = UpSecSchoolGrades) and repeatersUS = 0) inLastGradeUS  = 1.

* number of children of  low secondary completion age.
compute denominatorUS = 0.
if (schage = UpSecSchoolCompletionAge) denominatorUS  = 1.


compute total = 1.
variable labels total "".
value labels total 1 "Total".

aggregate outfile = 'tmp1.sav'
  /break    = total
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp2.sav'
  /break    = HL4
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp3.sav'
  /break    = HH7
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).

aggregate outfile = 'tmp9.sav'
  /break    = HH7a
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp4.sav'
  /break    = HH6
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp5.sav'
  /break    = melevel
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp6.sav'
  /break    = windex5
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).

aggregate outfile = 'tmp7.sav'
  /break    = ethnicity
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).


aggregate outfile = 'tmp8.sav'
  /break    = disability
  /inLastGradeP = sum(inLastGradeP)
  /denominatorP = sum(denominatorP)
  /inLastGradeLS = sum(inLastGradeLS)
  /denominatorLS = sum(denominatorLS)
  /inLastGradeUS = sum(inLastGradeUS)
  /denominatorUS = sum(denominatorUS).



get file = 'tmp1.sav'.
add files
  /file = *
  /file = 'tmp2.sav'
  /file = 'tmp3.sav'
  /file = 'tmp4.sav'
  /file = 'tmp5.sav'
  /file = 'tmp6.sav'
  /file = 'tmp7.sav'
  /file = 'tmp8.sav'
  /file = 'tmp9.sav'.

if (denominatorP > 0) primaryGross = (inLastGradeP / denominatorP)*100.
if (denominatorLS > 0) LowSecGross = (inLastGradeLS / denominatorLS)*100.
if (denominatorUS > 0) UpSecGross = (inLastGradeUS / denominatorUS)*100.

variable labels
  primaryGross            "Gross intake rate to the last grade of primary school"
  /LowSecGross            "Gross intake rate to the last grade of lower secondary school"
  /UpSecGross             "Gross intake rate to the last grade of upper secondary school".
 
* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = total
           display = none
  /table   total [c] 
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + melevel [c]
         + disability [c]
         + windex5 [c]
         + ethnicity [c]
   by
           primaryGross [s] [mean,'',f5.1]
         + LowSecGross [s] [mean,'',f5.1]
         + UpSecGross [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /titles title=
    "Gross intake"											
    "Gross intake rate for primary school, lower secondary and upper secondary " + "Sierra Leone, 2017".

new file.

* delete working files.
erase file = 'tmp1.sav'.
erase file = 'tmp2.sav'.
erase file = 'tmp3.sav'.
erase file = 'tmp4.sav'.
erase file = 'tmp5.sav'.
erase file = 'tmp6.sav'.
erase file = 'tmp7.sav'.
erase file = 'tmp8.sav'.
erase file = 'tmp9.sav'.


