* Encoding: UTF-8.
*Open dataset. Literacy rate are calculated seperated using men and women's questionaire. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.

get file = 'mn.sav'.
** Respondents are distributed according to the highest level of school attended (MWB6U) and further by the results of reading a short simple statement about everyday life (MWB14).

** Those who attended secondary or higher education (MWB6U=2, 3 or 4) are classified as literate, as they are assumed literate due to their education level and are therefore not asked to read the statement. 
** All others who successfully read the statement (MWB14=3) are also classified as literate. 

** The percent missing includes those for whom no sentence in the required language was available (MWB14=6) or for whom no response was reported. 
** If exceeding 10 percent in any category, caution should be exercised in the interpretation of the results. Additionally, a low response rate may be observed among certain age groups. 
** Particularly, if the response rate of age group 15-24 years is below 95 percent, the data obtained through the Education module should be examined. 
** In some countries, low response rates for this age group is due to boarding at secondary or higher education, in which case a large number of lost respondents would have been classified as literate had they been interviewed.


***.
select if (MWM17 = 1).

weight by mnweight.

*Select the youth age group 15-24. 
Select if mwb4>=15 and mwb4<=24. 


*** Those who attended secondary or higher education (WB6A=2, 3 or 4) are classified as literate, as they are assumed literate due to their education level and are therefore not asked to read the statement. 
** All others who successfully read the statement (WB14=3) are also classified as literate.
compute literate  = 2.
if (MWB6A >= 2 and MWB6A < 8) literate = 1. 
if (MWB14 = 3) literate = 1.
variable labels literate " ".
value labels literate 1 "Literate" 2 "Illiterate".

compute literateP = 0.
if (literate = 1) literateP = 100. 
variable labels literateP "Total percentage literate".

compute layer = 0.
variable labels layer " ".
value labels layer 0 "Percent distribution of highest level attended and literacy".

* add education label.
add value labels mwelevel 3 "Secondary or higher".


compute total = 1.
variable labels total "Total".
value labels total 1 " ".

compute tot = 100.
variable labels tot "Total".
value labels tot 100 " ".

* Ctables command in English (currently active, comment it out if using different language).
ctables
  /vlabels variable =  literate display = none
  /table   total[c]
         + hh6 [c]
         + hh7 [c]
         + hh7a [c]
         + mdisability [c]
         + ethnicity[c]
         + windex5 [c]
   by
           literateP [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
    "Literacy (men)"
    "Percent distribution of men age 15-24 years by highest level of school attended and literacy, and the total percentage literate, " + "Sierra Leone 2017" .

new file.
