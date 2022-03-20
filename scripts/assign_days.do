********************************************************************************

*                                 assign_days                                  *
*                               Cheyenne Quijano                               *

********************************************************************************

* assign_days.do takes the 2013 Philippine DHS .dta file as an input & returns 
* the same .dta file with variable days, indicating the number of days between 
* the interview and when Typhoon Labuyo hit the Philippines

clear

* open 2013 DHS datafile
use "/Users/cheyennequijano/Desktop/thesis/flood/data/DHS/PH_2013_DHS_02142022_1512_160104/PHKR61DT/PHKR61FL.DTA", clear

*** Create days since typhoon variable ***

* days since Typhoon Labuyo hit
gen days = .
label var days "days since typhoon"

* typhoon hit on 08/12/2013
replace days = v016-12 if v006==8
replace days = 19+v016 if v006==9

save, replace

clear
