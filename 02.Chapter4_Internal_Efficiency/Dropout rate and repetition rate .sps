* Encoding: UTF-8.
***.
cd 'C:\Users\xinyu\OneDrive - UNICEF\Education\3. MICS-EAGLE\Country report\Sierra '+
    'Leone\Syntax'.

get file hl.sav.
*weight by hhweight. 

* Select children who are of primary school age; this definition is
* country-specific and should be changed to reflect the situation in your
* country.

compute total = 1.
variable labels total " ".
value labels total 1 "Total".


* Variable 'droppedX'   represents the number of children in X'th grade last year who are not in school this year .
* Variable 'graduatedX' represents the number of children in X'th grade last year who are in (X+1)'th grade this year .
* value in these variables is binary ie logical value of 0/1 deppending if logical condition is false/true .

compute dropped1   = (ED16A = 1 and ED16B = 1 and ED9 <> 1) .
compute graduated1 = (ED16A = 1 and ED16B = 1 and ED10A = 1 and ED10B = 2) .
compute repeated1 = (ED16A = 1 and ED16B = 1 and ED10A = 1 and ED10B = 1).

compute dropped2   = (ED16A = 1 and ED16B = 2 and ED9 <> 1).
compute graduated2 = (ED16A = 1 and ED16B = 2 and ED10A = 1 and ED10B = 3).
compute repeated2 = (ED16A = 1 and ED16B = 2 and ED10A = 1 and ED10B = 2).

compute dropped3   = (ED16A = 1 and ED16B = 3 and ED9 <> 1).
compute graduated3 = (ED16A = 1 and ED16B = 3 and ED10A = 1 and ED10B = 4).
compute repeated3 = (ED16A = 1 and ED16B = 3 and ED10A = 1 and ED10B = 3).

compute dropped4   = (ED16A = 1 and ED16B = 4 and ED9 <> 1).
compute graduated4 = (ED16A = 1 and ED16B = 4 and ED10A = 1 and ED10B = 5).
compute repeated4 = (ED16A = 1 and ED16B = 4 and ED10A = 1 and ED10B = 4).

compute dropped5   = (ED16A = 1 and ED16B = 5 and ED9 <> 1).
compute graduated5= (ED16A = 1 and ED16B = 5 and ED10A = 1 and ED10B =6).
compute repeated5 = (ED16A = 1 and ED16B = 5 and ED10A = 1 and ED10B = 5).

compute dropped6   = (ED16A = 1 and ED16B = 6 and ED9 <> 1).
compute graduated6= (ED16A = 1 and ED16B = 6 and ED10A = 2 and ED10B =1).
compute repeated6 = (ED16A = 1 and ED16B = 6 and ED10A = 1 and ED10B = 6).

compute dropped7   = (ED16A = 2 and ED16B = 1 and ED9 <> 1).
compute graduated7= (ED16A = 2 and ED16B = 1 and ED10A = 2 and ED10B =2).
compute repeated7 = (ED16A = 2 and ED16B = 1 and ED10A = 2 and ED10B = 1).

compute dropped8   = (ED16A = 2 and ED16B = 2 and ED9 <> 1).
compute graduated8= (ED16A = 2 and ED16B = 2 and ED10A = 2 and ED10B =3).
compute repeated8= (ED16A = 2 and ED16B = 2 and ED10A = 2 and ED10B = 2).

compute dropped9   = (ED16A = 2 and ED16B = 3 and ED9 <> 1).
compute graduated9= (ED16A = 2 and ED16B = 3 and ED10A = 3 and ED10B =1).
compute repeated9= (ED16A = 2 and ED16B = 3 and ED10A = 2 and ED10B = 3).

compute dropped10   = (ED16A = 3 and ED16B = 1 and ED9 <> 1).
compute graduated10= (ED16A = 3 and ED16B = 1 and ED10A = 3 and ED10B =2).
compute repeated10= (ED16A = 3 and ED16B = 1 and ED10A = 3 and ED10B = 1).

compute dropped11   = (ED16A = 3 and ED16B = 2 and ED9 <> 1).
compute graduated11= (ED16A = 3 and ED16B = 2 and ED10A = 3 and ED10B =3).
compute repeated11= (ED16A = 3 and ED16B = 2 and ED10A = 3 and ED10B = 2).

compute dropped12  = (ED16A = 3 and ED16B = 3 and ED9 <> 1).
compute graduated12= (ED16A = 3 and ED16B = 3 and (ED10A = 3 or ED10A=4)).
compute repeated12= (ED16A = 3 and ED16B = 3 and ED10A = 3 and ED10B = 3).

compute dropped13  = (ED16A = 3 and ED16B = 4 and ED9 <> 1).
compute graduated13= (ED16A = 3 and ED16B = 4 and (ED10A >=4)).
compute repeated13= (ED16A = 3 and ED16B = 4 and ED10A = 3 and ED10B = 4).


aggregate outfile = 'tmp1.sav'
  /break = total
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13).
  
aggregate outfile = 'tmp2.sav'
  /break = HL4
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13).
  

aggregate outfile = 'tmp3.sav'
  /break = HH7
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13). 
  

aggregate outfile = 'tmp4.sav'
  /break = HH6
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13). 
  

aggregate outfile = 'tmp5.sav'
  /break = HH7A
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13).
  

aggregate outfile = 'tmp6.sav'
  /break = windex5
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13).
  

aggregate outfile = 'tmp7.sav'
  /break = ethnicity
  /dropped1    = sum(dropped1)
  /graduated1  = sum(graduated1)
  /repeated1  = sum(repeated1)
  /dropped2    = sum(dropped2)
  /graduated2  = sum(graduated2)
  /repeated2  = sum(repeated2)
  /dropped3    = sum(dropped3)
  /graduated3  = sum(graduated3)
  /repeated3  = sum(repeated3)
  /dropped4    = sum(dropped4)
  /graduated4  = sum(graduated4)
  /repeated4  = sum(repeated4)
  /dropped5    = sum(dropped5)
  /graduated5  = sum(graduated5)
  /repeated5  = sum(repeated5)
  /dropped6    = sum(dropped6)
  /graduated6  = sum(graduated6)
   /repeated6  = sum(repeated6)
   /dropped7    = sum(dropped7)
  /graduated7  = sum(graduated7)
   /repeated7  = sum(repeated7)
   /dropped8    = sum(dropped8)
  /graduated8  = sum(graduated8)
   /repeated8  = sum(repeated8)
   /dropped9    = sum(dropped9)
  /graduated9  = sum(graduated9)
   /repeated9  = sum(repeated9)
   /dropped10    = sum(dropped10)
  /graduated10  = sum(graduated10)
   /repeated10  = sum(repeated10)
   /dropped11    = sum(dropped11)
  /graduated11  = sum(graduated11)
   /repeated11  = sum(repeated11)
  /dropped12    = sum(dropped12)
  /graduated12  = sum(graduated12)  
  /repeated12  = sum(repeated12)
    /dropped13    = sum(dropped13)
  /graduated13  = sum(graduated13)  
  /repeated13  = sum(repeated13).

get file = 'tmp1.sav'.
add files
  /file = *
  /file = 'tmp2.sav'
  /file = 'tmp3.sav'
  /file = 'tmp4.sav'
  /file = 'tmp5.sav'
  /file = 'tmp6.sav'
   /file = 'tmp7.sav'.

*Number of children in each grade. 
compute num1 = graduated1 + dropped1 + repeated1.
compute num2 = graduated2 + dropped2 + repeated2.
compute num3 = graduated3 + dropped3 + repeated3. 
compute num4 = graduated4 + dropped4 + repeated4. 
compute num5 = graduated5 + dropped5 + repeated5. 
compute num6 = graduated6 + dropped6 + repeated6. 
compute num7 = graduated7 + dropped7 + repeated7. 
compute num8 = graduated8 + dropped8 + repeated8.
compute num9 = graduated9 + dropped9 + repeated9. 
compute num10 = graduated10 + dropped10 + repeated10. 
compute num11 = graduated11 + dropped11 + repeated11. 
compute num12 = graduated12 + dropped12 + repeated12.
compute num13 = graduated13 + dropped13 + repeated13.


if (num1 > 0) d1 = dropped1 / num1 * 100 .
if (num2 > 0) d2 = dropped2 / num2 * 100 .
if (num3 > 0) d3 = dropped3 / num3 * 100 .
if (num4 > 0) d4 = dropped4 / num4 * 100 .
if (num5 > 0) d5 = dropped5 / num5 * 100 .
if (num6 > 0) d6 = dropped6 / num6 * 100 .
if (num7 > 0) d7 = dropped7 / num7 * 100 .
if (num8 > 0) d8 = dropped8 / num8 * 100 .
if (num9 > 0) d9 = dropped9 / num9 * 100 .
if (num10 > 0) d10 = dropped10 / num10 * 100 .
if (num11 > 0) d11 = dropped11 / num11 * 100 .
if (num12 > 0) d12 = dropped12 / num12 * 100 .
if (num13 > 0) d13 = dropped13 / num13 * 100 .

if (num1 > 0) r1 = repeated1 / num1 * 100 .
if (num2 > 0) r2 = repeated2 / num2 * 100 .
if (num3 > 0) r3 = repeated3 / num3 * 100 .
if (num4 > 0) r4 = repeated4 / num4 * 100 .
if (num5 > 0) r5 = repeated5 / num5 * 100 .
if (num6 > 0) r6 = repeated6 / num6 * 100 .
if (num7 > 0) r7 = repeated7 / num7 * 100 .
if (num8 > 0) r8 = repeated8 / num8 * 100 .
if (num9 > 0) r9 = repeated9 / num9 * 100 .
if (num10 > 0) r10 = repeated10 / num10 * 100 .
if (num11 > 0) r11 = repeated11 / num11 * 100 .
if (num12 > 0) r12 = repeated12 / num12 * 100 .
if (num13 > 0) r13 = repeated13 / num13 * 100 .

*Compute dropout rate by level of education.
*compute dropprim=100- ((100-d1)*(100-d2)*(100-d3)*(100-d4)*(100-d5)/100000000).
*compute droplsec=100- ((100-d7)*(100-d8)/100).
*compute dropusec=100- ((100-d10)*(100-d11)*(100-d12)/10000).

* Percentage for the whole is the multiplication of all percents for all grades, and division with the number of grades included minus one .

variable labels d1   "Percent attending grade 1 primary last school year who dropped this school year" .
variable labels d2   "Percent attending grade 2 primary last school year who dropped this school year" .
variable labels d3   "Percent attending grade 3 primary last school year who dropped this school year" .
variable labels d4   "Percent attending grade 4 primary last school year who dropped this school year" .
variable labels d5   "Percent attending grade 5 primary last school year who did not transition to lower secondary" .
variable labels d6   "Percent attending grade 6 primary last year who did not transition to lower secondary" .
variable labels d7   "Percent attending grade 1 lower secondary last school year who dropped this school year" .
variable labels d8   "Percent attending grade 2 lower secondary last school year who dropped this school year" .
variable labels d9   "Percent attending grade 3 lower secondary last school year who did not transition to upper secondary this school year" .
variable labels d10   "Percent attending grade 1 upper secondary last school year who dropped this school year" .
variable labels d11   "Percent attending grade 2 upper secondary last school year who dropped this school year" .
variable labels d12   "Percent attending grade 3 upper secondary last school year who dropped this school year" .
variable labels d13   "Percent attending grade 4 upper secondary last school year who did not transition to higher education last year " .

variable labels r1   "Percent attending grade 1 primary last school year who repeated this school year" .
variable labels r2   "Percent attending grade 2 primary last school year who repeated this school year" .
variable labels r3   "Percent attending grade 3 primary last school year who repeated this school year" .
variable labels r4   "Percent attending grade 4 primary last school year who repeated this school year" .
variable labels r5   "Percent attending grade 5 primary last school year who repeated this school year" .
variable labels r6  "Percent attending grade 6 primary last school year who repeated this school year" .
variable labels r7   "Percent attending grade 1 lower secondary last school year who repeated this school year" .
variable labels r8   "Percent attending grade 2 lower secondary last school year who repeated this school year" .
variable labels r9   "Percent attending grade 3 lower secondary last school year who repeated this school year" .
variable labels r10   "Percent attending grade 1 upper secondary last school year who repeated this school year" .
variable labels r11   "Percent attending grade 2 upper secondary last school year who repeated this school year" .
variable labels r12   "Percent attending grade 3 upper secondary last school year who repeated this school year" .
variable labels r13   "Percent attending grade 4 upper secondary last school year who repeated this school year" .

 variable labels num1 "Number of children who attended grade 1 last year".
 variable labels num2 "Number of children who attended grade 2 last year".
 variable labels num3 "Number of children who attended grade 3 last year".
 variable labels  num4 "Number of children who attended grade 4 last year".
  variable labels num5 "Number of children who attended grade 5 last year".
 variable labels num6 "Number of children who attended grade 6 last year".
 variable labels num7 "Number of children who attended grade 1 in lower secondary last year".
 variable labels num8 "Number of children who attended grade 2 in lower secondary last year".
 variable labels num9 "Number of children who attended grade 3 in lower secondary last year".
 variable labels num10 "Number of children who attended grade 1 in upper secondary last year".
 variable labels num11 "Number of children who attended grade 2 in upper secondary last year".
 variable labels num12 "Number of children who attended grade 3 in upper secondary last year".
 variable labels num13 "Number of children who attended grade 4 in upper secondary last year".



* Ctables command in English (currently active, comment it out if using different language).
ctables
  /table   total [c] + HL4 [c] 
           by
           d1   [s] [mean,'',f5.1]
         + d2   [s] [mean,'',f5.1]
         + d3   [s] [mean,'',f5.1]
         + d4   [s] [mean,'',f5.1]
         + d5   [s] [mean,'',f5.1]
         + d6   [s] [mean,'',f5.1]
         + d7   [s] [mean,'',f5.1]
         + d8   [s] [mean,'',f5.1]
         + d9   [s] [mean,'',f5.1]
         + d10   [s] [mean,'',f5.1]
         + d11   [s] [mean,'',f5.1]
         + d12   [s] [mean,'',f5.1]
         + d13   [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels visible = no
  /titles title=
    "Grade-specific dropout rate"
     + "Sierra Leone 2017"
   caption=
    "Dropout rate".


ctables
  /table   total [c] + HL4 [c]
           by
             r1   [s] [mean,'',f5.1]
         + r2   [s] [mean,'',f5.1]
         + r3   [s] [mean,'',f5.1]
         + r4   [s] [mean,'',f5.1]
         + r5   [s] [mean,'',f5.1]
         + r6   [s] [mean,'',f5.1]
         + r7   [s] [mean,'',f5.1]
         + r8   [s] [mean,'',f5.1]
         + r9   [s] [mean,'',f5.1]
         + r10   [s] [mean,'',f5.1]
         + r11   [s] [mean,'',f5.1]
         + r12   [s] [mean,'',f5.1]
         + r13   [s] [mean,'',f5.1]
  /categories var=all empty=exclude missing=exclude
  /slabels visible = no
  /titles title=
    "Grade-specific repeition rate"
     + "Sierra Leone 2017"
   caption=
    "Repetition rate".

            