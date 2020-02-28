* Encoding: UTF-8.

*Open the dataset.
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
get file hl.sav.
 
* Select children who are of primary school age; this definition is
* country-specific and should be changed to reflect the situation in your
* country.

* include definition of primarySchoolEntryAge .

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

*Apply for relevant weight to the dataset. 
weight by hhweight.

*Clean the mother's education level variable. 
recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information [B]".

*Clean the disability varibale. 
recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information [B]".

compute total = 1.
variable labels total "".
value labels total 1 "Total".

*Number of primary school age children. 
compute TotalAgedForPrimary = 0.
if (schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge) TotalAgedForPrimary = 1.
variable labels TotalAgedForPrimary "Number of primary school age children".

*Number of primary age children who are not attending preschool or primary. 
compute OOSprimary = 0.
if TotalAgedForPrimary = 1 and (ED9 = 2 or ED4=2) OOSprimary = 1.
if (TotalAgedForPrimary = 1 and ED10A=0) OOSprimary  = 0.
variable labels OOSprimary "Number of primary school age children not attending preschool or primary school".


*Number of primary school age boys.
compute maleAgedForPrimary = 0.
if (HL4 = 1 and schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge ) maleAgedForPrimary = 1.
variable labels maleAgedForPrimary "Number of primary school age male".

*Number of primary age boys who are not attending preschool or primary. 
compute MaleOOSprimary = 0.
if maleAgedForPrimary = 1 and  (ED9 = 2 or ED4=2) MaleOOSprimary = 1.
if (maleAgedForPrimary = 1 and ED10A=0) MaleOOSprimary  = 0.
variable labels MaleOOSprimary "Number of primary school age male not attending primary school or higher".

*Number of primary school age girls.
compute femaleAgedForPrimary = 0.
if (HL4 = 2 and schage >= primarySchoolEntryAge and schage <= primarySchoolCompletionAge) femaleAgedForPrimary = 1.
variable labels femaleAgedForPrimary "Number of primary school age female".

*Number of primary age girls who are not attending preschool or primary. 
compute FemaleOOSprimary = 0.
if femaleAgedForPrimary = 1 and (ED9 = 2 or ED4=2) FemaleOOSprimary = 1.
if (FemaleOOSprimary = 1 and ED10A=0) FemaleOOSprimary  = 0.
variable labels FemaleOOSprimary "Number of primary school age female not attending primary school or higher".

*Number of lower secondary school age children.
compute TotalAgedForLowerSecondary = 0.
if (schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) TotalAgedForLowerSecondary = 1.
variable labels TotalAgedForLowerSecondary "Number of lower secondary school age adolescent".

*Number of lower secondary school age children who are not in preprimary, primary, secondary or higher. 
compute OOSLowSec = 0.
if TotalAgedForLowerSecondary = 1 and (ED9 = 2 or ED4=2) OOSLowSec = 1.
if (TotalAgedForLowerSecondary = 1 and ED10A=0) OOSLowSec  = 0.
variable labels OOSLowSec "Number of lower secondary school age adolescents not attending lower secondary or higher".

*Number of lower secondary school age boys.
compute maleAgedForLowerSecondary = 0.
if (HL4 = 1 and schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) maleAgedForLowerSecondary = 1.
variable labels maleAgedForLowerSecondary "Number of lower secondary school age male".

*Number of lower secondary school age boys who are not in preprimary, primary, secondary or higher. 
compute MaleOOSLowSec = 0.
if maleAgedForLowerSecondary = 1 and (ED9 = 2 or ED4=2) MaleOOSLowSec = 1.
if (maleAgedForLowerSecondary = 1 and ED10A=0) MaleOOSLowSec  = 0.
variable labels MaleOOSLowSec "Number of lower secondary school age adolescent attending lower secondary school or higher,male".

*Number of lower secondary school age girls.
compute femaleAgedForLowerSecondary = 0.
if (HL4 = 2 and schage >= LowSecSchoolEntryAge and schage <= LowSecSchoolCompletionAge) femaleAgedForLowerSecondary = 1.
variable labels femaleAgedForLowerSecondary "Number of lower secondary school age female".

*Number of lower secondary school age girls who are not in preprimary, primary, secondary or higher. 
compute FemaleOOSLowSec  = 0.
if femaleAgedForLowerSecondary = 1 and  (ED9 = 2 or ED4=2)  FemaleOOSLowSec =  1.
if (femaleAgedForLowerSecondary = 1 and ED10A=0) FemaleOOSLowSec  = 0.
variable labels FemaleOOSLowSec "Number of lower secondary school age adolescent attending lower secondary school or higher, female".

*Number of upper secondary school age children.
compute TotalAgedForUpperSecondary = 0.
if (schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) TotalAgedForUpperSecondary = 1.
variable labels TotalAgedForUpperSecondary  "Number of upper secondary school age adolescent".

*Number of upper secondary school age children who are not in preprimary, primary, secondary or higher. 
compute OOSUppSec = 0.
if TotalAgedForUpperSecondary = 1 and (ED9 = 2 or ED4=2) OOSUppSec = 1.
if (TotalAgedForUpperSecondary = 1 and ED10A=0) OOSUppSec  = 0.
variable labels OOSUppSec "Number of upper secondary school age children adolescents not attending upper secondary or higher".

*Number of upper secondary school age boys.
compute maleAgedForUpperSecondary = 0.
if (HL4 = 1 and schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) maleAgedForUpperSecondary = 1.
variable labels maleAgedForUpperSecondary "Number of upper secondary school age, male".

*Number of upper secondary school age boys who are not in preprimary, primary, secondary or higher. 
compute MaleOOSUppSec = 0.
if maleAgedForUpperSecondary = 1 and (ED9 = 2 or ED4=2) MaleOOSUppSec = 1.
if (maleAgedForUpperSecondary = 1 and ED10A=0) MaleOOSUppSec  = 0.
variable labels MaleOOSUppSec "Number of upper secondary school age adolescent not attending upper secondary school or higher, male".

*Number of upper secondary school age girls.
compute femaleAgedForUpperSecondary = 0.
if (HL4 = 2 and schage >= UpSecSchoolEntryAge and schage <= UpSecSchoolCompletionAge) femaleAgedForUpperSecondary = 1.
variable labels femaleAgedForUpperSecondary "Number of upper secondary school age adolescent, female".

*Number of upper secondary school age girls who are not in preprimary, primary, secondary or higher. 
compute FemaleOOSuppSec  = 0.
if femaleAgedForUpperSecondary = 1 and (ED9 = 2 or ED4=2) FemaleOOSuppSec =  1.
if (femaleAgedForUpperSecondary = 1 and ED10A=0) FemaleOOSuppSec  = 0.
variable labels FemaleOOSuppSec "Number of upper secondary school age adolescent not attending upper secondary school or higher, female".

aggregate outfile = 'tmp1.sav'
  /break  = total
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp2.sav'
  /break   = HL4
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp3.sav'
  /break   = ethnicity
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp4.sav'
  /break   = HH6
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp5.sav'
  /break   = HH7A
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp6.sav'
  /break   = melevel
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

aggregate outfile = 'tmp7.sav'
  /break   = windex5
  /TotalAgedForPrimary    =sum(TotalAgedForPrimary)
  /OOSprimary =sum(OOSprimary)
  /maleAgedForPrimary      = sum(maleAgedForPrimary)
  /MaleOOSprimary    = sum(MaleOOSprimary)
  /femaleAgedForPrimary     = sum(femaleAgedForPrimary)
  /FemaleOOSprimary   = sum(FemaleOOSprimary)
   /TotalAgedForLowerSecondary = sum (TotalAgedForLowerSecondary)
   /OOSLowSec =sum(OOSLowSec)
  /maleAgedForLowerSecondary    = sum(maleAgedForLowerSecondary)
  /MaleOOSLowSec  = sum(MaleOOSLowSec)
  /femaleAgedForLowerSecondary = sum(femaleAgedForLowerSecondary)
    /FemaleOOSLowSec =sum(FemaleOOSLowSec)
   /TotalAgedForUpperSecondary =sum(TotalAgedForUpperSecondary)
   /OOSUppSec =sum(OOSUppSec)
   /maleAgedForUpperSecondary=sum(maleAgedForUpperSecondary)
   /MaleOOSUppSec=sum(MaleOOSUppSec)
  /femaleAgedForUpperSecondary   = sum(femaleAgedForUpperSecondary)
  /FemaleOOSuppSec = sum(FemaleOOSuppSec).

get file = 'tmp1.sav'.
add files
  /file = *
  /file = 'tmp2.sav'
  /file = 'tmp3.sav'
  /file = 'tmp4.sav'
  /file = 'tmp5.sav'
  /file = 'tmp6.sav'
  /file = 'tmp7.sav'.

*Calculate for out of school rate for primary school age children. 
if (TotalAgedForPrimary > 0) prioos = (OOSprimary / TotalAgedForPrimary) * 100.
variable labels prioos "Primary school out of school children rate, total".

*Calculate for out of school rate for primary school age girls. 
if (femaleAgedForPrimary > 0) prioosfemale = (FemaleOOSprimary / femaleAgedForPrimary) * 100.
variable labels prioosfemale "Primary school out of school children rate, female".

*Calculate for out of school rate for primary school age boys. 
if (maleAgedForPrimary > 0)  prioosmale  = (MaleOOSprimary / maleAgedForPrimary) * 100.
variable labels prioosmale "Primary school adjusted net attendance rate (NAR), male".

*Calculate for out of school rate for lower secondary school age children. 
if (TotalAgedForLowerSecondary > 0)  lseoos = (OOSLowSec / TotalAgedForLowerSecondary) * 100.
variable labels lseoos "lower secondary out of school children rate, total".

*Calculate for out of school rate for lower secondary school age girls. 
if (femaleAgedForLowerSecondary > 0)  lsecoosfemale = (FemaleOOSLowSec / femaleAgedForLowerSecondary) * 100.
variable labels lsecoosfemale "Lower Secondary out of school children rate, female".

*Calculate for out of school rate for lower secondary school age boys. 
if (maleAgedForLowerSecondary > 0)  lsecoosmale  = (MaleOOSLowSec / maleAgedForLowerSecondary) * 100.
variable labels lsecoosmale "Lower Secondary school out of school rate, male".

*Calculate for out of school rate for upper secondary school age children. 
if (TotalAgedForUpperSecondary > 0) usoos = (OOSUppSec / TotalAgedForUpperSecondary) * 100.
variable labels usoos "upper secondary out of school children rate".

*Calculate for out of school rate for upper secondary school age girls. 
if (femaleAgedForUpperSecondary > 0) usoosfemale = (FemaleOOSuppSec / femaleAgedForUpperSecondary) * 100.
variable labels usoosfemale "Upper Secondary school out of school children rate, female".

*Calculate for out of school rate for upper secondary school age boys. 
if (maleAgedForUpperSecondary > 0)  usoosmale  = (MaleOOSUppSec / maleAgedForUpperSecondary) * 100.
variable labels usoosmale "Upper Secondary school out of school children rate, male".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables = total
           display = none
  /table   total [c]
          +hl4[c]
         + windex5 [c]
         + hh6[c]
         + hh7a[c]
         + ethnicity [c]
  by
           prioos [s] [mean,'',f5.1]
         + lseoos [s] [mean,'',f5.1]
         + usoos [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /title title=
    "Out of school chidlren rates primary, lower secondray and upper secondary" +   "Sierra Leone 2017". 
  .















