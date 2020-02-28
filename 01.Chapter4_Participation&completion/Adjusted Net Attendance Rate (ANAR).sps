* Encoding: UTF-8.
*Open the dataset.
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
get file hl.sav.

* Select children who are of primary school age, lower secondary or upper secondary age; this definition is country-specific and should be changed to reflect the situation in your country.

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


*Apply weight. 
weight by hhweight.

compute total = 1.
variable labels total "".
value labels total 1 "Total".


recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information [B]".

recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information [B]".




*Calculate the number of primary age children. 
compute TotalAgedForPrimary = 0.
if (schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge) TotalAgedForPrimary = 1.
variable labels TotalAgedForPrimary "Number of primary school age children".

**Calculate the number of primary age children who are attending prmary or secondary. 
compute TotalAttendingPrimary = 0.
if (TotalAgedForPrimary = 1 and ED9 = 1 and ED10A >=1 and ED10A <=2) TotalAttendingPrimary = 1.
variable labels TotalAttendingPrimary "Number of primary school age children attending primary school".

*Calculate the number of primary age boys. 
compute maleAgedForPrimary = 0.
if (HL4 = 1 and schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge ) maleAgedForPrimary = 1.
variable labels maleAgedForPrimary "Number of primary school age male".

*Calculate the number of primary age boys who are attending prmary or secondary.  
compute maleAttendingPrimary = 0.
if (maleAgedForPrimary = 1 and  ED9 = 1 and ED10A >=1 and ED10A <=2) maleAttendingPrimary = 1.
variable labels maleAttendingPrimary "Number of primary school age male attending primary school or higher".

*Calculate the number of primary age girls. 
compute femaleAgedForPrimary = 0.
if (HL4 = 2 and schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge) femaleAgedForPrimary = 1.
variable labels femaleAgedForPrimary "Number of primary school age female".

*Calculate the number of primary age girls who are attending prmary or secondary.  
compute femaleAttendingPrimary = 0.
if (femaleAgedForPrimary = 1 and ED9 = 1 and ED10A >=1 and ED10A <=2) femaleAttendingPrimary = 1.
variable labels femaleAttendingPrimary "Number of primary school age female attending primary school or higher".

*Calculate the number of lower secondary school age children. 
compute TotalAgedForLowerSecondary = 0.
if (schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) TotalAgedForLowerSecondary = 1.
variable labels TotalAgedForLowerSecondary "Number of lower secondary school age adolescent".

*Calculate the number of lower secondary school age children who are attending lower secondary or higher. 
compute TotalAttendingLowerSecondary = 0.
if TotalAgedForLowerSecondary = 1 and ED9 = 1 and ED10A>= 2 and ED10A<=3 TotalAttendingLowerSecondary = 1.
variable labels TotalAttendingLowerSecondary "Number of lower secondary school age adolescents attending lower secondary or higher".

*Calculate the number of lower secondary school age boys. 
compute maleAgedForLowerSecondary = 0.
if (HL4 = 1 and schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) maleAgedForLowerSecondary = 1.
variable labels maleAgedForLowerSecondary "Number of lower secondary school age male".

*Calculate the number of lower secondary school age boys who are attending lower secondary or higher. 
compute maleAttendingLowerSecondary = 0.
if maleAgedForLowerSecondary = 1 and ED9 = 1 and ED10A>= 2 and ED10A<=3  maleAttendingLowerSecondary = 1.
variable labels maleAttendingLowerSecondary "Number of lower secondary school age adolescent attending lower secondary school or higher,male".

*Calculate the number of lower secondary school age girls.
compute femaleAgedForLowerSecondary = 0.
if (HL4 = 2 and schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) femaleAgedForLowerSecondary = 1.
variable labels femaleAgedForLowerSecondary "Number of lower secondary school age female".

*Calculate the number of lower secondary school age girls who are attending lower secondary or higher. 
compute femaleAttendingLowerSecondary  = 0.
if femaleAgedForLowerSecondary = 1 and ED9 = 1 and ED10A>=2 and ED10A<=3  femaleAttendingLowerSecondary =  1.
variable labels femaleAttendingLowerSecondary "Number of lower secondary school age adolescent attending lower secondary school or higher, female".

*Calculate the number of upper secondary school age adolescents.
compute TotalAgedForUpperSecondary = 0.
if (schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) TotalAgedForUpperSecondary = 1.
variable labels TotalAgedForUpperSecondary  "Number of upper secondary school age adolescent".

*Calculate the number of upper secondary school age adolescent who are attending upper secondary or higher. 
compute TotalAttendingUpperSecondary = 0.
if TotalAgedForUpperSecondary = 1 and ED9= 1 and ED10A>=3 and ED10A<=5 TotalAttendingUpperSecondary = 1.
variable labels TotalAttendingUpperSecondary "Number of upper secondary school age children adolescents attending upper secondary or higher".

*Calculate the number of upper secondary school age adolescent boys.  
compute maleAgedForUpperSecondary = 0.
if (HL4 = 1 and schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) maleAgedForUpperSecondary = 1.
variable labels maleAgedForUpperSecondary "Number of upper secondary school age, male".

*Calculate the number of upper secondary school age adolescent boys who are attending upper secondary or higher. 
compute maleAttendingUpperSecondary = 0.
if maleAgedForUpperSecondary = 1 and ED9 = 1 and ED10A>=3 and ED10A<=5 maleAttendingUpperSecondary = 1.
variable labels maleAttendingUpperSecondary "Number of upper secondary school age adolescent attending upper secondary school or higher, male".

*Calculate the number of upper secondary school age adolescent girls.  
compute femaleAgedForUpperSecondary = 0.
if (HL4 = 2 and schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) femaleAgedForUpperSecondary = 1.
variable labels femaleAgedForUpperSecondary "Number of upper secondary school age adolescent, female".

*Calculate the number of upper secondary school age adolescent girls who are attending upper secondary or higher. 
compute femaleAttendingUpperSecondary  = 0.
if femaleAgedForUpperSecondary = 1 and ED9 = 1 and ED10A>=3 and ED10A<=5 femaleAttendingUpperSecondary =  1.
variable labels femaleAttendingUpperSecondary "Number of upper secondary school age adolescent attending upper secondary school or higher, female".

aggregate outfile = 'tmp1.sav'
  /break  = total
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp2.sav'
  /break   = HL4
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp3.sav'
  /break   = HH7
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp4.sav'
  /break   = HH6
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp5.sav'
  /break   = HH7A
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp6.sav'
  /break   = melevel
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

aggregate outfile = 'tmp7.sav'
  /break   = windex5
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /TotalAttendingPrimary =sum(TotalAttendingPrimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /maleAttendingPrimary    = sum(maleAttendingPrimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /femaleAttendingPrimary   = sum(femaleAttendingPrimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /TotalAttendingLowerSecondary =sum(TotalAttendingLowerSecondary)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /maleAttendingLowerSecondary  = sum(maleAttendingLowerSecondary)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /femaleAttendingLowerSecondary =sum(femaleAttendingLowerSecondary)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /TotalAttendingUpperSecondary =sum(TotalAttendingUpperSecondary)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /maleAttendingUpperSecondary=sum(maleAttendingUpperSecondary)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /femaleAttendingUpperSecondary = sum(femaleAttendingUpperSecondary).

get file = 'tmp1.sav'.
add files
  /file = *
  /file = 'tmp2.sav'
  /file = 'tmp3.sav'
  /file = 'tmp4.sav'
  /file = 'tmp5.sav'
  /file = 'tmp6.sav'
  /file = 'tmp7.sav'.

EXECUTE.

if (TotalAgedForPrimary > 0) ptot = (TotalAttendingPrimary / TotalAgedForPrimary) * 100.
variable labels ptot "Primary school adjusted net attendance rate (NAR), total".

if (femaleAgedForPrimary > 0) pfemale = (femaleAttendingPrimary / femaleAgedForPrimary) * 100.
variable labels pfemale "Primary school adjusted net attendance rate (NAR), female".

if (maleAgedForPrimary > 0)  pmale  = (maleAttendingPrimary / maleAgedForPrimary) * 100.
variable labels pmale "Primary school adjusted net attendance rate (NAR), male".

if (pmale > 0) primaryGPI = (pfemale/pmale).
variable labels primaryGPI "Gender parity index (GPI) for primary school adjusted NAR [1]".

if (TotalAgedForLowerSecondary > 0)  lstot = (TotalAttendingLowerSecondary / TotalAgedForLowerSecondary) * 100.
variable labels lstot "lower secondary adjusted net attendance rate (NAR), total".

if (femaleAgedForLowerSecondary > 0)  lsfemale = (femaleAttendingLowerSecondary / femaleAgedForLowerSecondary) * 100.
variable labels lsfemale "Lower Secondary school adjusted net attendance rate (NAR), female".

if (maleAgedForLowerSecondary > 0)  lsmale  = (maleAttendingLowerSecondary / maleAgedForLowerSecondary) * 100.
variable labels lsmale "Lower Secondary school adjusted net attendance rate (NAR), male".

if (lsmale > 0) lsecondaryGPI = (lsfemale/lsmale).
variable labels lsecondaryGPI "Gender parity index (GPI) for lower secondary school adjusted NAR [2]".

if (TotalAgedForUpperSecondary > 0) ustot = (TotalAttendingUpperSecondary / TotalAgedForUpperSecondary) * 100.
variable labels ustot "upper secondary adjusted net attendance rate (NAR), total".

if (femaleAgedForUpperSecondary > 0) usfemale = (femaleAttendingUpperSecondary / femaleAgedForUpperSecondary) * 100.
variable labels usfemale "Upper Secondary school adjusted net attendance rate (NAR), female".

if (maleAgedForUpperSecondary > 0)  usmale  = (maleAttendingUpperSecondary / maleAgedForUpperSecondary) * 100.
variable labels usmale "Upper Secondary school adjusted net attendance rate (NAR), male".

if (usmale > 0) usecondaryGPI = (usfemale/usmale).
variable labels usecondaryGPI "Gender parity index (GPI) for upper secondary school adjusted NAR [2]".


* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = total
           display = none
  /table   total [c]
         + hh6[c]
         + hh7[c]
         + hh7a[c]
         + melevel [c]
         + windex5 [c]
  by
           pfemale [s] [mean,'',f5.1]
         + pmale [s] [mean,'',f5.1]
         + ptot [s] [mean,'',f5.1]
         + primaryGPI [s] [mean,'',f5.2]
         + lsfemale [s] [mean,'',f5.1]
         + lsmale [s] [mean,'',f5.1]
         + lstot [s] [mean,'',f5.1]
         + lsecondaryGPI [s] [mean,'',f5.2]
         + usfemale [s] [mean,'',f5.1]
         + usmale [s] [mean,'',f5.1]
         + ustot [s] [mean,'',f5.1]
         + usecondaryGPI [s] [mean,'',f5.2]
  /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /title title=
    "Adjusted net attendance rate at primary, lower secondary and upper secondary school age"   +   "Sierra Leone 2017". 
  .














