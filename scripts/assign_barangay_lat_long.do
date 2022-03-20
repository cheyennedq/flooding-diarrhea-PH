********************************************************************************

*                           assign_barangay_lat_long                           *
*                               Cheyenne Quijano                               *

********************************************************************************

* assign_barangay_lat_long.do takes the 2013 Philippine DHS .dta file as an 
* 	input & returns the same .dta file with variables latitude & longitude and 
* 	latitude_b & longitude_b, which assign decimal coordinates to each
* 	municipality and barangay, respectively. The updated file also contains 
* 	variables location and location_b, which assign the corresponding UACS code 
* 	for each municipality and barangay, respectively & updated region recodes

clear

* open 2013 DHS datafile
use "/Users/cheyennequijano/Desktop/thesis/flood/data/DHS/PH_2013_DHS_02142022_1512_160104/PHKR61DT/PHKR61FL.DTA", clear

*** create location + location_b variables ***
* location is the child's location id with region, province, municipality info *
* location_b is the child's location id with region, province, municipality, & *
* barangay info																   *

* create recoded region variable
gen sregion_edit = sregion

* recode CALABARZON & MIMAROPA
replace sregion_edit = 4 if sregion_edit == 41
replace sregion_edit = 17 if sregion_edit == 42

* label values by region name
label define region_name 1 "Region I – Ilocos Region" 2 "Region II – Cagayan Valley" 3 "Region III – Central Luzon" 4 "Region IV‑A – CALABARZON" 5 "Region V – Bicol Region" 6 "Region VI – Western Visayas" 7 "Region VII – Central Visayas" 8 "Region VIII – Eastern Visayas" 9 "Region IX – Zamboanga Peninsula" 10 "Region X – Northern Mindanao" 11 "Region XI – Davao Region" 12 "Region XII – SOCCSKSARGEN" 13 "NCR – National Capital Region" 14 "CAR – Cordillera Administrative Region" 15 "BARMM – Autonomous Region in Muslim Mindanao" 16 "Region XIII – Caraga" 17 "MIMAROPA"

label values sregion_edit region_name
 
* change region, province, municipality, barangay variables to strings

* add leading zeros
gen sregion_str = string(sregion_edit, "%02.0f")
gen sprov_str = string(sprov, "%02.0f")
gen smunic_str = string(smunic, "%02.0f")
gen sbarang_str = string(sbarang, "%03.0f")

* assign values to location & location_b
gen location = sregion_str + sprov_str + smunic_str
gen location_b = sregion_str + sprov_str + smunic_str + sbarang_str

label var location "region, province, municipality"
label var location_b "region, province, municipality, barangay"

* assign latitude + longitude to location & location_b for affected regions (I, II, III, V, CAR)

gen latitude = -1.0000
gen longitude = -1.0000

gen latitude_b = -1.0000
gen longitude_b = -1.0000

label var latitude "latitude at the municipality level"
label var longitude "longitude at the municipality level"
label var latitude_b "latitude at the village level"
label var longitude_b "longitude at the village level"

** CAR
* Bangued
replace latitude = 17.5965 if location=="140101"
replace longitude = 120.6179 if location=="140101"
	* Zone 3 Poblacion, formerly Lalaud
	replace latitude_b = 17.6012 if location_b=="140101026"
	replace longitude_b = 120.6142 if location_b=="140101026"
* Dolores
replace latitude = 17.6490 if location=="140107"
replace longitude = 120.6179 if location=="140107"
	* Salucag
	replace latitude_b = 17.6383 if location_b=="140107013"
	replace longitude_b = 120.7115 if location_b=="140107013"
* Luba
replace latitude = 17.3181 if location=="140114"
replace longitude = 120.6952 if location=="140114"
	* Barit
	replace latitude_b = 17.3797 if location_b=="140114002"
	replace longitude_b = 120.6774 if location_b=="140114002"
* Pilar
replace latitude = 17.4168 if location=="140119"
replace longitude = 17.4168 if location=="140119"
	* Tikitik
	replace latitude_b = 17.4067 if location_b=="140119020"
	replace longitude_b = 120.5800 if location_b=="140119020"
* Tubo
replace latitude = 17.2567 if location=="140126"
replace longitude = 120.7256 if location=="140126"
	* Dilong
	replace latitude_b = 17.1785 if location_b=="140126003"
	replace longitude_b = 120.7133 if location_b=="140126003"
* Baguio
replace latitude = 16.4120 if location=="141102"
replace longitude = 120.5933 if location=="141102"
	* Bakakeng North
	replace latitude_b = 16.3861 if location_b=="141102005"
	replace longitude_b = 120.5909 if location_b=="141102005"
	* Cabinet Hill-Teacher's Camp
	replace latitude_b = 16.4110 if location_b=="141102013"
	replace longitude_b = 120.6071 if location_b=="141102013"
	* Fort del Pilar
	replace latitude_b = 16.3653 if location_b=="141102037"
	replace longitude_b = 120.6177 if location_b=="141102037"
	* Irisan
	replace latitude_b = 16.4203 if location_b=="141102050"
	replace longitude_b = 120.5568 if location_b=="141102050"
	* Lucnab
	replace latitude_b = 16.4048 if location_b=="141102064"
	replace longitude_b = 120.6294 if location_b=="141102064"
	* Pinget
	replace latitude_b = 16.4268 if location_b=="141102086"
	replace longitude_b = 120.5852 if location_b=="141102086"
	* Santo Rosario
	replace latitude_b = 16.4022 if location_b=="141102101"
	replace longitude_b = 120.5851 if location_b=="141102101"
	* Bayan Park Village
	replace latitude_b = 16.4274 if location_b=="141102132"
	replace longitude_b = 120.6059 if location_b=="141102132"
	* Manuel A. Roxas
	replace latitude_b = 16.4150 if location_b=="141102148"
	replace longitude_b = 120.6079 if location_b=="141102148"
* Bokod
replace latitude = 16.4917 if location=="141104"
replace longitude = 120.8296 if location=="141104"
	* Karao
	replace latitude_b = 16.5107 if location_b=="141104006"
	replace longitude_b = 120.8562 if location_b=="141104006"
* Buguias
replace latitude = 16.8028 if location=="141105"
replace longitude = 120.8211 if location=="141105"
	* Sebang
	replace latitude_b = 16.7433 if location_b=="141105016"
	replace longitude_b = 120.8594 if location_b=="141105016"
* Itogon
replace latitude = 16.3595 if location=="141106"
replace longitude = 120.6773 if location=="141106"
	* Tuding
	replace latitude_b = 16.4111 if location_b=="141106007"
	replace longitude_b = 120.6409 if location_b=="141106007"
* Kapangan
replace latitude = 16.5751 if location=="141108"
replace longitude = 120.5979 if location=="141108"
	* Taba-ao
	replace latitude_b = 16.6060 if location_b=="141108018"
	replace longitude_b = 120.6321 if location_b=="141108018"
* La Trinidad
replace latitude = 16.4617 if location=="141110"
replace longitude = 120.5885 if location=="141110"
	* Balili
	replace latitude_b = 16.4501 if location_b=="141110005"
	replace longitude_b = 120.5938 if location_b=="141110005"
	* Pico
	replace latitude_b = 16.4472 if location_b=="141110011"
	replace longitude_b = 120.5898 if location_b=="141110011"
* Mankayan
replace latitude = 16.8569 if location=="141111"
replace longitude = 16.8569 if location=="141111"
	* Balili
	replace latitude_b = 16.8696 if location_b=="141111001"
	replace longitude_b = 120.8293 if location_b=="141111001"
	* Poblacion
	replace latitude_b = 16.8591 if location_b=="141111010"
	replace longitude_b = 120.7904 if location_b=="141111010"
* Tuba
replace latitude = 16.3927 if location=="141113"
replace longitude = 120.5622 if location=="141113"
	* Tadiangan
	replace latitude_b = 16.4271 if location_b=="141113011"
	replace longitude_b = 120.5292 if location_b=="141113011"
* Tublay
replace latitude = 16.4751 if location=="141114"
replace longitude = 120.6329 if location=="141114"
	* Ambassador
	replace latitude_b = 16.4891 if location_b=="141114001"
	replace longitude_b = 120.6704 if location_b=="141114001"
* Hungduan
replace latitude = 16.8350 if location=="142702"
replace longitude = 121.0030 if location=="142702"
	* Ba-ang
	replace latitude_b = 16.9075 if location_b=="142702022"
	replace longitude_b = 120.9813 if location_b=="142702022"
* Lamut
replace latitude = 16.6506 if location=="142705"
replace longitude = 121.2215 if location=="142705"
	* Poblacion East
	replace latitude_b = 16.6507 if location_b=="142705013"
	replace longitude_b = 121.2251 if location_b=="142705013"
* Alfonso Lista, formerly known as Potia
replace latitude = 16.9230 if location=="142707"
replace longitude = 121.4864 if location=="142707"
	* San Quintin
	replace latitude_b = 16.9230 if location_b=="142707016"
	replace longitude_b = 121.5419 if location_b=="142707016"
* Tinoc
replace latitude = 16.6760 if location=="142710"
replace longitude = 120.9361 if location=="142710"
	* Impugong
	replace latitude_b = 16.6950 if location_b=="142710007"
	replace longitude_b = 120.9335 if location_b=="142710007"
* Pinukpuk
replace latitude = 17.5736 if location=="143209"
replace longitude = 121.3651 if location=="143209"
	* Apatan
	replace latitude_b = 17.5421 if location_b=="143209004"
	replace longitude_b = 121.3393 if location_b=="143209004"
* Tabuk
replace latitude = 17.4136 if location=="143213"
replace longitude = 121.4440 if location=="143213"
	* Bagumbayan
	replace latitude_b = 17.4259 if location_b=="143213004"
	replace longitude_b = 121.2699 if location_b=="143213004"
	* Lacnog
	replace latitude_b = 17.4095 if location_b=="143213038"
	replace longitude_b = 121.5479 if location_b=="143213038"
* Bauko
replace latitude = 16.9888 if location=="144402"
replace longitude = 120.8679 if location=="144402"
	* Mabaay
	replace latitude_b = 16.9159 if location_b=="144402012"
	replace longitude_b = 120.8876 if location_b=="144402012"
* Bontoc
replace latitude = 17.0891 if location=="144404"
replace longitude = 120.9773 if location=="144404"
	* Mainit
	replace latitude_b = 17.1501 if location_b=="144404011"
	replace longitude_b = 120.9548 if location_b=="144404011"
	* Poblacion
	replace latitude_b = 17.0900 if location_b=="144404016"
	replace longitude_b = 120.9772 if location_b=="144404016"
* Sabangan
replace latitude = 17.0052 if location=="144407"
replace longitude = 120.9228 if location=="144407"
	* Data
	replace latitude_b = 17.0275 if location_b=="144407006"
	replace longitude_b = 120.9030 if location_b=="144407006"
* Tadian
replace latitude = 16.9957 if location=="144410"
replace longitude = 120.8218 if location=="144410"
	* Poblacion
	replace latitude_b = 16.9960 if location_b=="144410017"
	replace longitude_b = 120.8208 if location_b=="144410017"
* Flora
replace latitude = 18.2149 if location=="148103"
replace longitude = 121.4189 if location=="148103"
	* Poblacion East
	replace latitude_b = 18.2157 if location_b=="148103010"
	replace longitude_b = 121.4225 if location_b=="148103010"

** I
* Badoc
replace latitude = 17.9267 if location=="012803"
replace longitude = 120.4740 if location=="012803"
	* Paltit
	replace latitude_b = 17.9135 if location_b=="012803030"
	replace longitude_b = 120.4856 if location_b=="012803030"
* Dingras
replace latitude = 18.1024 if location=="012809"
replace longitude = 120.7014 if location=="012809"
	* Dancel, formerly Poblacion
	replace latitude_b = 18.1001 if location_b=="012809011"
	replace longitude_b = 120.7015 if location_b=="012809011"
* Laoag
replace latitude = 18.1973 if location=="012812"
replace longitude = 120.5935 if location=="012812"
	* Barangay No. 20, San Miguel
	replace latitude_b = 18.1932 if location_b=="012812066"
	replace longitude_b = 120.5990 if location_b=="012812066"
* Pasuquin
replace latitude = 18.3339 if location=="012817"
replace longitude = 120.6194 if location=="012817"
	* Santa Catalina
	replace latitude_b = 18.3052 if location_b=="012817027"
	replace longitude_b = 120.6706 if location_b=="012817027"
* Solsona
replace latitude = 18.0953 if location=="012822"
replace longitude = 120.7732 if location=="012822"
    * Lipay
    replace latitude_b = 18.1162 if location_b=="012822011"
    replace longitude_b = 120.8092 if location_b=="012822011"
* Cabugao
replace latitude = 17.7926 if location=="012905"
replace longitude = 120.4559 if location=="012905"
    * Daclapan
    replace latitude_b = 17.7986 if location_b=="012905014"
    replace longitude_b = 120.4168 if location_b=="012905014"
* Candon
replace latitude = 17.1895 if location=="012906"
replace longitude = 120.4474 if location=="012906"
    * San Antonio, formerly Poblacion
    replace latitude_b = 17.1936 if location_b=="012906036"
    replace longitude_b = 120.4469 if location_b=="012906036"
* Galimuyod
replace latitude = 17.1830 if location=="012909"
replace longitude = 120.4687 if location=="012909"
    * Daldagan
    replace latitude_b = 17.1845 if location_b=="012909009"
    replace longitude_b = 120.4656 if location_b=="012909009"
* San Emilio
replace latitude = 17.2386 if location=="012917"
replace longitude = 120.5789 if location=="012917"
    * Cabaroan
    replace latitude_b = 17.2383 if location_b=="012917001"
    replace longitude_b = 120.5799 if location_b=="012917001"
* Santa Cruz
replace latitude = 17.0844 if location=="012924"
replace longitude = 120.4520 if location=="012924"
    * Pilar
    replace latitude_b = 17.0750 if location_b=="012924029"
    replace longitude_b = 120.4418 if location_b=="012924029"
* Santo Domingo
replace latitude = 17.6378 if location=="012928"
replace longitude = 120.4101 if location=="012928"
    * San Pablo
    replace latitude_b = 17.6399 if location_b=="012928033"
    replace longitude_b = 120.4124 if location_b=="012928033"
* Vigan
replace latitude = 17.5729 if location=="012934"
replace longitude = 120.3867 if location=="012934"
    * Purok‑a‑bassit
    replace latitude_b = 17.5720 if location_b=="012934028"
    replace longitude_b = 120.4146 if location_b=="012934028"
* Aringay
replace latitude = 16.3957 if location=="013302"
replace longitude = 120.3553 if location=="013302"
    * Santo Rosario West
    replace latitude_b = 16.3870 if location_b=="013302028"
    replace longitude_b = 120.3397 if location_b=="013302028"
* Bangar
replace latitude = 16.8937 if location=="013306"
replace longitude = 120.4229 if location=="013306"
    * Rissing
    replace latitude_b = 16.8531 if location_b=="013306032"
    replace longitude_b = 120.4291 if location_b=="013306032"
* Luna
replace latitude = 16.8528 if location=="013310"
replace longitude = 120.3765 if location=="013310"
    * Nalvo Norte
    replace latitude_b = 16.8453 if location_b=="013310018"
    replace longitude_b = 120.3549 if location_b=="013310018"
* Rosario
replace latitude = 16.2295 if location=="013313"
replace longitude = 120.4878 if location=="013313"
    * Nangcamotian
    replace latitude_b = 16.2160 if location_b=="013313020"
    replace longitude_b = 120.4985 if location_b=="013313020"
* San Juan
replace latitude = 16.6701 if location=="013316"
replace longitude = 120.3373 if location=="013316"
    * Duplas
    replace latitude_b = 16.6576 if location_b=="013316018"
    replace longitude_b = 120.4262 if location_b=="013316018"

* Tubao
replace latitude = 16.3470 if location=="013320"
replace longitude = 120.4126 if location=="013320"
    * Lloren
    replace latitude_b = 16.3314 if location_b=="013320020"
    replace longitude_b = 120.4480 if location_b=="013320020"
* Alaminos
replace latitude = 16.1565 if location=="015503"
replace longitude = 119.9804 if location=="015503"
    * Poblacion
    replace latitude_b = 16.1602 if location_b=="015503021"
    replace longitude_b = 119.9811 if location_b=="015503021"
    * San Roque
    replace latitude_b = 16.1668 if location_b=="015503030"
    replace longitude_b = 119.9486 if location_b=="015503030"
* Asingan
replace latitude = 16.0037 if location=="015506"
replace longitude = 120.6702 if location=="015506"
    * Bantog
    replace latitude_b = 16.0069 if location_b=="015506004"
    replace longitude_b = 120.6865 if location_b=="015506004"
* Bani
replace latitude = 16.1833 if location=="015508"
replace longitude = 119.8625 if location=="015508"
	* San Simon
	replace latitude_b = 16.2113 if location_b=="015508021"
	replace longitude_b = 119.7959 if location_b=="015508021"
* Bayambang
replace latitude = 15.8088 if location=="015511"
replace longitude = 120.4540 if location=="015511"
	* Malimpec
	replace latitude_b = 15.8439 if location_b=="015511040"
	replace longitude_b = 120.4065 if location_b=="015511040"
* Binmaley
replace latitude = 16.0305 if location=="015513"
replace longitude = 120.2695 if location=="015513"
	* Buenlag
	replace latitude_b = 16.0485 if location_b=="015513008"
	replace longitude_b = 120.2864 if location_b=="015513008"
* Bolinao
replace latitude = 16.3856 if location=="015514"
replace longitude = 119.8945 if location=="015514"
	* Luna
	replace latitude_b = 16.3297 if location_b=="015514019"
	replace longitude_b = 119.8944 if location_b=="015514019"
* Calasiao
replace latitude = 16.0089 if location=="015517"
replace longitude = 120.3571 if location=="015517"
	* Poblacion East
	replace latitude_b = 16.0086 if location_b=="015517018"
	replace longitude_b = 120.3592 if location_b=="015517018"
* Dagupan
replace latitude = 16.0424 if location=="015518"
replace longitude = 120.3375 if location=="015518"
	* Bonuan Boquig
	replace latitude_b = 16.0764 if location_b=="015518008"
	replace longitude_b = 120.3565 if location_b=="015518008"
* Labrador
replace latitude = 16.0255 if location=="015521"
replace longitude = 120.1453 if location=="015521"
	* San Jose
	replace latitude_b = 16.0321 if location_b=="015521008"
	replace longitude_b = 120.1422 if location_b=="015521008"
* Lingayen
replace latitude = 16.0206 if location=="015522"
replace longitude = 120.2306 if location=="015522"
	* Pangapisan North
	replace latitude_b = 16.0240 if location_b=="015522026"
	replace longitude_b = 120.2150 if location_b=="015522026"
* Malasiqui
replace latitude = 15.9191 if location=="015524"
replace longitude = 120.4139 if location=="015524"
	* Binalay
	replace latitude_b = 15.9067 if location_b=="015524017"
	replace longitude_b = 120.4300 if location_b=="015524017"
* Manaoag
replace latitude = 16.0427 if location=="015525"
replace longitude = 120.4874 if location=="015525"
	* Lipit Sur
	replace latitude_b = 16.0675 if location_b=="015525026"
	replace longitude_b = 120.5191 if location_b=="015525026"
* Mangatarem
replace latitude = 15.7885 if location=="015527"
replace longitude = 120.2938 if location=="015527"
	* Bogtong Bolo
	replace latitude_b = 15.7454 if location_b=="015527007"
	replace longitude_b = 120.3169 if location_b=="015527007"
* Natividad
replace latitude = 16.0427 if location=="015529"
replace longitude = 120.7946 if location=="015529"
	* San Macario Sur
	replace latitude_b = 16.0167 if location_b=="015529018"
	replace longitude_b = 120.8232 if location_b=="015529018"
* Rosales
replace latitude = 15.8915 if location=="015531"
replace longitude = 120.6331 if location=="015531"
	* Zone IV, formerly Poblacion
	replace latitude_b = 15.8939 if location_b=="015531034"
	replace longitude_b = 120.6338 if location_b=="015531034"
* San Carlos
replace latitude = 15.9277 if location=="015532"
replace longitude = 120.3478 if location=="015532"
	* Pangalangan
	replace latitude_b = 15.9532 if location_b=="015532063"
	replace longitude_b = 120.3197 if location_b=="015532063"
* San Fabian
replace latitude = 16.1265 if location=="015533"
replace longitude = 120.4033 if location=="015533"
	* Alacan
	replace latitude_b = 16.1689 if location_b=="015533031"
	replace longitude_b = 120.4270 if location_b=="015533031"
* San Nicolas
replace latitude = 16.0703 if location=="015536"
replace longitude = 120.7624 if location=="015536"
	* Santa Maria West
	replace latitude_b = 16.0848 if location_b=="015536033"
	replace longitude_b = 120.7854 if location_b=="015536033"
* Santa Maria
replace latitude = 15.9792 if location=="015539"
replace longitude = 120.7003 if location=="015539"
	* Namagbagan
	replace latitude_b = 15.9511 if location_b=="015539010"
	replace longitude_b = 120.6849 if location_b=="015539010"
* Tayug
replace latitude = 16.0278 if location=="015543"
replace longitude = 120.7447 if location=="015543"
	* Evangelista
	replace latitude_b = 15.9993 if location_b=="015543006"
	replace longitude_b = 120.7380 if location_b=="015543006"
* Urbiztondo
replace latitude = 15.8232 if location=="015545"
replace longitude = 120.3294 if location=="015545"
	* Dalangiring
	replace latitude_b = 15.8397 if location_b=="015545008"
	replace longitude_b = 120.3308 if location_b=="015545008"
	* Duplac
	replace latitude_b = 15.8444 if location_b=="015545009"
	replace longitude_b = 120.3674 if location_b=="015545009"
* Villasis
replace latitude = 15.9015 if location=="015547"
replace longitude = 120.5883 if location=="015547"
	* Piaz, formerly Plaza
	replace latitude_b = 15.9351 if location_b=="015547011"
	replace longitude_b = 120.6194 if location_b=="015547011"

** II
* Alcala
replace latitude = 17.9024 if location=="021502"
replace longitude = 121.6567 if location=="021502"
	* Malalatan
	replace latitude_b = 17.8760 if location_b=="021502015"
	replace longitude_b = 121.6357 if location_b=="021502015"
* Aparri
replace latitude = 18.3572 if location=="021505"
replace longitude = 121.6371 if location=="021505"
	* Bangag
	replace latitude_b = 18.2964 if location_b=="021505002"
	replace longitude_b = 121.5615 if location_b=="021505002"
* Baggao
replace latitude = 17.9352 if location=="021506"
replace longitude = 121.7718 if location=="021506"
	* San Francisco
	replace latitude_b = 17.8602 if location_b=="021506033"
	replace longitude_b = 121.8912 if location_b=="021506033"
* Camalaniugan
replace latitude = 18.2750 if location=="021510"
replace longitude = 121.6744 if location=="021510"
	* Bantay
	replace latitude_b = 18.2490 if location_b=="021510006"
	replace longitude_b = 121.6955 if location_b=="021510006"
* Gattaran
replace latitude = 18.0614 if location=="021513"
replace longitude = 121.6433 if location=="021513"
	* Baraoidan
	replace latitude_b = 18.0332 if location_b=="021513008"
	replace longitude_b = 121.7409 if location_b=="021513008"
* Iguig
replace latitude = 17.7525 if location=="021515"
replace longitude = 121.7380 if location=="021515"
	* Dumpao
	replace latitude_b = 17.7399 if location_b=="021515007"
	replace longitude_b = 121.7409 if location_b=="021515007"
* Lasam
replace latitude = 18.0645 if location=="021517"
replace longitude = 121.6015 if location=="021517"
	* Cabatacan West
	replace latitude_b = 18.0949 if location_b=="021517028"
	replace longitude_b = 121.4839 if location_b=="021517028"
* Piat
replace latitude = 17.7918 if location=="021520"
replace longitude = 121.4770 if location=="021520"
	* Villa Rey, formerly San Gaspar
	replace latitude_b = 17.8120 if location_b=="021520014"
	replace longitude_b = 121.5008 if location_b=="021520014"
* Santa Teresita
replace latitude = 18.2487 if location=="021525"
replace longitude = 121.9091 if location=="021525"
	* Caniugan
	replace latitude_b = 18.2603 if location_b=="021525014"
	replace longitude_b = 121.9160 if location_b=="021525014"
* Solana
replace latitude = 17.6508 if location=="021527"
replace longitude = 121.6907 if location=="021527"
    * Iraga
    replace latitude_b = 17.7231 if location_b=="021527036"
    replace longitude_b = 121.6451 if location_b=="021527036"
* Tuguegarao
replace latitude = 17.6125 if location=="021529"
replace longitude = 121.7327 if location=="021529"
	* Capatan
	replace latitude_b = 17.6163 if location_b=="021529017"
	replace longitude_b = 121.7464 if location_b=="021529017"
	* San Gabriel
	replace latitude_b = 17.6203 if location_b=="021529051"
	replace longitude_b = 121.7128 if location_b=="021529051"
* Alicia
replace latitude = 16.7789 if location=="023101"
replace longitude = 121.6992 if location=="023101"
	* Rizal
	replace latitude_b = 16.8334 if location_b=="023101020"
	replace longitude_b = 121.6765 if location_b=="023101020"
* Aurora
replace latitude = 16.9906 if location=="023103"
replace longitude = 121.6392 if location=="023103"
	* Santa Rosa
	replace latitude_b = 16.9902 if location_b=="023103027"
	replace longitude_b = 121.6339 if location_b=="023103027"
* Cabagan
replace latitude = 17.4263 if location=="023106"
replace longitude = 121.7649 if location=="023106"
	* Masipi East
	replace latitude_b = 17.3847 if location_b=="023106025"
	replace longitude_b = 121.8804 if location_b=="023106025"
* Cauayan
replace latitude = 16.9343 if location=="023108"
replace longitude = 121.7666 if location=="023108"
	* Rizal
	replace latitude_b = 16.9123 if location_b=="023108056"
	replace longitude_b = 121.8034 if location_b=="023108056"
* Echague
replace latitude = 16.7168 if location=="023112"
replace longitude = 121.6832 if location=="023112"
	* Carulay
	replace latitude_b = 16.7156 if location_b=="023112011"
	replace longitude_b = 121.7110 if location_b=="023112011"
* Ilagan
replace latitude = 17.1442 if location=="023114"
replace longitude = 121.8889 if location=="023114"
	* Cabeseria 27, formerly Abuan
	replace latitude_b = 17.0871 if location_b=="023114001"
	replace longitude_b = 122.0055 if location_b=="023114001"
    * Alibagu
	replace latitude_b = 17.1028 if location_b=="023114003"
	replace longitude_b = 121.8616 if location_b=="023114003"
    * San Juan
	replace latitude_b = 17.2098 if location_b=="023114083"
	replace longitude_b = 121.8792 if location_b=="023114083"
* Maconacon
replace latitude = 17.3893 if location=="023117"
replace longitude = 122.2398 if location=="023117"
	* Fely, formerly Poblacion
	replace latitude_b = 17.3893 if location_b=="023117003"
	replace longitude_b = 122.2399 if location_b=="023117003"
* Palanan
replace latitude = 17.0628 if location=="023121"
replace longitude = 122.4292 if location=="023121"
	* Bisag
	replace latitude_b = 17.0106 if location_b=="023121001"
	replace longitude_b = 122.3828 if location_b=="023121001"
* Ramon
replace latitude = 16.7815 if location=="023124"
replace longitude = 121.5351 if location=="023124"
	* Villa Carmen
	replace latitude_b = 16.7429 if location_b=="023124019"
	replace longitude_b = 121.4959 if location_b=="023124019"
* San Guillermo
replace latitude = 16.7198 if location=="023128"
replace longitude = 121.8087 if location=="023128"
	* Centro 2, formerly Poblacion
	replace latitude_b = 16.7190 if location_b=="023128005"
	replace longitude_b = 121.8104 if location_b=="023128005"
* San Mariano
replace latitude = 16.9835 if location=="023131"
replace longitude = 122.0127 if location=="023131"
	* Gangalan
	replace latitude_b = 16.8972 if location_b=="023131017"
	replace longitude_b = 122.0601 if location_b=="023131017"
* San Pablo
replace latitude = 17.4483 if location=="023133"
replace longitude = 121.7952 if location=="023133"
	* Binguang
	replace latitude_b = 17.4569 if location_b=="023133004"
	replace longitude_b = 121.7964 if location_b=="023133004"
* Santiago
replace latitude = 16.6875 if location=="023135"
replace longitude = 121.5446 if location=="023135"
	* Mabini
	replace latitude_b = 16.6997 if location_b=="023135019"
	replace longitude_b = 121.5605 if location_b=="023135019"
	* Victory Sur
	replace latitude_b = 16.6832 if location_b=="023135036"
	replace longitude_b = 121.5476 if location_b=="023135036"
* Ambaguio
replace latitude = 16.5312 if location=="025001"
replace longitude = 121.0278 if location=="025001"
	* Dulli
	replace latitude_b = 16.5573 if location_b=="025001010"
	replace longitude_b = 121.0758 if location_b=="025001010"
* Bambang
replace latitude = 16.3899 if location=="025004"
replace longitude = 121.1061 if location=="025004"
	* Buag
	replace latitude_b = 16.3862 if location_b=="025004009"
	replace longitude_b = 121.1020 if location_b=="025004009"
* Bayombong
replace latitude = 16.4841 if location=="025005"
replace longitude = 121.1439 if location=="025005"
	* Vista Alegre, formerly B. Baringin
	replace latitude_b = 16.4763 if location_b=="025005028"
	replace longitude_b = 121.1416 if location_b=="025005028"
* Kasibu
replace latitude = 16.3165 if location=="025009"
replace longitude = 121.2954 if location=="025009"
	* Watwat
	replace latitude_b = 16.3251 if location_b=="025009025"
	replace longitude_b = 121.2783 if location_b=="025009025"
* Solano
replace latitude = 16.5187 if location=="025013"
replace longitude = 121.1818 if location=="025013"
	* Roxas
	replace latitude_b = 16.5210 if location_b=="025013013"
	replace longitude_b = 121.1892 if location_b=="025013013"
	* Pilar D. Galima
	replace latitude_b = 16.5359 if location_b=="025013023"
	replace longitude_b = 121.1626 if location_b=="025013023"
* Diffun
replace latitude = 16.5930 if location=="025703"
replace longitude = 121.5030 if location=="025703"
	* Doña Imelda
	replace latitude_b = 16.5127 if location_b=="025703011"
	replace longitude_b = 121.4771 if location_b=="025703011"
* Nagtipunan
replace latitude = 16.2206 if location=="025706"
replace longitude = 121.6060 if location=="025706"
	* La Conwap, formerly Guingin
	replace latitude_b = 16.0532 if location_b=="025706005"
	replace longitude_b = 121.3741 if location_b=="025706005"

** III
* Balanga
replace latitude = 14.6795 if location=="030803"
replace longitude = 120.5409 if location=="030803"
	* Tenejero
	replace latitude_b = 14.6790 if location_b=="030803021"
	replace longitude_b = 120.5332 if location_b=="030803021"
* Dinalupihan
replace latitude = 14.8663 if location=="030804"
replace longitude = 120.4631 if location=="030804"
	* Gen. Luna, formerly Poblacion
	replace latitude_b = 14.8700 if location_b=="030804011"
	replace longitude_b = 120.4647 if location_b=="030804011"
* Mariveles
replace latitude = 14.4356 if location=="030807"
replace longitude = 120.4903 if location=="030807"
	* Balon-Anito
	replace latitude_b = 14.4361 if location_b=="030807013"
	replace longitude_b = 120.4730 if location_b=="030807013"
* Orani
replace latitude = 14.8007 if location=="030809"
replace longitude = 120.5367 if location=="030809"
	* Tala
	replace latitude_b = 14.7546 if location_b=="030809019"
	replace longitude_b = 120.4305 if location_b=="030809019"
* Angat
replace latitude = 14.9327 if location=="031401"
replace longitude = 121.0319 if location=="031401"
	* Pulong Yantok
	replace latitude_b = 14.8938 if location_b=="031401013"
	replace longitude_b = 121.0170 if location_b=="031401013"
	* Sulucan
	replace latitude_b = 14.9389 if location_b=="031401018"
	replace longitude_b = 121.0037 if location_b=="031401018"
* Baliuag
replace latitude = 14.9585 if location=="031403"
replace longitude = 120.8970 if location=="031403"
	* Tangos
	replace latitude_b = 14.9724 if location_b=="031403024"
	replace longitude_b = 120.8977 if location_b=="031403024"
* Bulakan
replace latitude = 14.7943 if location=="031405"
replace longitude = 120.8795 if location=="031405"
	* San Nicolas
	replace latitude_b = 14.7979 if location_b=="031405012"
	replace longitude_b = 120.8667 if location_b=="031405012"
* Calumpit
replace latitude = 14.9151 if location=="031407"
replace longitude = 120.7636 if location=="031407"
	* Buguion
	replace latitude_b = 14.8940 if location_b=="031407004"
	replace longitude_b = 120.7985 if location_b=="031407004"
* Guiguinto
replace latitude = 14.8280 if location=="031408"
replace longitude = 120.8783 if location=="031408"
	* Tabang
	replace latitude_b = 14.8249 if location_b=="031408011"
	replace longitude_b = 120.8661 if location_b=="031408011"
* Malolos
replace latitude = 14.8405 if location=="031410"
replace longitude = 120.8116 if location=="031410"
	* Bulihan
	replace latitude_b = 14.8582 if location_b=="031410012"
	replace longitude_b = 120.8014 if location_b=="031410012"
	* San Juan
	replace latitude_b = 14.8349 if location_b=="031410043"
	replace longitude_b = 120.8162 if location_b=="031410043"
	* Tikay
	replace latitude_b = 14.8423 if location_b=="031410055"
	replace longitude_b = 120.8532 if location_b=="031410055"
* Marilao
replace latitude = 14.7572 if location=="031411"
replace longitude = 120.9477 if location=="031411"
	* Loma de Gato
	replace latitude_b = 14.7911 if location_b=="031411006"
	replace longitude_b = 121.0077 if location_b=="031411006"
* Meycauayan
replace latitude = 14.7360 if location=="031412"
replace longitude = 120.9573 if location=="031412"
	* Iba
	replace latitude_b = 14.7541 if location_b=="031412009"
	replace longitude_b = 120.9815 if location_b=="031412009"
* Norzagaray
replace latitude = 14.9070 if location=="031413"
replace longitude = 121.0465 if location=="031413"
	* Matictic
	replace latitude_b = 14.9003 if location_b=="031413015"
	replace longitude_b = 121.0702 if location_b=="031413015"
* Pandi
replace latitude = 14.8633 if location=="031415"
replace longitude = 120.9557 if location=="031415"
	* Poblacion
	replace latitude_b = 14.8648 if location_b=="031415016"
	replace longitude_b = 120.9578 if location_b=="031415016"
* Paombong
replace latitude = 14.8315 if location=="031416"
replace longitude = 120.7874 if location=="031416"
	* Santa Cruz
	replace latitude_b = 14.7610 if location_b=="031416014"
	replace longitude_b = 120.7908 if location_b=="031416014"
* Pulilan
replace latitude = 14.9022 if location=="031418"
replace longitude = 120.8471 if location=="031418"
	* Taal
	replace latitude_b = 14.9079 if location_b=="031418033"
	replace longitude_b = 120.8806 if location_b=="031418033"
* San Jose del Monte
replace latitude = 14.8098 if location=="031420"
replace longitude = 121.0469 if location=="031420"
	* Muzon
	replace latitude_b = 14.8020 if location_b=="031420007"
	replace longitude_b = 121.0347 if location_b=="031420007"
	* Sapang Palay
	replace latitude_b = 14.8390 if location_b=="031420010"
	replace longitude_b = 121.0429 if location_b=="031420010"
	* San Rafael
	replace latitude_b = 14.8484 if location_b=="031420017"
	replace longitude_b = 121.0454 if location_b=="031420017"
* San Miguel
replace latitude = 15.1457 if location=="031421"
replace longitude = 120.9742 if location=="031421"
	* Camias
	replace latitude_b = 15.1637 if location_b=="031421020"
	replace longitude_b = 120.9707 if location_b=="031421020"
	* Masalipit
	replace latitude_b = 15.1494 if location_b=="031421031"
	replace longitude_b = 121.0367 if location_b=="031421031"
* Santa Maria
replace latitude = 14.8204 if location=="031423"
replace longitude = 120.9606 if location=="031423"
	* Caysio
	replace latitude_b = 14.8483 if location_b=="031423008"
	replace longitude_b = 120.9698 if location_b=="031423008"
	* Tabing Bakod
	replace latitude_b = 14.8044 if location_b=="031423024"
	replace longitude_b = 120.9527 if location_b=="031423024"
* Aliaga
replace latitude = 15.5032 if location=="034901"
replace longitude = 120.8455 if location=="034901"
	* Bucot
	replace latitude_b = 15.5029 if location_b=="034901005"
	replace longitude_b = 120.8714 if location_b=="034901005"
* Cabanatuan
replace latitude = 15.4902 if location=="034903"
replace longitude = 120.9665 if location=="034903"
	* Kalikid Norte
	replace latitude_b = 15.4875 if location_b=="034903041"
	replace longitude_b = 121.0552 if location_b=="034903041"
	* Aduas Norte
	replace latitude_b = 15.4994 if location_b=="034903090"
	replace longitude_b = 120.9689 if location_b=="034903090"
* Carranglan
replace latitude = 15.9603 if location=="034905"
replace longitude = 121.0638 if location=="034905"
	* R. A. Padilla
	replace latitude_b = 15.9576 if location_b=="034905001"
	replace longitude_b = 121.0368 if location_b=="034905001"
* Gapan
replace latitude = 15.3126 if location=="034908"
replace longitude = 120.9495 if location=="034908"
	* Marelo
	replace latitude_b = 15.2248 if location_b=="034908007"
	replace longitude_b = 120.9309 if location_b=="034908007"
* Guimba
replace latitude = 15.6623 if location=="034911"
replace longitude = 120.7657 if location=="034911"
	* Maybubon
	replace latitude_b = 15.6681 if location_b=="034911039"
	replace longitude_b = 120.6688 if location_b=="034911039"
* Laur
replace latitude = 15.5854 if location=="034913"
replace longitude = 121.1832 if location=="034913"
	* Siclong
	replace latitude_b = 15.5806 if location_b=="034913022"
	replace longitude_b = 121.2235 if location_b=="034913022"
* Muñoz
replace latitude = 15.7144 if location=="034917"
replace longitude = 120.9041 if location=="034917"
	* Bantug
	replace latitude_b = 15.7226 if location_b=="034917003"
	replace longitude_b = 120.9219 if location_b=="034917003"
	* Maragol
	replace latitude_b = 15.7049 if location_b=="034917020"
	replace longitude_b = 120.9509 if location_b=="034917020"
* Quezon
replace latitude = 15.5536 if location=="034922"
replace longitude = 120.8101 if location=="034922"
	* Barangay II, formerly Poblacion
	replace latitude_b = 15.5507 if location_b=="034922011"
	replace longitude_b = 120.8150 if location_b=="034922011"
* San Jose
replace latitude = 15.7899 if location=="034926"
replace longitude = 120.9900 if location=="034926"
	* Kita-Kita
	replace latitude_b = 15.8219 if location_b=="034926011"
	replace longitude_b = 121.0084 if location_b=="034926011"
	* Santo Niño 2nd
	replace latitude_b = 15.7972 if location_b=="034926031"
	replace longitude_b = 120.9745 if location_b=="034926031"
* Santo Domingo
replace latitude = 15.5863 if location=="034929"
replace longitude = 120.8778 if location=="034929"
	* Casulucan
	replace latitude_b = 15.6813 if location_b=="034929007"
	replace longitude_b = 120.9281 if location_b=="034929007"
* Talugtug
replace latitude = 15.7782 if location=="034931"
replace longitude = 120.8078 if location=="034931"
	* Tibag
	replace latitude_b = 15.8138 if location_b=="034931028"
	replace longitude_b = 120.7933 if location_b=="034931028"
* Angeles
replace latitude = 15.1399 if location=="035401"
replace longitude = 120.5879 if location=="035401"
	* Balibago
	replace latitude_b = 15.1663 if location_b=="035401003"
	replace longitude_b = 120.5901 if location_b=="035401003"
	* Pulung Maragul
	replace latitude_b = 15.1652 if location_b=="035401019"
	replace longitude_b = 120.6032 if location_b=="035401019"
* Apalit
replace latitude = 14.9502 if location=="035402"
replace longitude = 120.7599 if location=="035402"
	* Capalangan
	replace latitude_b = 14.9309 if location_b=="035402005"
	replace longitude_b = 120.7681 if location_b=="035402005"
* Bacolor
replace latitude = 14.9965 if location=="035404"
replace longitude = 120.6513 if location=="035404"
	* Cabalantian
	replace latitude_b = 15.0053 if location_b=="035404002"
	replace longitude_b = 120.6683 if location_b=="035404002"
* Candaba
replace latitude = 15.0925 if location=="035405"
replace longitude = 120.8276 if location=="035405"
	* Bahay Pare
	replace latitude_b = 15.0317 if location_b=="035405001"
	replace longitude_b = 120.8815 if location_b=="035405001"
* Floridablanca
replace latitude = 14.9759 if location=="035406"
replace longitude = 120.5287 if location=="035406"
	* Solib
	replace latitude_b = 14.9720 if location_b=="035406032"
	replace longitude_b = 120.5361 if location_b=="035406032"
* Lubao
replace latitude = 14.9378 if location=="035408"
replace longitude = 120.6004 if location=="035408"
	* San Roque Dau
	replace latitude_b = 14.9764 if location_b=="035408030"
	replace longitude_b = 120.5800 if location_b=="035408030"
* Mabalacat
replace latitude = 15.2228 if location=="035409"
replace longitude = 120.5733 if location=="035409"
	* Dolores
	replace latitude_b = 15.2352 if location_b=="035409009"
	replace longitude_b = 120.5680 if location_b=="035409009"
	* Lakandula
	replace latitude_b = 15.1737 if location_b=="035409011"
	replace longitude_b = 120.5840 if location_b=="035409011"
* Magalang
replace latitude = 15.2147 if location=="035411"
replace longitude = 120.6618 if location=="035411"
	* Santa Cruz, formerly Poblacion
	replace latitude_b = 15.2070 if location_b=="035411020"
	replace longitude_b = 120.6646 if location_b=="035411020"
* Masantol
replace latitude = 14.8845 if location=="035412"
replace longitude = 120.7098 if location=="035412"
	* Malauli
	replace latitude_b = 14.8308 if location_b=="035412012"
	replace longitude_b = 120.6758 if location_b=="035412012"
* Porac
replace latitude = 15.0723 if location=="035415"
replace longitude = 120.5411 if location=="035415"
	* Jalung
	replace latitude_b = 15.0658 if location_b=="035415014"
	replace longitude_b = 120.5355 if location_b=="035415014"
	* Pulong Santol
	replace latitude_b = 15.0479 if location_b=="035415028"
	replace longitude_b = 120.5584 if location_b=="035415028"
* San Fernando
replace latitude = 15.0292 if location=="035416"
replace longitude = 120.6928 if location=="035416"
	* Malpitic
	replace latitude_b = 15.0792 if location_b=="035416017"
	replace longitude_b = 120.6538 if location_b=="035416017"
* San Luis
replace latitude = 15.0393 if location=="035417"
replace longitude = 120.7908 if location=="035417"
	* San Jose
	replace latitude_b = 15.0030 if location_b=="035417004"
	replace longitude_b = 120.8704 if location_b=="035417004"
* Santo Tomas
replace latitude = 14.9939 if location=="035421"
replace longitude = 120.7045 if location=="035421"
	* Poblacion
	replace latitude_b = 14.9889 if location_b=="035421004"
	replace longitude_b = 120.7090 if location_b=="035421004"
* Camiling
replace latitude = 15.6887 if location=="036903"
replace longitude = 120.4140 if location=="036903"
	* Poblacion A
	replace latitude_b = 15.6903 if location_b=="036903043"
	replace longitude_b = 120.4161 if location_b=="036903043"
* Capas
replace latitude = 15.3361 if location=="036904"
replace longitude = 120.5899 if location=="036904"
	* Maruglu
	replace latitude_b = 15.3036 if location_b=="036904023"
	replace longitude_b = 120.4155 if location_b=="036904023"
* Concepcion
replace latitude = 15.3243 if location=="036905"
replace longitude = 120.6554 if location=="036905"
	* Santa Monica
	replace latitude_b = 15.3574 if location_b=="036905042"
	replace longitude_b = 120.7200 if location_b=="036905042"
* Gerona
replace latitude = 15.6069 if location=="036906"
replace longitude = 120.5985 if location=="036906"
	* Pinasling, formerly Pinasung
	replace latitude_b = 15.6018 if location_b=="036906027"
	replace longitude_b = 120.5895 if location_b=="036906027"
* Moncada
replace latitude = 15.7336 if location=="036909"
replace longitude = 120.5726 if location=="036909"
	* Camposanto 2
	replace latitude_b = 15.7368 if location_b=="036909015"
	replace longitude_b = 120.5674 if location_b=="036909015"
* Ramos
replace latitude = 15.6658 if location=="036912"
replace longitude = 120.6397 if location=="036912"
	* Poblacion North
	replace latitude_b = 15.6696 if location_b=="036912005"
	replace longitude_b = 120.6379 if location_b=="036912005"
* Tarlac City
replace latitude = 15.4859 if location=="036916"
replace longitude = 120.5895 if location=="036916"
	* Dolores
	replace latitude_b = 15.5229 if location_b=="036916035"
	replace longitude_b = 120.5785 if location_b=="036916035"
	* San Nicolas
	replace latitude_b = 15.4924 if location_b=="036916069"
	replace longitude_b = 120.5952 if location_b=="036916069"
* San Jose
replace latitude = 15.4578 if location=="036918"
replace longitude = 120.4683 if location=="036918"
	* Burgos
	replace latitude_b = 15.4949 if location_b=="036918001"
	replace longitude_b = 120.4039 if location_b=="036918001"
* Castillejos
replace latitude = 14.9301 if location=="037104"
replace longitude = 120.2051 if location=="037104"
	* San Nicolas
	replace latitude_b = 14.9269 if location_b=="037104012"
	replace longitude_b = 120.2017 if location_b=="037104012"
* Iba
replace latitude = 15.3264 if location=="037105"
replace longitude = 119.9786 if location=="037105"
	* Palanginan, formerly Palanguinan-Tambak
	replace latitude_b = 15.3139 if location_b=="037105012"
	replace longitude_b = 119.9945 if location_b=="037105012"
* Olongapo
replace latitude = 14.8314 if location=="037107"
replace longitude = 120.2835 if location=="037107"
	* Mabayuan
	replace latitude_b = 14.8427 if location_b=="037107013"
	replace longitude_b = 120.2819 if location_b=="037107013"
* San Felipe
replace latitude = 15.0610 if location=="037110"
replace longitude = 120.0702 if location=="037110"
	* Santo Niño
	replace latitude_b = 15.0606 if location_b=="037110011"
	replace longitude_b = 120.0624 if location_b=="037110011"
* Subic
replace latitude = 14.8774 if location=="037114"
replace longitude = 120.2344 if location=="037114"
	* Calapacuan
	replace latitude_b = 14.8594 if location_b=="037114008"
	replace longitude_b = 120.2446 if location_b=="037114008"
* Baler
replace latitude = 15.7595 if location=="037701"
replace longitude = 121.5627 if location=="037701"
	* Barangay I, formerly Poblacion
	replace latitude_b = 15.7601 if location_b=="037701001"
	replace longitude_b = 121.5609 if location_b=="037701001"
* Maria Aurora
replace latitude = 15.7982 if location=="037707"
replace longitude = 121.4723 if location=="037707"
	* Diaman
	replace latitude_b = 15.7449 if location_b=="037707019"
	replace longitude_b = 121.4468 if location_b=="037707019"

** V
* Camalig
replace latitude = 13.1815 if location=="050502"
replace longitude = 123.6552 if location=="050502"
	* Baligang
	replace latitude_b = 13.1522 if location_b=="050502002"
	replace longitude_b = 123.6428 if location_b=="050502002"
* Daraga, formerly known as Locsin
replace latitude = 13.1478 if location=="050503"
replace longitude = 123.7131 if location=="050503"
	* Ilawod Area Poblacion, formerly Dist. 2
	replace latitude_b = 13.1470 if location_b=="050503022"
	replace longitude_b = 123.7146 if location_b=="050503022"
	* Pandan
	replace latitude_b = 13.1554 if location_b=="050503041"
	replace longitude_b = 123.6885 if location_b=="050503041"
* Legazpi
replace latitude = 13.1388 if location=="050506"
replace longitude = 123.7343 if location=="050506"
	* Barangay 2-Em's Barrio South, formerly Poblacion
	replace latitude_b = 13.1424 if location_b=="050506016"
	replace longitude_b = 123.7247 if location_b=="050506016"
	* Barangay 56-Taysan, formerly Barangay 68
	replace latitude_b = 13.1160 if location_b=="050506070"
	replace longitude_b = 123.7437 if location_b=="050506070"
* Libon
replace latitude = 13.2998 if location=="050507"
replace longitude = 123.4384 if location=="050507"
	* Sagrada Familia
	replace latitude_b = 13.2718 if location_b=="050507034"
	replace longitude_b = 123.3965 if location_b=="050507034"
* Malilipot
replace latitude = 13.3190 if location=="050509"
replace longitude = 123.7393 if location=="050509"
	* Calbayog
	replace latitude_b = 13.2876 if location_b=="050509002"
	replace longitude_b = 123.7304 if location_b=="050509002"
* Oas
replace latitude = 13.2575 if location=="050512"
replace longitude = 123.5002 if location=="050512"
	* Ilaor Sur
	replace latitude_b = 13.2586 if location_b=="050512025"
	replace longitude_b = 123.4983 if location_b=="050512025"
* Polangui
replace latitude = 13.2937 if location=="050514"
replace longitude = 123.4843 if location=="050514"
	* La Medalla
	replace latitude_b = 13.3483 if location_b=="050514025"
	replace longitude_b = 123.4703 if location_b=="050514025"
* Tabaco
replace latitude = 13.3592 if location=="050517"
replace longitude = 123.7298 if location=="050517"
	* Cormidal
	replace latitude_b = 13.3611 if location_b=="050517017"
	replace longitude_b = 123.7348 if location_b=="050517017"
* Basud
replace latitude = 14.0658 if location=="051601"
replace longitude = 122.9629 if location=="051601"
	* San Pascual
	replace latitude_b = 13.9428 if location_b=="051601028"
	replace longitude_b = 123.0207 if location_b=="051601028"
* Daet
replace latitude = 14.1132 if location=="051603"
replace longitude = 122.9559 if location=="051603"
	* Barangay IV, formerly Poblacion
	replace latitude_b = 14.1170 if location_b=="051603027"
	replace longitude_b = 122.9496 if location_b=="051603027"
* Jose Panganiban
replace latitude = 14.2898 if location=="051605"
replace longitude = 122.6917 if location=="051605"
	* San Isidro
	replace latitude_b = 14.2516 if location_b=="051605017"
	replace longitude_b = 122.6556 if location_b=="051605017"
* Mercedes
replace latitude = 14.1094 if location=="051607"
replace longitude = 123.0093 if location=="051607"
	* Barangay VII, formerly Poblacion
	replace latitude_b = 14.1093 if location_b=="051607008"
	replace longitude_b = 123.0126 if location_b=="051607008"
* Talisay
replace latitude = 14.1371 if location=="051611"
replace longitude = 122.9256 if location=="051611"
	* Poblacion
	replace latitude_b = 14.1362 if location_b=="051611008"
	replace longitude_b = 122.9237 if location_b=="051611008"
* Bato
replace latitude = 13.3572 if location=="051703"
replace longitude = 123.3677 if location=="051703"
	* Buluang
	replace latitude_b = 13.3043 if location_b=="051703003"
	replace longitude_b = 123.3416 if location_b=="051703003"
* Buhi
replace latitude = 13.4342 if location=="051705"
replace longitude = 123.5165 if location=="051705"
	* Lourdes, formerly Santa Lourdes
	replace latitude_b = 13.4077 if location_b=="051705040"
	replace longitude_b = 123.5038 if location_b=="051705040"
* Calabanga
replace latitude = 13.7083 if location=="051708"
replace longitude = 123.2167 if location=="051708"
	* San Lucas
	replace latitude_b = 13.7116 if location_b=="051708036"
	replace longitude_b = 123.1931 if location_b=="051708036"
* Gainza
replace latitude = 13.6130 if location=="051713"
replace longitude = 123.1310 if location=="051713"
	* Malbong
	replace latitude_b = 13.6139 if location_b=="051713005"
	replace longitude_b = 123.1306 if location_b=="051713005"
* Iriga
replace latitude = 13.4222 if location=="051716"
replace longitude = 123.4129 if location=="051716"
	* San Agustin
	replace latitude_b = 13.4481 if location_b=="051716013"
	replace longitude_b = 123.3967 if location_b=="051716013"
	* Santa Elena
	replace latitude_b = 13.4133 if location_b=="051716030"
	replace longitude_b = 123.4437 if location_b=="051716030"
* Libmanan
replace latitude = 13.6938 if location=="051718"
replace longitude = 123.0620 if location=="051718"
	* Palong
	replace latitude_b = 13.6333 if location_b=="051718051"
	replace longitude_b = 122.9700 if location_b=="051718051"
* Minalabac
replace latitude = 13.5708 if location=="051722"
replace longitude = 123.1851 if location=="051722"
	* Del Socorro
	replace latitude_b = 13.4762 if location_b=="051722008"
	replace longitude_b = 123.1691 if location_b=="051722008"
* Naga
replace latitude = 13.6240 if location=="051724"
replace longitude = 123.1850 if location=="051724"
	* Concepcion Pequeña
	replace latitude_b = 13.6150 if location_b=="051724010"
	replace longitude_b = 123.2028 if location_b=="051724010"
* Ocampo
replace latitude = 13.5635 if location=="051725"
replace longitude = 123.3724 if location=="051725"
	* Hibago
	replace latitude_b = 13.5611 if location_b=="051725008"
	replace longitude_b = 123.3955 if location_b=="051725008"
* Pasacao
replace latitude = 13.5096 if location=="051727"
replace longitude = 123.0441 if location=="051727"
	* San Cirilo, formerly Poblacion
	replace latitude_b = 13.5103 if location_b=="051727015"
	replace longitude_b = 123.0449 if location_b=="051727015"
* Pili
replace latitude = 13.5543 if location=="051728"
replace longitude = 123.2747 if location=="051728"
	* Santiago, formerly Poblacion
	replace latitude_b = 13.5539 if location_b=="051728023"
	replace longitude_b = 123.2776 if location_b=="051728023"
* San Fernando
replace latitude = 13.5640 if location=="051732"
replace longitude = 123.1436 if location=="051732"
	* Maragñi
	replace latitude_b = 13.5095 if location_b=="051732014"
	replace longitude_b = 123.0895 if location_b=="051732014"
* Tigaon
replace latitude = 13.6331 if location=="051736"
replace longitude = 123.4947 if location=="051736"
	* Caraycayon
	replace latitude_b = 13.6142 if location_b=="051736003"
	replace longitude_b = 123.4892 if location_b=="051736003"
* Bato
replace latitude = 13.6079 if location=="052003"
replace longitude = 124.2970 if location=="052003"
	* Banawang
	replace latitude_b = 13.6034 if location_b=="052003003"
	replace longitude_b = 124.2981 if location_b=="052003003"
* San Miguel
replace latitude = 13.6421 if location=="052009"
replace longitude = 124.3031 if location=="052009"
	* Mabato
	replace latitude_b = 13.6929 if location_b=="052009012"
	replace longitude_b = 124.2983 if location_b=="052009012"
* Aroroy
replace latitude = 12.5118 if location=="054101"
replace longitude = 123.3975 if location=="054101"
	* Malubi
	replace latitude_b = 12.3932 if location_b=="054101020"
	replace longitude_b = 123.4035 if location_b=="054101020"
* Cataingan
replace latitude = 12.0002 if location=="054105"
replace longitude = 123.9966 if location=="054105"
	* Madamba
	replace latitude_b = 11.9888 if location_b=="054105018"
	replace longitude_b = 124.0176 if location_b=="054105018"
* Claveria
replace latitude = 12.9029 if location=="054107"
replace longitude = 123.2457 if location=="054107"
	* Imelda
	replace latitude_b = 12.8994 if location_b=="054107022"
	replace longitude_b = 123.1842 if location_b=="054107022"
* Masbate City
replace latitude = 12.3689 if location=="054111"
replace longitude = 123.6205 if location=="054111"
	* Nursery
	replace latitude_b = 12.3633 if location_b=="054111024"
	replace longitude_b = 123.6282 if location_b=="054111024"
* Milagros
replace latitude = 12.2182 if location=="054112"
replace longitude = 123.5082 if location=="054112"
	* Bacolod
	replace latitude_b = 12.2381 if location_b=="054112001"
	replace longitude_b = 123.5070 if location_b=="054112001"
* Palanas
replace latitude = 12.1459 if location=="054115"
replace longitude = 123.9218 if location=="054115"
	* San Carlos
	replace latitude_b = 12.0701 if location_b=="054115022"
	replace longitude_b = 123.9143 if location_b=="054115022"
* San Jacinto
replace latitude = 12.5669 if location=="054119"
replace longitude = 123.7318 if location=="054119"
	* Luna
	replace latitude_b = 12.5372 if location_b=="054119011"
	replace longitude_b = 123.7120 if location_b=="054119011"
* Barcelona
replace latitude = 12.8663 if location=="056202"
replace longitude = 124.1451 if location=="056202"
	* Poblacion Central
	replace latitude_b = 12.8662 if location_b=="056202018"
	replace longitude_b = 124.1440 if location_b=="056202018"
* Bulusan
replace latitude = 12.7518 if location=="056204"
replace longitude = 124.1371 if location=="056204"
	* Santa Barbara
	replace latitude_b = 12.7970 if location_b=="056204022"
	replace longitude_b = 124.1260 if location_b=="056204022"
* Donsol
replace latitude = 12.9077 if location=="056207"
replace longitude = 123.5986 if location=="056207"
	* Vinisitahan
	replace latitude_b = 12.9498 if location_b=="056207051"
	replace longitude_b = 123.5493 if location_b=="056207051"
* Juban
replace latitude = 12.8476 if location=="056210"
replace longitude = 123.9894 if location=="056210"
	* Catanagan
	replace latitude_b = 12.8557 if location_b=="056210010"
	replace longitude_b = 123.9705 if location_b=="056210010"
* Pilar
replace latitude = 12.9231 if location=="056213"
replace longitude = 123.6741 if location=="056213"
	* Inapugan
	replace latitude_b = 12.8749 if location_b=="056213024"
	replace longitude_b = 123.6943 if location_b=="056213024"
* Sorsogon City
replace latitude = 12.9707 if location=="056216"
replace longitude = 124.0052 if location=="056216"
	* Sampaloc, formerly Poblacion
	replace latitude_b = 12.9709 if location_b=="056216030"
	replace longitude_b = 124.0097 if location_b=="056216030"
	
save, replace

clear
