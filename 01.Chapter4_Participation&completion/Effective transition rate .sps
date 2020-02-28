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


* Primary.
* number of repeaters.
compute repeatersP = 0.
if ((ED10A = 1 and ED10B = primarySchoolGrades)  and ED16A = ED10A and ED16B  = ED10B) repeatersP = 1.


 * Children attending lower secondary school who were in primary school the year before the survey are those with ED10A=2 and ED16A=1 and ED16B=last grade of primary. 
 * The denominator is children who were in the last grade of primary the previous year (ED16A Level=1 and ED16B Grade=last grade of primary).

 * The effective transition rate is:
100 * (number of children in the first grade of lower secondary school who were in the last grade of primary school the previous year) 
/ (number of children in the last grade of primary school the previous year who are not repeating the last grade of primary school in the current year) or in the form of the algorithm:
- (ED10A=2 and ED10B=1 and ED16A=1 and ED16B=the last grade of primary) / (ED16A=1 and ED16B=the last grade of primary <> (ED10A=1 and ED10B=the last grade of primary))


* number of children in first secondary grade who were in primary last year.
compute inLowSecondary1 = 0.
if (ED10A = 2 and ED10B=1 and ED16A = 1 and ED16B = primarySchoolGrades) inLowSecondary1  = 1.

compute inPrimaryLast = 0.
if (ED16A = 1 and ED16B = primarySchoolGrades) inPrimaryLast = 1.


compute total = 1.
variable labels total "".
value labels total 1 "Total".

aggregate outfile = 'tmp1.sav'
  /break    = total
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).

aggregate outfile = 'tmp2.sav'
  /break    = HL4
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp3.sav'
  /break    = HH7
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp9.sav'
  /break    = HH7a
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).

aggregate outfile = 'tmp4.sav'
  /break    = HH6
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp5.sav'
  /break    = melevel
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp6.sav'
  /break    = windex5
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp7.sav'
  /break    = ethnicity
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).


aggregate outfile = 'tmp8.sav'
  /break    = disability
  /repeatersP = sum(repeatersP)
 /inLowSecondary1 = sum(inLowSecondary1)
  /inPrimaryLast = sum(inPrimaryLast).



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


if (inPrimaryLast > 0) transitionRateToSecondary = (inLowSecondary1 / inPrimaryLast)*100.

compute adjInLastPrimaryGrade = inPrimaryLast - repeatersP .

if (adjInLastPrimaryGrade > 0) effectiveTransitionRateToSecondary = (inLowSecondary1 / adjInLastPrimaryGrade)*100.

variable labels effectiveTransitionRateToSecondary "Effective transition rate to secondary school".
variable labels adjInLastPrimaryGrade  "Number of children who were in the last grade of primary school the previous year and are not repeating that grade in the current school year".


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
          effectiveTransitionRateToSecondary [s] [mean,'',f5.1]
         + adjInLastPrimaryGrade [s] [sum,'',f5.0] 
         /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /titles title=
    "Effective transition rates"											
    "Effective transition rate to secondary school" + "Sierra Leone 2017"
  .


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

