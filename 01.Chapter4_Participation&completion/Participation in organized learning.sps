* Encoding: UTF-8.
*Open the dataset.
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra Leone\Syntax'.
get file = 'hl.sav'.

*Apply weight for the dataset. 
weight by hhweight.

*Customize the school entry age for primary. 
Compute primarySchoolEntryAge=6.
* Select children who are attending first grade of primary education regardless of age.
select if (schage = primarySchoolEntryAge - 1).

*Compute number of children aged one year before primary school.
compute numChildren = 1.
variable labels numChildren  "".
value labels numChildren 1 "Number of children age 5 years at the beginning of the school year".

*Compute children aged one year before primary entry age who are attending an early childhood education. 
compute ecd  = 0.
if (ED10a = 0) ecd =  100.
variable labels ecd "Percent of children: Attending an early childhood education programme".

*Compute children aged one year before primary entry age who are attending primary education. 
compute primary  = 0.
if (ED10a = 1) primary =  100.
variable labels primary "Percent of children: Attending primary education".

*Compute children who are attending either early childhood programme or attending primary school. 
compute attnd = 0.
if (ecd = 100 or primary = 100) attnd = 100.
variable labels attnd "Net attendance ratio".
	
compute layer = 0.
variable labels layer "".
value labels layer 0 "Percent of children:".

compute total = 1.
variable labels total "Total".
value labels total 1 " ".

EXECUTE.
* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variables =  numChildren
           display = none
  /table   total [c]
         + hl4 [c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + melevel [c]
         + disability [c]
         + ethnicity [c]
         + windex5 [c]
   by
           ecd [s] [mean,'',f5.1] + primary [s] [mean,'',f5.1]  + attnd [s] [mean,'',f5.1] + numChildren [c] [count,'',f5.0]
  /categories var=all empty=exclude missing=exclude
  /slabels position=column
  /titles title=
    "Participation rate in organised learning"					
    "Percent distribution of children age one year younger than the official primary school entry age at the beginning of the school year, " +
     "by attendance to education, and attendance to an early childhood education programme or primary education (adjusted net attendance ratio)" + "Sierra Leone MICS 2017"
   caption=
    "Participation rate in organised learning (adjusted); SDG indicator 4.2.2"
  .

new file.
