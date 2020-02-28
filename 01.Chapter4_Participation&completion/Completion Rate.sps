* Encoding: UTF-8.
***.
*Open the dataset.This is an example with Sierra Leone MICS6. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
get file hl.sav. 

* Select children who are of primary school age; this definition is
* country-specific and should be changed to reflect the situation in your
* country.

*Compute primary entry age. 
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

*Apply weight to the dataset. 
weight by hhweight.

*Recode for mother's education level by treating system missing as "no information". 
recode melevel (sysmis = 5) (else = copy).
add value labels melevel 5 "No information [B]".

*Recode for disability level as "no information". 
recode disability (sysmis = 3) (else = copy).
variable labels disability "Mother's functional difficulties".
add value labels disability 3 "No information [B]".

* The primary completion rate (and similar for lower and upper secondary school) is percentage of children age 3-5 years above the intended age 
*for the last grade who completed the last grade of primary school. Primary school completion is calculated as:
*- ED5A=2, 3 or 4 OR (ED5A=1 and ED5B=the last grade of primary and ED6=1)
*- The appropriate age group (which should be customised in the table and syntax) is found by adding 3-5 years to the age corresponding to the last grade of primary school.

*Calculate children of primary completing age, which are 3 to 5 years above the intended age for the last grade who completed the last grade of primary school.
compute  totp= 0.
if (schage >= primarySchoolCompletionAge + 3 and schage <= primarySchoolCompletionAge + 5) totp = 1.

*Calculate primary completion age children who have completed primary or higher levels of education. 
compute completionP = 0.
if  totp = 1 and ((ED5A > 1 and ED5A < 8) or (ED5A=1 and ED5B = primarySchoolGrades and ED6=1)) completionP  = 1.

*Calculate boys of primary completing age, who are 3 to 5 years above the intended age for the last grade who completed the last grade of primary school.
compute  totpb= 0.
if (schage >= primarySchoolCompletionAge + 3 and schage <= primarySchoolCompletionAge + 5) and HL4=1 totpb = 1.

*Calculate primary completing age boys who have completed primary or higher levels of education. 
compute completionPb = 0.
if  totpb = 1 and ((ED5A > 1 and ED5A < 8) or (ED5A=1 and ED5B = primarySchoolGrades and ED6=1)) completionPb  = 1.

*Calculate girls of primary completing age, who are 3 to 5 years above the intended age for the last grade who completed the last grade of primary school.
compute  totpg= 0.
if (schage >= primarySchoolCompletionAge + 3 and schage <= primarySchoolCompletionAge + 5) and HL4=2 totpg = 1.

*Calculate primary completing age girls who have completed primary or higher levels of education. 
compute completionPg = 0.
if  totpg = 1 and ((ED5A > 1 and ED5A < 8) or (ED5A=1 and ED5B = primarySchoolGrades and ED6=1)) completionPg  = 1.


* Lower secondary.
*Calculate lower secondary completing age children, who are 3 to 5 years above the intended age for the last grade who completed the last grade of lower secondary school.
compute totls = 0.
if (schage >= LowSecSchoolCompletionAge + 3 and schage <= LowSecSchoolCompletionAge + 5) totls = 1.

*Calculate lower secondary completing age children who have completed lower secondary or higher levels of education. 
compute completionLS = 0.
if  totls = 1 and ((ED5A > 2 and ED5A < 8) or (ED5A=2 and ED5B = LowSecSchoolGrades and ED6=1)) completionLS  = 1.

*Calculate lower secondary completing age boys, who are 3 to 5 years above the intended age for the last grade who completed the last grade of lower secondary school.
compute totlsb = 0.
if (schage >= LowSecSchoolCompletionAge + 3 and schage <= LowSecSchoolCompletionAge + 5) and HL4=1 totlsb = 1.

*Calculate lower secondary completing age boys who have completed lower secondary or higher levels of education. 
compute completionLSb = 0.
if  totlsb = 1 and ((ED5A > 2 and ED5A < 8) or (ED5A=2 and ED5B = LowSecSchoolGrades and ED6=1)) completionLSb  = 1.

*Calculate lower secondary completing age girls, who are 3 to 5 years above the intended age for the last grade who completed the last grade of lower secondary school.
compute totlsg = 0.
if (schage >= LowSecSchoolCompletionAge + 3 and schage <= LowSecSchoolCompletionAge + 5) and HL4=2 totlsg = 1.

*Calculate lower secondary completing age girls who have completed lower secondary or higher levels of education. 
compute completionLSg = 0.
if  totlsg = 1 and ((ED5A > 2 and ED5A < 8) or (ED5A=2 and ED5B = LowSecSchoolGrades and ED6=1)) completionLSg  = 1.

* Upper secondary.
*Calculate upper secondary completing age children, who are 3 to 5 years above the intended age for the last grade who completed the last grade of upper secondary school.
compute totus = 0.
if (schage >= UpSecSchoolCompletionAge + 3 and schage <= UpSecSchoolCompletionAge + 5) totus = 1.

*Calculate upper secondary completing age children who have completed upper secondary or higher levels of education. 
compute completionUS = 0.
if  totus = 1 and ((ED5A > 3 and ED5A < 8) or (ED5A=3 and ED5B = UpSecSchoolGrades and ED6=1)) completionUS  = 1.

*Calculate upper secondary completing age boys  who are 3 to 5 years above the intended age for the last grade who completed the last grade of upper secondary school. 
compute totusb = 0.
if (schage >= UpSecSchoolCompletionAge + 3 and schage <= UpSecSchoolCompletionAge + 5) and HL4=1 totusb = 1.

*Calculate upper secondary completing age boys who have completed upper secondary or higher levels of education. 
compute completionUSb = 0.
if  totusb = 1 and ((ED5A > 3 and ED5A < 8) or (ED5A=3 and ED5B = UpSecSchoolGrades and ED6=1)) completionUSb  = 1.

*Calculate upper secondary completing age girls, who are 3 to 5 years above the intended age for the last grade who completed the last grade of upper secondary school.
compute totusg = 0.
if (schage >= UpSecSchoolCompletionAge + 3 and schage <= UpSecSchoolCompletionAge + 5) and HL4=2 totusg = 1.

*Calculate upper secondary completing age girls who have completed upper secondary or higher levels of education. 
compute completionUSg = 0.
if  totusg = 1 and ((ED5A > 3 and ED5A < 8) or (ED5A=3 and ED5B = UpSecSchoolGrades and ED6=1)) completionUSg  = 1.

 * Children attending lower secondary school who were in primary school the year before the survey are those with ED10A=2 and ED16A=1 and ED16B=last grade of primary. 
 * The denominator is children who were in the last grade of primary the previous year (ED16A Level=1 and ED16B Grade=last grade of primary).


compute total = 1.
variable labels total "".
value labels total 1 "Total".

aggregate outfile = 'tmp1.sav'
  /break    = total
  /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).

  
aggregate outfile = 'tmp2.sav'
  /break    = HL4
   /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).


aggregate outfile = 'tmp3.sav'
  /break    = HH6
  /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).


aggregate outfile = 'tmp4.sav'
  /break    = ethnicity
   /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).


aggregate outfile = 'tmp5.sav'
  /break    = HH7A
  /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).

aggregate outfile = 'tmp6.sav'
  /break    = HH6
    /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).


aggregate outfile = 'tmp7.sav'
  /break    = windex5
   /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).

aggregate outfile = 'tmp8.sav'
  /break    = disability
   /totp = sum(totp)
  /completionP = sum(completionP)
   /totpb = sum(totpb)
  /completionPb = sum(completionPb)
    /totpg = sum(totpg)
  /completionPg = sum(completionPg)
  /totls = sum(totls)
  /completionLS = sum(completionLS)
    /totlsb = sum(totlsb)
  /completionLSb = sum(completionLSb)
      /totlsg = sum(totlsg)
  /completionLSg = sum(completionLSg)
  /totus = sum(totus)
  /completionUS = sum(completionUS)
    /totusb = sum(totusb)
  /completionUSb= sum(completionUSb)
      /totusg = sum(totusg)
  /completionUSg = sum(completionUSg).


get file = 'tmp1.sav'.
add files
  /file = *
  /file = 'tmp2.sav'
  /file = 'tmp3.sav'
  /file = 'tmp4.sav'
  /file = 'tmp5.sav'
  /file = 'tmp6.sav'
  /file = 'tmp7.sav'
  /file = 'tmp8.sav'.


if (totp > 0) primarySchoolCompletionRate = (completionP / totp)*100.
if (totpb > 0) primarySchoolCompletionRateb = (completionPb / totpb)*100.
if (totpg > 0) primarySchoolCompletionRateg= (completionPg / totpg)*100.
if (totls > 0) LowSecCompletionRate = (completionLS / totls)*100.
if (totlsb > 0) LowSecCompletionRateb = (completionLSb / totlsb)*100.
if (totlsg > 0) LowSecCompletionRateg = (completionLSg / totlsg)*100.
if (totus > 0) UpSecCompletionRate = (completionUS / totus)*100.
if (totusb > 0) UpSecCompletionRateb = (completionUSb / totusb)*100.
if (totusg > 0) UpSecCompletionRateg = (completionUSg / totusg)*100.


variable labels
   primarySchoolCompletionRate "Primary completion rate"
  /primarySchoolCompletionRateb "Primary completion rate, boys"
    /primarySchoolCompletionRateg "Primary completion rate, girls"
  /LowSecCompletionRate "Lower secondary completion rate"
  /LowSecCompletionRateg "Lower secondary completion rate, girls"
    /LowSecCompletionRateb "Lower secondary completion rate, boys"
  /UpSecCompletionRate "Upper secondary completion rate"
    /UpSecCompletionRateb "Upper secondary completion rate, boys"
      /UpSecCompletionRateg "Upper secondary completion rate, girls". 

  
ctables
  /vlabels variables = total
           display = none
  /table   total [c] 
         + hl4 [c]
         +hh6 [c]
         + windex5 [c]
         + hh7a [c]
         + ethnicity [c]
   by
         primarySchoolCompletionRate [s] [mean,'',f5.1]
         + LowSecCompletionRate [s] [mean,'',f5.1]
         + UpSecCompletionRate [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels visible=no
  /titles title=
    "Completion rates for primary, lower secondary and upper secondary" + "Sierra Leone MICS 2017".


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


