* Encoding: UTF-8.
* MICS6 TC-10.1.

 * Indicator 6.2 is calculated as: Engagement of household members age 15 or over in four or more activities (EC5 [A] to [F] = A, B or X).

 * Indicator 6.2, the mean number of activities in which household members engage with the child, and indicators 6.3 and 6.4 are calculated
   irrespective of the number of household members and whether mother or father are living in the household.

 * These denominators are established using data from the List of Household Members: HL12 and HL13, for mothers, and HL16 and HL17, for fathers.

 * The maximum number of activities with whom adult household members have engaged is 6, as asked in the under-5 questionnaire. The activities 
   include (EC5): (A) Reading books to or looking at picture books with the child, (B) Telling stories to the child, (C) Singing songs to or with the child, 
   including lullabies, (D) Taking the child outside the home, compound, yard, or enclosure, (E) Playing with the child, and (F) Naming, counting, or drawing things to or with the child. 

***.

cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.

* open household data file to get info regarding mother (hl14) and father (hl18) being in household.
get file = 'hl.sav'.

* sorting the data.
sort cases by hh1 hh2 hl1.

* creating temporary file.
save outfile = 'tmp.sav'
     /keep = hh1 hh2 hl1 hl14 hl18 felevel
     /rename = (hl1 = ln) .

* Open household members data file. 
get file = 'ch.sav'.
include "CommonVarsCH.sps".

sort cases by hh1 hh2 ln.

* merging the data .
match files
  /file = *
  /table = 'tmp.sav'
  /by hh1 hh2 ln.

* recode variables in order to calculate percentages.
recode hl14 (sysmis, 0 = 0) (else = 100).
recode hl18 (sysmis, 0 = 0) (else = 100).

variable labels hl14 'Mother' .
variable labels hl18 'Father' .

* Select completed under 5 questionnaires.
select if (UF17  = 1 and UB2>=2).
weight by chweight.

* calculation of the indicators.
* 1 MICS indicator TC.49a - Support for learning.
compute ind62sum = 
	((EC5AA='A') or (EC5AB='B') or (EC5AX='X')) +
	((EC5BA='A') or (EC5BB='B') or (EC5BX='X')) +
	((EC5CA='A') or (EC5CB='B') or (EC5CX='X')) +
	((EC5DA='A') or (EC5DB='B') or (EC5DX='X')) +
	((EC5EA='A') or (EC5EB='B') or (EC5EX='X')) +
	((EC5FA='A') or (EC5FB='B') or (EC5FX='X')) .

compute ind62 = (ind62sum >= 4) * 100 .

* 2 MICS Indicator TC.49b - Father's support for learning.
compute ind63sum = (EC5AB='B') +
                   (EC5BB='B') +
                   (EC5CB='B') +
                   (EC5DB='B') +
                   (EC5EB='B') +
                   (EC5FB='B') .

compute ind63 = (ind63sum >= 4) * 100 .

* 3 MICS Indicator TC.49c - Mother's support for learning.
compute ind64sum = (EC5AA='A') +
                   (EC5BA='A') +
                   (EC5CA='A') +
                   (EC5DA='A') +
                   (EC5EA='A') +
                   (EC5FA='A') .

compute ind64 = (ind64sum >= 4) * 100 .
compute none=0.
if ind62sum=0 none=100.
variable labels none "Percentage of children with whom no adult household member have engaged in any activity".

* labeling variables for table heading.
variable labels
  ind62  "Percentage of children with whom adult household members have engaged in four or more activities [1]"
 /ind62sum "Mean number of activities with adult household members"
 /ind63  "Percentage of children with whom biological fathers have engaged in four or more activities [2]"
 /ind63sum "Mean number of activities with biological fathers"
 /ind64  "Percentage of children with whom biological mothers have engaged in four or more activities [3]"
 /ind64sum "Mean number of activities with biological mothers".


* Select only children 36 to 59 months old.
 * select if (cage >= 36 and  cage <= 59).

* Weight the data by the children weight.

* Generating age groups.
 * recode  cage
  (36 thru 47 = 1)
  (48 thru 59 = 2) into ageGr.
 * variable labels ageGr 'Age of child'.
 * value labels ageGr
  1 '36-47 months'
  2 '48-59 months'.

* Generate total.
compute total = 1.
compute totchild = 1.
compute tot2 = 1.
compute tot3 = 1.
compute tot4 = 1.
*if (hl18>0) tot63 = 1 .
if (hl14>0) tot64 = 1 .
variable labels total " ".
value labels total 1 "Total".
value labels tot4 1 "Percentage of children living with their".

value labels totchild 1 "Number of children age 2-4 years".

value labels felevel
0 "Pre-primary or none"
1 "Primary"
2 "Lower secondary"
3 "Upper secondary"
5 "Father not in the household"
9 "Missing".

variable labels melevel " Mother's education [A]".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = tot2 tot3 tot4 tot64 total totchild display = none
  /table  total[c]
        + hl4 [c]
        + hh6 [c]
        + hh7 [c]
        + hh7a [c]
        + UB2 [c]
        + melevel [c]
        + felevel [c]
        + cdisability [c]
        + ethnicity [c]
        + windex5[c]
   by
          ind62  [s] [mean f5.1]
        + ind62sum [s] [mean f5.1]
        + none [s] [mean f5.1]
        + tot4[c] > ( 
           hl18 [s] [mean f5.1] + hl14 [s] [mean f5.1] )
        + totchild [c] [count f5.0]
        + ind63  [s] [mean f5.1]
        + ind63sum [s] [mean f5.1]
        + totchild [c] [count f5.0]
        + ind64  [s] [mean f5.1]
        + ind64sum [s] [mean f5.1]
        + totchild  [c] [count f5.0]
  /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /titles title=
    "Support for learning"
    "Percentage of children age 2-4 years with whom adult household members engaged in activities that promote learning and school "
    "readiness during the last three days, and engagement in such activities by fathers and mothers, " + "Sierra Leone MICS 2017"
   caption=
    "[1] MICS indicator TC.49a - Early stimulation and responsive care by any adult household member"
    "[2] MICS Indicator TC.49b - Early stimulation and responsive care by father"
    "[3] MICS Indicator TC.49c - Early stimulation and responsive care by mother"
    "[A] In this table and throughout the report, mother's education refers to educational attainment of mothers as well as caretakers of children under 5, "
    "who are the respondents to the under-5 questionnaire if the mother is deceased or is living elsewhere"											
    "na: not applicable"  .

new file.

erase file = 'tmp.sav'.