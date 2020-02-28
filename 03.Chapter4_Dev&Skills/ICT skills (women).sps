* Encoding: UTF-8.
*Open the dataset and ICT skills for men and female are calculated from different modules, which are women's questionaire and men's questionaire. 
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.

* Open women dataset.
get file = 'wm.sav'.

** This table shows the results of the 9 individual ICT skills asked in HC10. The last column is computed as at least one yes to any of the 9 skills. The table is based on the full denominator of all women age 15-49.

* Select completed interviews.
select if (WM17 = 1).

* Weight the data by the women weight.
weight by wmweight.

*Select the youth age group, 15-24 years. 
Select if WB4>=15 and WB4<=24. 


* Generate indicators for different type of ICT skills. 
recode MT6A (1 = 100) (else = 0) into copied.
variable labels copied "Copied or moved a file or folder".

recode MT6B (1 = 100) (else = 0) into filecopy.
variable labels filecopy "Used a copy and paste tool to duplicate or  move information within a document".

recode MT6C (1 = 100) (else = 0) into email.
variable labels email "Sent e-mail with attached file, such as a  document, picture or video".

recode MT6D (1 = 100) (else = 0) into formula.
variable labels formula "Used a basic arithmetic formula in a spreadsheet".

recode MT6E (1 = 100) (else = 0) into install.
variable labels install "Connected and installed a new device, such as a modem, camera or printer".

recode MT6F (1 = 100) (else = 0) into software.
variable labels software "Found, downloaded, installed and configured software".

recode MT6G (1 = 100) (else = 0) into presentation.
variable labels presentation "Created an electronic presentation with presentation software, including text, images, sound, video or charts".

recode MT6H (1 = 100) (else = 0) into transfer.
variable labels transfer "Transfered a file between a computer and other device".

recode MT6I (1 = 100) (else = 0) into code.
variable labels code "Wrote a computer program in any programming language".

*Compute the indicator for performing at least one computer related activity. 
compute atLeastOne = 0.
if (copied = 100 or filecopy = 100 or email = 100 or formula = 100 or install = 100 or software = 100 or presentation = 100 or transfer = 100 or code = 100) atLeastOne = 100.
variable labels atLeastOne "Performed at least one of the nine listed computer related activities".

compute total = 1.
variable labels total "".
value labels total 1 "Total".

ctables
  /vlabels variables = total
         display = none
  /table   total [c]
        + hh6 [c]
        + hh7 [c]
        + hh7a [c]
        + welevel [c]
        + disability [c]
        + ethnicity [c]
        + windex5 [c]
      by
          atLeastOne [s] [mean,'',f5.1] 
  /categories var=all empty=exclude missing=exclude
  /slabels position=column visible = no
  /titles title=
     "ICT skills (women)"
     "Percentage of women age 15-24 years who in the last 3 months have carried out computer related activities, " 
     + "Sierra Leone 2017" 
.								

new file.
