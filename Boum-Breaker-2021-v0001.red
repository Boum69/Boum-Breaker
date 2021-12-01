Red [
	Title: "Boum_Breaker_2021"
	Author: "Boumedienne Antar"
	Purpose: "Casse briques"    
	Copyright: "Boumedienne Antar. All rights reserved."
	License: "BSD-3 - https:;//github.com/red/red/blob/master/BSD-3-License.txt"
    icon: %./icones/Boum_breaker.ico
	Needs: View
    version: 0.0.0.1
    Credits: {
    Credit to @oldes for bass.red library
    }
]


son?: true
;son?: false
BILLES_RESTANTES: 0
media: [%bass.red %bass.reds]
;-- download them if not exists...
foreach file media [
	unless exists? file [
		url: rejoin [https://github.com/Oldes/code/blob/master/Library/Bass/ file]
		print ["Downloading file:" mold file "from:" url]
		write/binary file read/binary rejoin [url %?raw=true]
	]
]
#include %bass.red
if son? [
bass/init
bass/do [
music1: load %feroness_-_sun.mod   
music2: load %abyss_5.mod  
son-rebond: load %./wav/boink.wav
son-ow: load %./wav/ow.wav
son-pickup2: load %./wav/pickup2.wav
son-tir1: load %./wav/tir1.wav
son-loupe: load %./wav/loupe.wav
son-loupe2: load %./wav/loupe2.wav
]
]
end?: false
begin?: true
tempsNiveau: to-time 0
;ecran total
size_scrn: 1140x850  ;= lay_brique + bandeau inférieur (mouvements souris)
;;Divers    
brik: 100
config1?: false
config2?: true
color_bille: copy [] 
if config1? [repeat i 5 [append color_bille silver]]
if config2? [color_bille: copy [silver green red blue yellow]]
bille1_alive?: true bille2_alive?: false bille3_alive?: false bille4_alive?: false bille5_alive?: false
pause?: false
vmax: 2.4
vmin: 1
;;;Bonus
bonus_loupes: 0
taille_bonus: 4 ; choisir entre 2, 3, 4 et 5 (2 = 11X11 ;3 = 20x20 ;4 = 25x25 ;5 = 30x30 )
listeBonus: []
bko: load %./img/byakko.gif
rbico: load %./img/Boum_Breaker.gif
B5K2: load %./img/bonus2.gif
B5K3: load %./img/bonus3.gif
B5K4: load %./img/bonus4.gif
B5K5: load %./img/bonus5.gif
DTH2: load %./img/crane2.gif
DTH3: load %./img/crane3.gif
DTH4: load %./img/crane4.gif
DTH5: load %./img/crane5.gif
LFE2: load %./img/coeur2.gif
LFE3: load %./img/coeur3.gif
LFE4: load %./img/coeur4.gif
LFE5: load %./img/coeur5.gif
BIG2: load %./img/larger2.gif
BIG3: load %./img/larger3.gif
BIG4: load %./img/larger4.gif
BIG5: load %./img/larger5.gif
SML2: load %./img/smaller2.gif
SML3: load %./img/smaller3.gif
SML4: load %./img/smaller4.gif
SML5: load %./img/smaller5.gif
SPD2: load %./img/rabbit2.gif
SPD3: load %./img/rabbit3.gif
SPD4: load %./img/rabbit4.gif
SPD5: load %./img/rabbit5.gif
SLO2: load %./img/tortue2.gif
SLO3: load %./img/tortue3.gif
SLO4: load %./img/tortue4.gif
SLO5: load %./img/tortue5.gif
NBL2: load %./img/new_ball2.gif
NBL3: load %./img/new_ball3.gif
NBL4: load %./img/new_ball4.gif
NBL5: load %./img/new_ball5.gif
WP12: load %./img/WPN12.gif
WP13: load %./img/WPN13.gif
WP14: load %./img/WPN14.gif
WP15: load %./img/WPN15.gif
WP22: load %./img/WPN22.gif
WP23: load %./img/WPN23.gif
WP24: load %./img/WPN24.gif
WP25: load %./img/WPN25.gif
DBL2: load %./img/DBL2.gif
DBL3: load %./img/DBL3.gif
DBL4: load %./img/DBL4.gif
DBL5: load %./img/DBL5.gif
TPL2: load %./img/TPL2.gif
TPL3: load %./img/TPL3.gif
TPL4: load %./img/TPL4.gif
TPL5: load %./img/TPL5.gif
repeat i 5 [append listeBonus reduce to-word rejoin ["SLO" taille_bonus]]
repeat i 15 [append listeBonus reduce to-word rejoin [ "SPD" taille_bonus]]
repeat i 8 [append listeBonus reduce to-word rejoin [ "DTH" taille_bonus]]
repeat i 2 [append listeBonus reduce to-word rejoin [ "LFE" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "BIG" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "SML" taille_bonus]]
repeat i 30 [append listeBonus reduce to-word rejoin [ "B5K" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "NBL" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP1" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP2" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "DBL" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "TPL" taille_bonus]]
SPDnumber: 0
SLOnumber: 0
LFEnumber: 0
DTHnumber: 0
B5Knumber: 0
BIGnumber: 0
SMLnumber: 0
NBLnumber: 0
WPN1number: 0
WPN2number: 0
DBLnumber: 0
TPLnumber: 0
;RAQUETTE
pos: 500x480
longRaq: 62
epRaq: 10
dimRaq: as-pair longRaq epRaq
pos1Raq: 0x0
pos2Raq: 80x15
;;WEPONS
color_weapon: gold
doubledot?: false
tir1?: false
weapon1?: false
touche1?: false
weapon12?: false
touche12?: false
weapon13?: false
touche13?: false
dimwpn1: 10x8
poswpn1: -10x0
dimwpn12: 10x8
poswpn12: -10x0
dimwpn13: 16x10
poswpn13: -16x0
tir2?: false
weapon2?: false
touche2?: false
weapon22?: false
touche22?: false
weapon23?: false
touche23?: false
double?: false
triple?: false
dimwpn2: 10x8
poswpn2: -10x0
dimwpn22: 10x8
poswpn22: -10x0
dimwpn23: 16x10
poswpn23: -16x0
;;billes
p: 0
p2: 0
p3: 0
p4: 0
p5: 0
p6: 0
p62: 0
p63: 0
p7: 0
p72: 0
p73: 0
i: 0
j: 0
k: 0
l: 0
m: 0
n: 0
n12: 0
n13: 0
n2: 0
n22: 0
n23: 0 
paire: 0x0
bille1?: false
bille2?: false
bille3?: false
bille4?: false
bille5?: false
;briques
ecart: 5
;RAQUETTE
cond1: false
cond2: true
cond12: false
cond22: true
cond13: false
cond23: true
cond14: false
cond24: true
cond15: false
cond25: true
Arial0: make font! [size: 8 name: "Cooper" style: 'bold]
Arial1: make font! [size: 10 name: "Cooper" style: 'bold]
Arial2: make font! [size: 12 name: "Cooper" style: 'bold]
Arial3: make font! [size: 16 name: "Cooper" style: 'bold]
posbille1:  ((size_scrn / 2) + 0x-100)
posbille2:  -10x0
posbille3:  -10x0
posbille4:  -10x0
posbille5:  -10x0
r2: 15
v2: 1.8
life: 5
pairP: 0x4
pairp2: 0x4
pairp3: 0x4
pairp4: 0x4
pairp5: 0x4
score: 0
impacts: 0 
col: []
repeat i 5 [
    temp: random 120.120.120
    temp: as-rgba temp/1 temp/2 temp/3 50
    repeat j 20 [
    append col reduce [temp]
    ]
    ]
init-game: does [
clear_bonus
clear_wpn1
clear_wpn2
death3
begin?: true
pause_game
SPDnumber: 0 SLOnumber: 0 LFEnumber: 0 DTHnumber: 0 B5Knumber: 0 BIGnumber: 0 SMLnumber: 0 NBLnumber: 0 WPN1number: 0 WPN2number: 0 DBLnumber: 0 TPLnumber: 0
;RAQUETTE
pos: 500x480 longRaq: 62 epRaq: 10 dimRaq: as-pair longRaq epRaq pos1Raq: 0x0 pos2Raq: 80x15
;;WEPONS
color_weapon: gold doubledot?: false tir1?: false weapon1?: false touche1?: false weapon12?: false touche12?: false weapon13?: false touche13?: false
dimwpn1: 10x8 poswpn1: -10x0 dimwpn12: 10x8 poswpn12: -10x0 dimwpn13: 16x10 poswpn13: -16x0
tir2?: false weapon2?: false touche2?: false weapon22?: false touche22?: false weapon23?: false touche23?: false
double?: false triple?: false dimwpn2: 10x8
poswpn2: -10x0 dimwpn22: 10x8 poswpn22: -10x0 dimwpn23: 16x10 poswpn23: -16x0
;;billes
p: 0 p2: 0 p3: 0 p4: 0 p5: 0 p6: 0 p62: 0 p63: 0 p7: 0 p72: 0 p73: 0 i: 0 j: 0 k: 0 l: 0 m: 0 n: 0 n12: 0 n13: 0 n2: 0 n22: 0 n23: 0 
paire: 0x0 bille1?: false bille2?: false bille3?: false bille4?: false bille5?: false
;RAQUETTE
cond1: false cond2: true cond12: false cond22: true cond13: false cond23: true cond14: false cond24: true cond15: falsecond25: true
posbille1:  ((size_scrn / 2) + 0x-100) posbille2:  -10x0 posbille3:  -10x0 posbille4:  -10x0 posbille5:  -10x0
r2: 15 v2: 1.8 pairP: 0x4 pairp2: 0x4 pairp3: 0x4 pairp4: 0x4 pairp5: 0x4 impacts: 0 col: []
repeat i 5 [
    temp: random 120.120.120
    temp: as-rgba temp/1 temp/2 temp/3 50
    repeat j 20 [
    append col reduce [temp]
    ]
    ]
couleurs: [0.0.128 76.26.0 72.0.90 0.48.0 64.64.64]
random/seed now
couleurs: random couleurs 
coul-temp: pick couleurs random (length? couleurs)
lay_brique/color: coul-temp
text_pause/color: coul-temp
clear lay_brique/draw
        repeat i 100 [append lay_brique/draw reduce ['fill-pen (pick col i) 'box (as-pair pick listeAbs i pick listeOrd i) (as-pair ((pick listeAbs i) + (pick listeLong i)) ((pick listeOrd i) + (pick listeLarg i)))]]
        append lay_brique/draw reduce ['pen (coul-temp)]
         repeat i 100 [
            append lay_brique/draw reduce [
                'line (as-pair ((pick listeAbs i) + ecart) (pick listeord i)) (as-pair ((pick listeAbs i) + ecart)((pick listeord i) + (pick listelarg i)))
                'line (as-pair ((pick listeAbs i) + (pick listeLong i) - ecart) (pick listeord i)) (as-pair ((pick listeAbs i) + (pick listeLong i) - ecart) ((pick listeOrd i) + (pick listeLarg i)))
                'line (as-pair (pick listeAbs i) ((pick listeord i) + ecart)) (as-pair ((pick listeAbs i) + (pick listeLong i)) ((pick listeord i) + ecart))
                'line (as-pair (pick listeAbs i) ((pick listeord i) + (pick listelarg i) - ecart))  (as-pair ((pick listeAbs i) + (pick listelong i)) ((pick listeord i) + (pick listelarg i) - ecart))
                ]
    ]
poke titre/draw 26 "00:00" poke titre/draw 39 "0" poke titre/draw 42 "0" poke titre/draw 45 "0" poke titre/draw 48 "0"  poke titre/draw 51 "0" poke titre/draw 54 "0" poke titre/draw 57 "0" poke titre/draw 60 "0" poke titre/draw 63 "0" poke titre/draw 66 "0" poke titre/draw 69 "0" poke titre/draw 72 "0"    
]
init-level2: does [
brik: 100
repeat i 5 [append listeBonus reduce to-word rejoin ["SLO" taille_bonus]]
repeat i 15 [append listeBonus reduce to-word rejoin [ "SPD" taille_bonus]]
repeat i 8 [append listeBonus reduce to-word rejoin [ "DTH" taille_bonus]]
repeat i 2 [append listeBonus reduce to-word rejoin [ "LFE" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "BIG" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "SML" taille_bonus]]
repeat i 30 [append listeBonus reduce to-word rejoin [ "B5K" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "NBL" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP1" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP2" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "DBL" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "TPL" taille_bonus]]
ecart: 5 
listeAbs: copy [
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
40 90 140 190 240 290 340 390 440 490 540 590 640 690 740 790 840 890 940 990
30 80 130 180 230 280 330 380 430 480 530 580 630 680 730 780 830 880 930 980
20 70 120 170 220 270 320 370 420 470 520 570 620 670 720 770 820 870 920 970
10 60 110 160 210 260 310 360 410 460 510 560 610 660 710 760 810 860 910 960
]
listeOrd: copy [
100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100
140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140
180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180
220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220
260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260
]
listeLong: copy [
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
]
listeLarg: copy [
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
]
listeVie: copy [
5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
]
poke titre/draw (length? titre/draw) "2"
if son? [
bass/free
bass/init
bass/do [	
	channel: play music2 [volume: 0.8]     
]
]
]
init-level1: does [
end?: false
score: 0
brik: 100
repeat i 5 [append listeBonus reduce to-word rejoin ["SLO" taille_bonus]]
repeat i 15 [append listeBonus reduce to-word rejoin [ "SPD" taille_bonus]]
repeat i 8 [append listeBonus reduce to-word rejoin [ "DTH" taille_bonus]]
repeat i 2 [append listeBonus reduce to-word rejoin [ "LFE" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "BIG" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "SML" taille_bonus]]
repeat i 30 [append listeBonus reduce to-word rejoin [ "B5K" taille_bonus]]
repeat i 10 [append listeBonus reduce to-word rejoin [ "NBL" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP1" taille_bonus]]
repeat i 5 [append listeBonus reduce to-word rejoin [ "WP2" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "DBL" taille_bonus]]
repeat i 3 [append listeBonus reduce to-word rejoin [ "TPL" taille_bonus]]
ecart: 5 
listeAbs: copy [
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
]
listeOrd: copy [
100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100
140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140
180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180
220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220
260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260
]
listeLong: copy [
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
]
listeLarg: copy [
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
]
listeVie: copy [
5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
]
poke titre/draw (length? titre/draw) "1"
if son? [
bass/free
bass/init
bass/do [
	channel: play music1 [volume: 1.0] 
]
]
]
ddot: does [doubledot?: true]
checkbrik: DOES [brik: brik - 1 if brik = 0 [
pause_game if son? [bass/do [play son-rebond]]
BILLES_RESTANTES: 0 
either bille1_alive? [ball1: 1][ball1: 0]
either bille2_alive? [ball2: 1][ball2: 0]
either bille3_alive? [ball3: 1][ball3: 0]
either bille4_alive? [ball4: 1][ball4: 0]
either bille5_alive? [ball5: 1][ball5: 0]
BILLES_RESTANTES: BILLES_RESTANTES + ball1 + ball2 + ball3 + ball4 + ball5
FINAL_SCORE: (SCORE * BILLES_RESTANTES) + (SPDnumber * 1000) + (SLOnumber * 10) + (LFEnumber * 10000) + (DTHnumber * 100) + (BIGnumber * 10) + (SMLnumber * 100) + (NBLnumber * 100) +(WPN1number * 100) + (WPN2number * 10) + (DBLnumber * 15) + (TPLnumber * 5)
;SCORE: FINAL_SCORE
nivo: pick titre/draw (length? titre/draw)
either not equal? nivo "2" [
poke titre/draw (length? titre/draw) (form ((to-integer nivo) + 1)) 
end?: false
]
[
end?: true
;alert "JEU TERMINÉ - Boum BREAKER 2021 - copyright: BOUM -"
]
either end? [str-end: "JEU TERMINÉ"][str-end: "NIVEAU TERMINÉ"]
fen2: copy [
    title "Boum Breaker 2021"
    size 500x560
    at 0x0 base snow 500x520 draw reduce [
    'font Arial1
    'pen rebolor
    'text 167x20 "- Boum BREAKER 2021 - "
    'font Arial2
    'pen black
    'text 175x45 str-end
    'pen black
    'text 82x80 form reduce [" x 1000 = " (SPDnumber * 1000)]
    'text 82x120 form reduce [" x 10 = " (SLOnumber * 10)]
    'text 82x160 form reduce [" x 10000 = " (LFEnumber * 10000)]
    'text 82x200 form reduce [" x 100 = " (DTHnumber * 100)]
    'text 82x240 form reduce [" x 10 = " (BIGnumber * 10)]
    'text 82x280 form reduce [" x 100 = " (SMLnumber * 100)]
    'text 315x80 form reduce [" x 100 = " (NBLnumber * 100)]
    'text 315x120 form reduce [" x 100 = " (WPN1number * 100)]
    'text 315x160 form reduce [" x 10 = " (WPN2number * 10)]
    'text 315x200 form reduce [" x 15 = " (DBLnumber * 15)]
    'text 315x240 form reduce [" x 5 = " (TPLnumber * 5)]
    'text 55x355 form reduce ["SCORE: " SCORE] 'text 229x355 form reduce ["SCORE x "]
    'pen gray 'fill-pen gray
    'circle 323x363 6
    'pen leaf
    'text 348x355 form reduce [" = "(SCORE * BILLES_RESTANTES)]
    'font Arial3
    'text 135x434 form reduce ["SCORE FINAL: " ((SCORE * BILLES_RESTANTES) + (SPDnumber * 1000) + (SLOnumber * 10) + (LFEnumber * 10000) + (DTHnumber * 100) + (BIGnumber * 10) + (SMLnumber * 100) + (NBLnumber * 100) +(WPN1number * 100) + (WPN2number * 10) + (DBLnumber * 15) + (TPLnumber * 5))] 
    'font Arial0
    'pen silver
    'text 25x480 "Boum BREAKER 2021 copyright: BOUMEDIENNE Antar #BoumPhoenix"
    'text 435x480 "powa xD"
      ]
       ]
either end? [append fen2 reduce ['button "REPLAY" [init-level1 init_game init-game unview fen2]]][append fen2 reduce ['button "OK" [init-level2 init_game init-game unview fen2]]]
append fen2  [
    at 50x80 image SPD3
    at 50x120 image SLO3
    at 50x160 image LFE3
    at 50x200 image DTH3
    at 50x240 image BIG3
    at 50x280 image SML3
    at 285x80 image NBL3
    at 285x120 image WP13
    at 285x160 image WP23
    at 285x200 image DBL3
   at 285x240 image TPL3
   at 134x13 image rbico 24x24
   at 324x13 image rbico 24x24
   at 375x470 image bko 55x25
    ]

    fen2: layout fen2
    view fen2
    ]
]
load1: does [tir2?: false if not tir1? [tir1?: true ] color_weapon: red poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
load2: does [tir1?: false if not tir2? [tir2?: true ] color_weapon: cyan poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
add_ball: does [
if son? [bass/do [play son-loupe2]]
    either not bille1_alive? [bille1_alive?: true bille1/offset: ((size_scrn / 2) + 0x-100) pairP: 0x4][
        either not bille2_alive? [bille2_alive?: true bille2/offset: ((size_scrn / 2) + 0x-100) pairP2: 0x4][
            either not bille3_alive? [bille3_alive?: true bille3/offset: ((size_scrn / 2) + 0x-100) pairP3: 0x4][
                either not bille4_alive? [bille4_alive?: true bille4/offset: ((size_scrn / 2) + 0x-100) pairP4: 0x4][
                    if not bille5_alive? [bille5_alive?: true bille5/offset: ((size_scrn / 2) + 0x-100) pairP5: 0x4]
                        ]
                    ]
                ]
            ]
        ]
init_game: does [
    poke titre/draw 34 (form ((SCORE * BILLES_RESTANTES) + (SPDnumber * 1000) + (SLOnumber * 10) + (LFEnumber * 10000) + (DTHnumber * 100) + (BIGnumber * 10) + (SMLnumber * 100) + (NBLnumber * 100) +(WPN1number * 100) + (WPN2number * 10) + (DBLnumber * 15) + (TPLnumber * 5)))
    bille1_alive?: true 
    double?: false
    doubledot?: false
    triple?: false
    bille1/offset: ((size_scrn / 2) + 0x-100)
    tir1?: false tir2?: false color_weapon: gold
    pairP: 0x4
    pairp2: 0x4
    pairp3: 0x4
    pairp4: 0x4
    pairp5: 0x4
    raquette/size/x: 62
    longRaq: 62
    clear raquette/draw
    append raquette/draw reduce [    
                            'pen silver
                            'fill-pen red
                            'circle 5x5 5 
                            'circle 55x5 5 
                            'fill-pen gold
                            'box 5x0 55x10
                            'fill-pen gold
                            'box 25x0 36x3
                            'fill-pen gold
                            'box 25x0 36x3
                             'fill-pen gold
                            'box 25x0 36x3                           
                            ]
    raquette/offset: 500x480                         
    v2: 1.8 poke titre/draw 10  form round/to v2 0.01
 ]
clear_wpn1: does [if weapon1? [touche1?: false weapon1?: false wpn1/offset: -20x10] if weapon12? [touche12?: false weapon12?: false wpn12/offset: -20x10] if weapon13? [touche13?: false weapon13?: false wpn13/offset: -20x10]]
clear_wpn2: does [if weapon2? [touche2?: false weapon2?: false wpn2/offset: -20x10] if weapon22? [touche22?: false weapon22?: false wpn22/offset: -20x10] if weapon23? [touche23?: false weapon23?: false wpn23/offset: -20x10]]
ballloss: does [if all [(not bille1_alive?) (not bille2_alive?) (not bille3_alive?) (not bille4_alive?) (not bille5_alive?)]  [death]]
clear_bonus: does [repeat i 100 [test: reduce to-word rejoin ["b" i]  if test/offset <> -50x0 [test/offset: -50x0 bonus_loupes: bonus_loupes + 1]]]
pause_game: does [
pause?: true either pause? [text_pause/offset: 500x300 bille1/rate: none bille2/rate: none bille3/rate: none bille4/rate: none bille5/rate: none titre/rate: none][
text_pause/offset: -100x0 bille1/rate: 25 bille2/rate: 25 bille3/rate: 25 bille4/rate: 25 bille5/rate: 25 titre/rate: 25
]
]
bigger: does [
    if not equal? raquette/size/x 202 [
        raquette/size/x: raquette/size/x + 20 
        longRaq: longRaq + 20
        newpos1: (as-pair ((pick (pick raquette/draw 6) 1) + longRaq - 10) 5)
        newpos2: (as-pair ((pick (pick raquette/draw 6) 1) + longRaq - 10) 10)
         if all [not double? not triple?] [
         newpos3: (as-pair ((longraq / 2) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5:  newpos3
        newpos6: newpos4
        newpos7:  newpos3
        newpos8: newpos4        
        ]
        if all [not triple? double?][
        newpos3: (as-pair ((longraq  / 3) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5:  (as-pair (((longraq * 2) / 3) - 6) 0)
        newpos6: newpos5 + 11x3
        newpos7: newpos5
        newpos8: newpos6    
            ]
        if all [not double? triple?][
        newpos3: (as-pair ((longraq  / 4) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5:  (as-pair (((longraq * 3) / 4) - 6) 0)
        newpos6: newpos5 + 11x3 
        newpos7:  (as-pair ((longraq / 2) - 8) 0)
        newpos8: newpos7 + 16x6     
            ]
        clear raquette/draw
        append raquette/draw reduce [
                            'pen silver
                            'fill-pen red
                            'circle 5x5 5 
                            'circle newpos1 5 
                            'fill-pen gold
                            'box 5x0 newpos2
                            'fill-pen color_weapon
                            'box newpos3 newpos4
                            'fill-pen color_weapon
                            'box newpos5 newpos6
                            'fill-pen color_weapon
                            'box newpos7 newpos8
                            ]
        raquette/offset/x: raquette/offset/x - 10
        ]
]
smaller: does [
    if not equal? raquette/size/x 62 [
        raquette/size/x: raquette/size/x - 20 
        longRaq: longRaq - 20
        newpos1: (as-pair ((pick (pick raquette/draw 6) 1) + longRaq - 10) 5)
         newpos2: (as-pair ((pick (pick raquette/draw 6) 1) + longRaq - 10) 10)
         if all [not double? not triple?] [
        newpos3: (as-pair ((longraq / 2) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5: newpos3
        newpos6: newpos4
        newpos7: newpos3
        newpos8: newpos4
        ]
        if all [not triple? double?][
        newpos3: (as-pair ((longraq  / 3) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5: (as-pair (((longraq * 2) / 3) - 6) 0)
        newpos6: newpos5 + 11x3
        newpos7: newpos5
        newpos8: newpos6
        ]
        if all [not double? triple?][
        newpos3: (as-pair ((longraq  / 4) - 6) 0)
        newpos4: newpos3 + 11x3
        newpos5: (as-pair (((longraq * 3) / 4) - 6) 0)
        newpos6: newpos5 + 11x3
        newpos7: (as-pair ((longraq / 2) - 8) 0)
        newpos8: newpos7 + 16x6    
        ]
        clear raquette/draw
        append raquette/draw reduce [    
                            'pen silver
                            'fill-pen red
                            'circle 5x5 5 
                            'circle newpos1 5 
                            'fill-pen gold
                            'box 5x0 newpos2
                            'fill-pen color_weapon
                            'box newpos3 newpos4
                            'fill-pen color_weapon
                            'box newpos5 newpos6
                            'fill-pen color_weapon
                            'box newpos7 newpos8
                            ]
        raquette/offset/x: raquette/offset/x + 10
        ]
]
birth: does [if son? [bass/do [play son-pickup2]] life: life + 1 poke titre/draw 18 (form life)]
death: does [if son? [bass/do [play son-ow]] life: life - 1 poke titre/draw 18 (form life) either life = 0 [if son? [bass/do [play son-rebond]] alert "GAME OVER" if son? [bass/free] quit][clear_bonus clear_wpn1 init_game pause_game]]
death2: does [bille1_alive?: false bille2_alive?: false bille3_alive?: false bille4_alive?: false bille5_alive?: false bille1/offset: -10x0 bille2/offset: -10x0 bille3/offset: -10x0 bille4/offset: -10x0 bille5/offset: -10x0 death]
death3: does [bille1_alive?: true bille1/offset: ((size_scrn / 2) + 0x-100) pairP: 0x4 bille2_alive?: false bille3_alive?: false bille4_alive?: false bille5_alive?: false bille2/offset: -10x0 bille3/offset: -10x0 bille4/offset: -10x0 bille5/offset: -10x0]
faster: does [if son? [bass/do [play son-pickup2]] if not equal? v2 vmax [v2: v2 + 0.05 poke titre/draw 10  form round/to v2 0.01]]
slower: does [if son? [bass/do [play son-pickup2]] if not equal? v2 vmin [v2: v2 - 0.05 poke titre/draw 10  form round/to v2 0.01]]
salary: does [if son? [bass/do [play son-pickup2]] score: score + 500 poke titre/draw 34 (form score)]
maj_score: does [score: score + 50 poke titre/draw 34 (form score)]
but1: does [
wpn1/offset: -10x10
impacts: impacts + 1 score: score + 10 poke titre/draw 34 (form score)
temp: pick lay_brique/draw p6 poke lay_brique/draw p6 (temp * 1.2) 
poke listeVie n ((pick listevie n) - 1) if ((to integer! pick listevie n) = 0) [
temp: reduce to-word rejoin ["b" n]
temp/offset: (as-pair (((pick listeAbs n) + ((pick listeLong n) / 2)) - (temp/size/x / 2)) (((pick listeOrd n) + ((pick listeLarg n) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p6 + 2) -10x0
poke lay_brique/draw (p6 + 3) -10x0
checkbrik
]
]
but12: does [
wpn12/offset: -10x10
impacts: impacts + 1 score: score + 10 poke titre/draw 34 (form score)
temp: pick lay_brique/draw p62 poke lay_brique/draw p62 (temp * 1.2) 
poke listeVie n12 ((pick listevie n12) - 1) if ((to integer! pick listevie n12) = 0) [
temp: reduce to-word rejoin ["b" n12]
temp/offset: (as-pair (((pick listeAbs n12) + ((pick listeLong n12) / 2)) - (temp/size/x / 2)) (((pick listeOrd n12) + ((pick listeLarg n12) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p62 + 2) -10x0
poke lay_brique/draw (p62 + 3) -10x0
checkbrik
]
]
but13: does [
wpn13/offset: -16x10
impacts: impacts + 1 score: score + 10 poke titre/draw 34 (form score)
temp: pick lay_brique/draw p63 poke lay_brique/draw p63 (temp * 1.2) 
poke listeVie n13 ((pick listevie n13) - 1) if ((to integer! pick listevie n13) = 0) [
temp: reduce to-word rejoin ["b" n13]
temp/offset: (as-pair (((pick listeAbs n13) + ((pick listeLong n13) / 2)) - (temp/size/x / 2)) (((pick listeOrd n13) + ((pick listeLarg n13) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p63 + 2) -10x0
poke lay_brique/draw (p63 + 3) -10x0
checkbrik
]
]
but2: does [
wpn1/offset: -10x10
impacts: impacts + (pick listevie n)
score: score + ((pick listevie n) * 10) poke titre/draw 34 (form score)
poke listeVie n 0 
temp: reduce to-word rejoin ["b" n]
temp/offset: (as-pair (((pick listeAbs n) + ((pick listeLong n) / 2)) - (temp/size/x / 2)) (((pick listeOrd n) + ((pick listeLarg n) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p6 + 2) -10x0
poke lay_brique/draw (p6 + 3) -10x0
checkbrik
]
but22: does [
wpn12/offset: -10x10
impacts: impacts + (pick listevie n12)
score: score + ((pick listevie n12) * 10) poke titre/draw 34 (form score)
poke listeVie n12 0 
temp: reduce to-word rejoin ["b" n12]
temp/offset: (as-pair (((pick listeAbs n12) + ((pick listeLong n12) / 2)) - (temp/size/x / 2)) (((pick listeOrd n12) + ((pick listeLarg n12) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p62 + 2) -10x0
poke lay_brique/draw (p62 + 3) -10x0
checkbrik
]
but23: does [
wpn13/offset: -16x10
impacts: impacts + (pick listevie n13)
score: score + ((pick listevie n13) * 10) poke titre/draw 34 (form score)
poke listeVie n13 0 
temp: reduce to-word rejoin ["b" n13]
temp/offset: (as-pair (((pick listeAbs n13) + ((pick listeLong n13) / 2)) - (temp/size/x / 2)) (((pick listeOrd n13) + ((pick listeLarg n13) / 2)) - (temp/size/y / 2)))
poke lay_brique/draw (p63 + 2) -10x0
poke lay_brique/draw (p63 + 3) -10x0
checkbrik
]

rebond_1: does [
if son? [bass/do [play son-rebond]]
		either all [(cond1 == false) (pairp/x > 0)(pairp/y > 0)] [set 'cond1 none set 'cond2 none pairp: pairp * 1x-1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
           either all [(cond1 == true)(pairp/x > 0)(pairp/y > 0)] [set 'cond1 none set 'cond2 none pairp: pairp * -1x1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
			either all [(cond2 == true) (pairp/x < 0)(pairp/y < 0)] [set 'cond1 none set 'cond2 none pairp: pairp * -1x1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
				either all [(cond2 == false) (pairp/x < 0)(pairp/y < 0)] [set 'cond1 none set 'cond2 none pairp: pairp * 1x-1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
					either all [(cond1 == true) (pairp/x < 0)(pairp/y > 0)] [set 'cond1 none set 'cond2 none pairp: pairp * -1x1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
						either all [(cond1 == false) (pairp/x < 0)(pairp/y > 0)] [set 'cond1 none set 'cond2 none pairp: pairp * 1x-1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
							either all [(cond2 == true) (pairp/x > 0)(pairp/y < 0)] [set 'cond1 none set 'cond2 none pairp: pairp * -1x1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
								either all [(cond2 == false) (pairp/x > 0)(pairp/y < 0)] [set 'cond1 none set 'cond2 none pairp: pairp * 1x-1 temp: pick lay_brique/draw p poke lay_brique/draw p (temp * 1.2)  poke listeVie i ((pick listevie i) - 1) maj_score  if ((to integer! pick listevie i) = 0) [temp: reduce to-word rejoin ["b" i] temp/offset: (as-pair (((pick listeAbs i) + ((pick listeLong i) / 2)) - (temp/size/x / 2)) (((pick listeOrd i) + ((pick listeLarg i) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p + 2) -10x0 poke lay_brique/draw (p + 3) -10x0 checkbrik]][
								]						
							]
						]    
					]	
				]
			]	
		]	
	]
]
rebond_2: does [
if son? [bass/do [play son-rebond]]
		either all [(cond12 == false) (pairp2/x > 0)(pairp2/y > 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * 1x-1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
           either all [(cond12 == true)(pairp2/x > 0)(pairp2/y > 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * -1x1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
			either all [(cond22 == true) (pairp2/x < 0)(pairp2/y < 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * -1x1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
				either all [(cond22 == false) (pairp2/x < 0)(pairp2/y < 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * 1x-1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
					either all [(cond12 == true) (pairp2/x < 0)(pairp2/y > 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * -1x1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
						either all [(cond12 == false) (pairp2/x < 0)(pairp2/y > 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * 1x-1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
							either all [(cond22 == true) (pairp2/x > 0)(pairp2/y < 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * -1x1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
								either all [(cond22 == false) (pairp2/x > 0)(pairp2/y < 0)] [set 'cond12 none set 'cond22 none pairp2: pairp2 * 1x-1 temp: pick lay_brique/draw p2 poke lay_brique/draw p2 (temp * 1.2)  poke listeVie j ((pick listevie j) - 1) maj_score  if ((to integer! pick listevie j) = 0) [temp: reduce to-word rejoin ["b" j] temp/offset: (as-pair (((pick listeAbs j) + ((pick listeLong j) / 2)) - (temp/size/x / 2)) (((pick listeOrd j) + ((pick listeLarg j) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p2 + 2) -10x0 poke lay_brique/draw (p2 + 3) -10x0 checkbrik]][
								]						
							]
						]    
					]	
				]
			]	
		]	
	]
]
rebond_3: does [
if son? [bass/do [play son-rebond]]
		either all [(cond13 == false) (pairp3/x > 0)(pairp3/y > 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * 1x-1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
           either all [(cond13 == true)(pairp3/x > 0)(pairp3/y > 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * -1x1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
			either all [(cond23 == true) (pairp3/x < 0)(pairp3/y < 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * -1x1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
				either all [(cond23 == false) (pairp3/x < 0)(pairp3/y < 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * 1x-1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
					either all [(cond13 == true) (pairp3/x < 0)(pairp3/y > 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * -1x1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
						either all [(cond13 == false) (pairp3/x < 0)(pairp3/y > 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * 1x-1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
							either all [(cond23 == true) (pairp3/x > 0)(pairp3/y < 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * -1x1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
								either all [(cond23 == false) (pairp3/x > 0)(pairp3/y < 0)] [set 'cond13 none set 'cond23 none pairp3: pairp3 * 1x-1 temp: pick lay_brique/draw p3 poke lay_brique/draw p3 (temp * 1.2)  poke listeVie k ((pick listevie k) - 1) maj_score  if ((to integer! pick listevie k) = 0) [temp: reduce to-word rejoin ["b" k] temp/offset: (as-pair (((pick listeAbs k) + ((pick listeLong k) / 2)) - (temp/size/x / 2)) (((pick listeOrd k) + ((pick listeLarg k) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p3 + 2) -10x0 poke lay_brique/draw (p3 + 3) -10x0 checkbrik]][
								]						
							]
						]    
					]	
				]
			]	
		]	
	]
]
rebond_4: does [
if son? [bass/do [play son-rebond]]
		either all [(cond14 == false) (pairp4/x > 0)(pairp4/y > 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * 1x-1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
           either all [(cond14 == true)(pairp4/x > 0)(pairp4/y > 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * -1x1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
			either all [(cond24 == true) (pairp4/x < 0)(pairp4/y < 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * -1x1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
				either all [(cond24 == false) (pairp4/x < 0)(pairp4/y < 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * 1x-1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
					either all [(cond14 == true) (pairp4/x < 0)(pairp4/y > 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * -1x1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
						either all [(cond14 == false) (pairp4/x < 0)(pairp4/y > 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * 1x-1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
							either all [(cond24 == true) (pairp4/x > 0)(pairp4/y < 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * -1x1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
								either all [(cond24 == false) (pairp4/x > 0)(pairp4/y < 0)] [set 'cond14 none set 'cond24 none pairp4: pairp4 * 1x-1 temp: pick lay_brique/draw p4 poke lay_brique/draw p4 (temp * 1.2)  poke listeVie l ((pick listevie l) - 1) maj_score  if ((to integer! pick listevie l) = 0) [temp: reduce to-word rejoin ["b" l] temp/offset: (as-pair (((pick listeAbs l) + ((pick listeLong l) / 2)) - (temp/size/x / 2)) (((pick listeOrd l) + ((pick listeLarg l) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p4 + 2) -10x0 poke lay_brique/draw (p4 + 3) -10x0 checkbrik]][
								]						
							]
						]    
					]	
				]
			]	
		]	
	]
]
rebond_5: does [
if son? [bass/do [play son-rebond]]
		either all [(cond15 == false) (pairp5/x > 0)(pairp5/y > 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * 1x-1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
           either all [(cond15 == true)(pairp5/x > 0)(pairp5/y > 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * -1x1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
			either all [(cond25 == true) (pairp5/x < 0)(pairp5/y < 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * -1x1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
				either all [(cond25 == false) (pairp5/x < 0)(pairp5/y < 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * 1x-1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
					either all [(cond15 == true) (pairp5/x < 0)(pairp5/y > 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * -1x1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
						either all [(cond15 == false) (pairp5/x < 0)(pairp5/y > 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * 1x-1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
							either all [(cond25 == true) (pairp5/x > 0)(pairp5/y < 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * -1x1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
								either all [(cond25 == false) (pairp5/x > 0)(pairp5/y < 0)] [set 'cond15 none set 'cond25 none pairp5: pairp5 * 1x-1 temp: pick lay_brique/draw p5 poke lay_brique/draw p5 (temp * 1.2)  poke listeVie m ((pick listevie m) - 1) maj_score  if ((to integer! pick listevie m) = 0) [temp: reduce to-word rejoin ["b" m] temp/offset: (as-pair (((pick listeAbs m) + ((pick listeLong m) / 2)) - (temp/size/x / 2)) (((pick listeOrd m) + ((pick listeLarg m) / 2)) - (temp/size/y / 2)))poke lay_brique/draw (p5 + 2) -10x0 poke lay_brique/draw (p5 + 3) -10x0 checkbrik]][
								]						
							]
						]    
					]	
				]
			]	
		]	
	]
]
listeAbs: [
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000
]
listeOrd: [
100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100
140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140
180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180 180
220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220 220
260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260 260
]
listeLong: [
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
]
listeLarg: [
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25
]
listeVie: [
5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
]
double: does [
    if not triple? [double?: true]
    if tir1? [color_weapon: red poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
    if tir2? [color_weapon: cyan poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
    poke raquette/draw 19 (as-pair ((longraq / 3) - 6) 0)
    poke raquette/draw 20 ((as-pair ((longraq / 3) - 6) 0) + 11x3)
    poke raquette/draw 24 (as-pair (((longraq * 2) / 3)- 6) 0)
    poke raquette/draw 25 ((as-pair (((longraq * 2) / 3)- 6) 0) + 11x3)
]
triple: does [
    triple?: true double?: false
    if tir1? [color_weapon: red poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
    if tir2? [color_weapon: cyan poke raquette/draw 17 color_weapon poke raquette/draw 22 color_weapon poke raquette/draw 27 color_weapon]
    poke raquette/draw 19 (as-pair ((longraq / 4) - 6) 0)
    poke raquette/draw 20 ((as-pair ((longraq / 4) - 6) 0) + 11x3)
    poke raquette/draw 24 (as-pair (((longraq * 3) / 4)- 6) 0)
    poke raquette/draw 25 ((as-pair (((longraq * 3) / 4)- 6) 0) + 11x3)
    poke raquette/draw 29 (as-pair ((longraq / 2)- 8) 0)
    poke raquette/draw 30 ((as-pair ((longraq / 2)- 8) 0) + 16x6)    
]
coll_bonus: does [
        imgBonus: test/image
        if imgBonus = reduce to-word rejoin ["SLO" taille_bonus] [slower SLOnumber: SLOnumber + 1 poke titre/draw 39 form SLOnumber]
        if imgBonus = reduce to-word rejoin ["SPD" taille_bonus] [faster SPDnumber: SPDnumber + 1 poke titre/draw 42 form SPDnumber]
        if imgBonus = reduce to-word rejoin ["LFE" taille_bonus] [birth LFEnumber: LFEnumber + 1 poke titre/draw 45 form LFEnumber]        
        if imgBonus = reduce to-word rejoin ["DTH" taille_bonus] [death2 DTHnumber: DTHnumber + 1 poke titre/draw 48 form DTHnumber]
        if imgBonus = reduce to-word rejoin ["B5K" taille_bonus] [salary B5Knumber: B5Knumber + 1 poke titre/draw 51 form B5Knumber]        
        if imgBonus = reduce to-word rejoin ["BIG" taille_bonus] [bigger BIGnumber: BIGnumber + 1 poke titre/draw 54 form BIGnumber]        
        if imgBonus = reduce to-word rejoin ["SML" taille_bonus] [smaller SMLnumber: SMLnumber + 1 poke titre/draw 57 form SMLnumber]
        if imgBonus = reduce to-word rejoin ["NBL" taille_bonus] [add_Ball NBLnumber: NBLnumber + 1 poke titre/draw 60 form NBLnumber]        
        if imgBonus = reduce to-word rejoin ["WP1" taille_bonus] [load1 WPN1number: WPN1number + 1 poke titre/draw 63 form WPN1number] 
        if imgBonus = reduce to-word rejoin ["WP2" taille_bonus] [load2 WPN2number: WPN2number + 1 poke titre/draw 66 form WPN2number] 
        if imgBonus = reduce to-word rejoin ["DBL" taille_bonus] [double DBLnumber: DBLnumber + 1 poke titre/draw 69 form DBLnumber]
        if imgBonus = reduce to-word rejoin ["TPL" taille_bonus] [triple TPLnumber: TPLnumber + 1 poke titre/draw 72 form TPLnumber]
]
coll_raq: does [
    foreach-face fen [
        if face/text = "1" [posbox: bille1/offset paire: pairp sizebox: bille1/size]
        if face/text = "2" [posbox: bille2/offset paire: pairp2 sizebox: bille2/size]
        if face/text = "3" [posbox: bille3/offset paire: pairp3 sizebox: bille3/size]
        if face/text = "4" [posbox: bille4/offset paire: pairp4 sizebox: bille4/size]
        if face/text = "5" [posbox: bille5/offset paire: pairp5 sizebox: bille5/size]
        if all [
            (paire/y > 0)
            ((posbox/y + sizebox/y) >= raquette/offset/y)
            ((posbox/y + sizebox/y) <= (raquette/offset/y + epraq))		
            ][
        if all [
            (posbox/x >= (raquette/offset/x - sizebox/x))
            (posbox/x <= raquette/offset/x )
            ]
			[
            if face/text = "1" [pairp: -3x-4  if son? [bass/do [play son-rebond]] ]
            if face/text = "2" [pairp2: -3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: -3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: -3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: -3x-4  if son? [bass/do [play son-rebond]]]
			 ]
        if all [
            (posbox/x > raquette/offset/x)
            (posbox/x < (raquette/offset/x + (longRaq / 4) - (sizebox/x / 2)))
            ]
			[
  			if face/text = "1" [pairp: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: -2x-4  if son? [bass/do [play son-rebond]]]
           
             ]
        if all [
            (posbox/x >= (raquette/offset/x + (longRaq / 4) - (sizebox/x / 2)))
            (posbox/x < (raquette/offset/x + (longRaq / 2) - (sizebox/x / 2)))
            ]
			[
  			if face/text = "1" [pairp: -1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: -1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: -1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: -1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: -1x-4  if son? [bass/do [play son-rebond]]]
             ]
        if (posbox/x = (raquette/offset/x + (longRaq / 2) - (sizebox/x / 2)))
            [
  			if face/text = "1" [pairp: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: -2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: -2x-4  if son? [bass/do [play son-rebond]]]
             ]
        if all [
            (posbox/x > (raquette/offset/x + (longRaq / 2) - (sizebox/x / 2)))
            (posbox/x < (raquette/offset/x + ((longRaq * 3) / 4) - (sizebox/x / 2)))
            ]
			[
  			if face/text = "1" [pairp: 1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: 1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: 1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: 1x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: 1x-4  if son? [bass/do [play son-rebond]]]
              ]
        if all [
            (posbox/x >= (raquette/offset/x + ((longRaq * 3) / 4) - (sizebox/x / 2)))
            (posbox/x < (raquette/offset/x + longRaq - (sizebox/x / 2)))
            ]
			[
  			if face/text = "1" [pairp: 2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: 2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: 2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: 2x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: 2x-4  if son? [bass/do [play son-rebond]]]
            ]
        if all [
            (posbox/x <= (raquette/offset/x + longRaq ))
            (posbox/x >= (raquette/offset/x + longRaq - (sizebox/x / 2)))
            ]
			[
  			if face/text = "1" [pairp: 3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "2" [pairp2: 3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "3" [pairp3: 3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "4" [pairp4: 3x-4  if son? [bass/do [play son-rebond]]]
            if face/text = "5" [pairp5: 3x-4  if son? [bass/do [play son-rebond]]]
             ]
]		
]
]
move_mouse: func [pos_souris] [
if all [((pos_souris/x + (longraq / 2)) < size_scrn/x)(pos_souris/x > (longraq / 2))][ 
	abs_temp: pos_souris - raquette/offset
	abs_temp: abs_temp/x - (longraq / 2)
	coord_trs: as-pair abs_temp 0
    raquette/offset: raquette/offset + coord_trs
    ]
if (pos_souris/x <= (longraq / 2)) [
    ord_trs: raquette/offset/y
    raquette/offset: as-pair 0 ord_trs
]


 ]
Coll_detect: func [BrkX BrkY longBrk lagBrk][
        if all [
    ((bille1/offset/x + bille1/size/x) > BrkX)
    ((bille1/offset/x) < (BrkX + longBrk))
    ((bille1/offset/y + bille1/size/y) > BrkY)
    ((bille1/offset/y) < (BrkY + lagBrk))
        ][
    set 'cond1 (greater? (bille1/offset/y) (BrkY)) 
    set 'cond2 (lesser? (bille1/offset/y + bille1/size/y) (BrkY + lagBrk))  
    either i = 1 [p: 2][p: 2 + ((i - 1) * 5)]
    rebond_1]
]
Coll_detect2: func [BrkX2 BrkY2 longBrk2 lagBrk2][
        if all [
    ((bille2/offset/x + bille2/size/x) > BrkX2)
    ((bille2/offset/x) < (BrkX2 + longBrk2))
    ((bille2/offset/y + bille2/size/y) > BrkY2)
    ((bille2/offset/y) < (BrkY2 + lagBrk2))
        ][
    set 'cond12 (greater? (bille2/offset/y) (BrkY2)) 
    set 'cond22 (lesser? (bille2/offset/y + bille2/size/y) (BrkY2 + lagBrk2))  
    either j = 1 [p2: 2][p2: 2 + ((j - 1) * 5)]
    rebond_2]
]
Coll_detect3: func [BrkX3 BrkY3 longBrk3 lagBrk3][
        if all [
    ((bille3/offset/x + bille3/size/x) > BrkX3)
    ((bille3/offset/x) < (BrkX3 + longBrk3))
    ((bille3/offset/y + bille3/size/y) > BrkY3)
    ((bille3/offset/y) < (BrkY3 + lagBrk3))
        ][
    set 'cond13 (greater? (bille3/offset/y) (BrkY3)) 
    set 'cond23 (lesser? (bille3/offset/y + bille3/size/y) (BrkY3 + lagBrk3))  
    either k = 1 [p3: 2][p3: 2 + ((k - 1) * 5)]
    rebond_3]
]
Coll_detect4: func [BrkX4 BrkY4 longBrk4 lagBrk4][
        if all [
    ((bille4/offset/x + bille4/size/x) > BrkX4)
    ((bille4/offset/x) < (BrkX4 + longBrk4))
    ((bille4/offset/y + bille4/size/y) > BrkY4)
    ((bille4/offset/y) < (BrkY4 + lagBrk4))
        ][
    set 'cond14 (greater? (bille4/offset/y) (BrkY4)) 
    set 'cond24 (lesser? (bille4/offset/y + bille4/size/y) (BrkY4 + lagBrk4))  
    either l = 1 [p4: 2][p4: 2 + ((l - 1) * 5)]
    rebond_4]
]
Coll_detect5: func [BrkX5 BrkY5 longBrk5 lagBrk5][
        if all [
    ((bille5/offset/x + bille5/size/x) > BrkX5)
    ((bille5/offset/x) < (BrkX5 + longBrk5))
    ((bille5/offset/y + bille5/size/y) > BrkY5)
    ((bille5/offset/y) < (BrkY5 + lagBrk5))
        ][
    set 'cond15 (greater? (bille5/offset/y) (BrkY5)) 
    set 'cond25 (lesser? (bille5/offset/y + bille5/size/y) (BrkY5 + lagBrk5))  
    either l = 1 [p5: 2][p5: 2 + ((l - 1) * 5)]
    rebond_5]
]
;;;collisions avec la fenetre
rebond1: does [
if bille5? [pairp5: pairp5 * 1x-1 bille5?: false]
if bille4? [pairp4: pairp4 * 1x-1 bille4?: false]
if bille3? [pairp3: pairp3 * 1x-1 bille3?: false]
if bille2? [pairp2: pairp2 * 1x-1 bille2?: false]
if bille1? [pairp: pairp * 1x-1	bille1?: false]
    ]
rebond2: does [
if bille5? [pairp5: pairp5 * -1x1 bille5?: false]
if bille4? [pairp4: pairp4 * -1x1 bille4?: false]
if bille3? [pairp3: pairp3 * -1x1 bille3?: false]
if bille2? [pairp2: pairp2 * -1x1 bille2?: false]
if bille1? [pairp: pairp * -1x1 bille1?: false]
		]
random/seed now
sizeBox2: (as-pair 1140 system/view/screens/1/size/y)
fen: [
	title "Boum Breaker 2021"
	size sizeBox2
]

append fen [
	   at 0x0 lay_brique: base 1140x500  black draw  [] 
       do [
        repeat i 100 [append lay_brique/draw reduce ['fill-pen (pick col i) 'box (as-pair pick listeAbs i pick listeOrd i) (as-pair ((pick listeAbs i) + (pick listeLong i)) ((pick listeOrd i) + (pick listeLarg i)))]]
        append lay_brique/draw reduce ['pen black]
         repeat i 100 [
            append lay_brique/draw reduce [
                'line (as-pair ((pick listeAbs i) + ecart) (pick listeord i)) (as-pair ((pick listeAbs i) + ecart)((pick listeord i) + (pick listelarg i)))
                'line (as-pair ((pick listeAbs i) + (pick listeLong i) - ecart) (pick listeord i)) (as-pair ((pick listeAbs i) + (pick listeLong i) - ecart) ((pick listeOrd i) + (pick listeLarg i)))
                'line (as-pair (pick listeAbs i) ((pick listeord i) + ecart)) (as-pair ((pick listeAbs i) + (pick listeLong i)) ((pick listeord i) + ecart))
                'line (as-pair (pick listeAbs i) ((pick listeord i) + (pick listelarg i) - ecart))  (as-pair ((pick listeAbs i) + (pick listelong i)) ((pick listeord i) + (pick listelarg i) - ecart))
                ]
    ]
]
at -100x0 text_pause: text "PAUSE" 100x20 0.0.0 font [color: red size: 10 name: "Cooper" style: 'bold ] center
    	at 0x0 titre: base 1140x30 black draw reduce [
				'font Arial2
				'pen 255.206.40
				'text 380x5 "Vitesse:" 'text 450x5 (form v2)
				'pen pink
				'text 200x5 "Vie:" 'text 250x5 (form life) 
                'pen green
                'text 30x5 "Temps:" 'text 100x5 "00:00" 
                'pen gold
                'text 500x5 "Score:" 'text 560x5 "0"
                'pen silver
                'text 645x5 "0" 
                'text 685x5 "0" 
                'text 725x5 "0" 
                'text 805x5 "0" 
                'text 765x5 "0" 
                'text 845x5 "0"
                'text 885x5 "0" 
                'text 925x5 "0"
                'text 965x5 "0" 
                'text 1005x5 "0"
                'text 1045x5 "0"
                'text 1085x5 "0"
                'text 280x5 "Niveau:" 'text 340x5 "1"
			] rate 25 on-time  [
tempsNiveau: tempsNiveau + 3
;t2: copy/part reverse (form tempsNiveau) 11
;tempsNiveau: reverse t2
poke titre/draw 26 (form tempsNiveau)            
            ]
at 625x5 image SLO2
at 665x5 image SPD2     
at 705x5 image LFE2
at 745x5 image DTH2
at 785x5 image B5K2   
at 825x5 image BIG2
at 865x5 image SML2
at 905x5 image NBL2
at 945x5 image WP12
at 985x5 image WP22
at 1025x5 image DBL2
at 1065x5 image TPL2
at pos raquette: base black 62x10 draw [
    pen silver
    fill-pen red
    circle 5x5 5
    circle 55x5 5
    fill-pen gold
    box 5x0 55x10
    fill-pen gold
    box 25x0 36x5
    fill-pen gold
    box 25x0 36x5     
   fill-pen gold
    box 25x0 36x5         
 ]
at posbille1 bille1: base 10x10 "5" draw reduce ['line-width 0.1 'fill-pen (color_bille/1) 'circle 5x5 5] rate 25 on-time [
if bille1_alive? [face/offset: face/offset + (pairp * v2)]
;;;weaponS
if all [weapon1? not touche1?][
            either tir1? [ wpn1/offset: wpn1/offset + (v2 * 0x-9 )][wpn1/offset: wpn1/offset + (v2 * 0x-8 )]
                       repeat n 100 [
                                    either all [
            ((wpn1/offset/x + wpn1/size/x) > (pick listeAbs n))
            ((wpn1/offset/x) < ((pick listeAbs n) + (pick listeLong n)))
            (wpn1/offset/y <= ((pick listeOrd n) + (pick listeLarg n)))
            ((wpn1/offset/y + wpn1/size/y) >= (pick listeOrd n))
            (pick listeVie n)  <> 0
                ][
            touche1?: true
            if son? [bass/do [play son-tir1]]
            either n = 1 [p6: 2][p6: 2 + ((n - 1) * 5)]
            either tir1? [but1][but2]
            touche1?: false
            weapon1?: false
                ][
            if(wpn1/offset/y <= 0) [touche1?: false weapon1?: false wpn1/offset: -10x10]
    ]
 ]
]
if all [weapon12? not touche12?][
            either tir1? [ wpn12/offset: wpn12/offset + (v2 * 0x-9 )][wpn12/offset: wpn12/offset + (v2 * 0x-8 )]
                       repeat n12 100 [
                                    either all [
            ((wpn12/offset/x + wpn12/size/x) > (pick listeAbs n12))
            ((wpn12/offset/x) < ((pick listeAbs n12) + (pick listeLong n12)))
            (wpn12/offset/y <= ((pick listeOrd n12) + (pick listeLarg n12)))
            ((wpn12/offset/y + wpn12/size/y) >= (pick listeOrd n12))
            (pick listeVie n12)  <> 0
                ][
            touche12?: true
            if son? [bass/do [play son-tir1]]
            either n12 = 1 [p62: 2][p62: 2 + ((n12 - 1) * 5)]
            either tir1? [but12][but22]
            touche12?: false
            weapon12?: false
                ][
            if(wpn12/offset/y <= 0) [touche12?: false weapon12?: false wpn12/offset: -10x10]
    ]
                   ]
        ]
if all [weapon13? not touche13?][
            either tir1? [ wpn13/offset: wpn13/offset + (v2 * 0x-9 )][wpn13/offset: wpn13/offset + (v2 * 0x-8 )]
                       repeat n13 100 [
                                    either all [
            ((wpn13/offset/x + wpn13/size/x) > (pick listeAbs n13))
            ((wpn13/offset/x) < ((pick listeAbs n13) + (pick listeLong n13)))
            (wpn13/offset/y <= ((pick listeOrd n13) + (pick listeLarg n13)))
            ((wpn13/offset/y + wpn13/size/y) >= (pick listeOrd n13))
            (pick listeVie n13)  <> 0
                ][
            touche13?: true
            if son? [bass/do [play son-tir1]]
            either n13 = 1 [p63: 2][p63: 2 + ((n13 - 1) * 5)]
            either tir1? [but13][but23]
            touche13?: false
            weapon13?: false
                ][
            if(wpn13/offset/y <= 0) [touche13?: false weapon13?: false wpn13/offset: -16x10]
    ]
                   ]
]
repeat i 100 [
    test: reduce to-word rejoin ["b" i]
    if test/offset <> -50x0 [
    test/offset: test/offset + (v2 * 0x5)
        either all [
        ((test/offset/x + test/size/x) >= raquette/offset/x)
        (test/offset/x  <= (raquette/offset/x + longRaq))
        ((test/offset/y + test/size/y) >= raquette/offset/y)
        (test/offset/y <= (raquette/offset/y + epraq))		
                ][
       test/offset: -50x0 coll_bonus
                ][if test/offset/y >= lay_brique/size/y [if son? [bass/do [play son-loupe]] bonus_loupes: bonus_loupes + 1 test/offset: -50x0]]
    ]
]
if pairp/y > 0 [
	if ((face/offset/y + face/size/y) >= lay_brique/size/y) [bille1?: true rebond1 face/offset: -10x0 bille1_alive?: false ballloss]
	if (face/offset/x  <= 0) [bille1?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille1?: true rebond2 ]
]
if pairp/y < 0 [
	if (face/offset/y <= 0) [bille1?: true rebond1 ]
	if (face/offset/x <= 0) [bille1?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille1?: true rebond2]
]
;;collisions avec les briques
repeat i 100 [
    absBrk: pick listeAbs i
    ordkBrk: pick listeOrd i
    long: pick listeLong i
    larg: pick listeLarg i
    vieBr: pick listeVie i
    if vieBr <> 0 [
    Coll_detect absBrk ordkBrk long larg
    ]
]
;collisions avec la raquette		
coll_raq
]
do [bille1/color: none]
 ;2ème bille   
at posbille2 bille2: base 10x10 "2" draw reduce ['line-width 0.1 'fill-pen (color_bille/2) 'circle 5x5 5] rate 25 on-time [
if bille2_alive? [face/offset: face/offset + (pairp2 * v2)]
;;collisions avec la fenetre  
if pairp2/y > 0 [
	if ((face/offset/y + face/size/y) >= lay_brique/size/y) [bille2?: true rebond1 face/offset: -10x0 bille2_alive?: false ballloss]
	if (face/offset/x  <= 0) [bille2?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille2?: true rebond2 ]
]
if pairp2/y < 0 [
	if (face/offset/y <= 0) [bille2?: true rebond1 ]
	if (face/offset/x <= 0) [bille2?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille2?: true rebond2]
]
repeat j 100 [
    absBrk2: pick listeAbs j
    ordkBrk2: pick listeOrd j
    long2: pick listeLong j
    larg2: pick listeLarg j
    vieBr2: pick listeVie j
    if vieBr2 <> 0 [
    Coll_detect2 absBrk2 ordkBrk2 long2 larg2
    ]
]
]
do [bille2/color: none]
 ;3ème bille   
at posbille3 bille3: base 10x10 "3" draw reduce ['line-width 0.1 'fill-pen (color_bille/3) 'circle 5x5 5] rate 25 on-time [
if bille3_alive? [face/offset: face/offset + (pairp3 * v2)]
;;collisions avec la fenetre  
if pairp3/y > 0 [
	if ((face/offset/y + face/size/y) >= lay_brique/size/y) [bille3?: true rebond1 face/offset: -10x0 bille3_alive?: false ballloss]
	if (face/offset/x  <= 0) [bille3?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille3?: true rebond2 ]
]
if pairp3/y < 0 [
	if (face/offset/y <= 0) [bille3?: true rebond1 ]
	if (face/offset/x <= 0) [bille3?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille3?: true rebond2]
]
repeat k 100 [
    absBrk3: pick listeAbs k
    ordkBrk3: pick listeOrd k
    long3: pick listeLong k
    larg3: pick listeLarg k
    vieBr3: pick listeVie k
    if vieBr3 <> 0 [
    Coll_detect3 absBrk3 ordkBrk3 long3 larg3
    ]
]
]
do [bille3/color: none]
 ;4ème bille   
at posbille4 bille4: base 10x10 "4" draw reduce ['line-width 0.1 'fill-pen (color_bille/4) 'circle 5x5 5] rate 25 on-time [
if bille4_alive? [face/offset: face/offset + (pairp4 * v2)]
;;collisions avec la fenetre  
if pairp4/y > 0 [
	if ((face/offset/y + face/size/y) >= lay_brique/size/y) [bille4?: true rebond1 face/offset: -10x0 bille4_alive?: false ballloss]
	if (face/offset/x  <= 0) [bille4?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille4?: true rebond2 ]
]
if pairp4/y < 0 [
	if (face/offset/y <= 0) [bille4?: true rebond1 ]
	if (face/offset/x <= 0) [bille4?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille4?: true rebond2]
]
repeat l 100 [
    absBrk4: pick listeAbs l
    ordkBrk4: pick listeOrd l
    long4: pick listeLong l
    larg4: pick listeLarg l
    vieBr4: pick listeVie l
    if vieBr4 <> 0 [
    Coll_detect4 absBrk4 ordkBrk4 long4 larg4
    ]
]
]
do [bille4/color: none]
 ;5ème bille   
at posbille5 bille5: base 10x10 "1" draw reduce ['line-width 0.1 'fill-pen (color_bille/5) 'circle 5x5 5] rate 25 on-time [
if bille5_alive? [face/offset: face/offset + (pairp5 * v2)]
;;collisions avec la fenetre  
if pairp5/y > 0 [
	if ((face/offset/y + face/size/y) >= lay_brique/size/y) [bille5?: true rebond1 face/offset: -10x0 bille5_alive?: false ballloss]
	if (face/offset/x  <= 0) [bille5?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille5?: true rebond2 ]
]
if pairp5/y < 0 [
	if (face/offset/y <= 0) [bille5?: true rebond1 ]
	if (face/offset/x <= 0) [bille5?: true rebond2]
	if ((face/offset/x + face/size/x) >= sizeBox2/x) [bille5?: true rebond2]
]
repeat l 100 [
    absBrk5: pick listeAbs l
    ordkBrk5: pick listeOrd l
    long5: pick listeLong l
    larg5: pick listeLarg l
    vieBr5: pick listeVie l
    if vieBr5 <> 0 [
    Coll_detect5 absBrk5 ordkBrk5 long5 larg5
    ]
]
]
do [bille5/color: none]
at poswpn1 wpn1: base dimwpn1 draw reduce ['fill-pen red 'pen red 'box 0x0 dimwpn1 3]
at poswpn12 wpn12: base dimwpn12 draw reduce ['fill-pen red 'pen red 'box 0x0 dimwpn12 3]
at poswpn13 wpn13: base dimwpn13 draw reduce ['fill-pen red 'pen red 'box 0x0 dimwpn13 3]
]
repeat i 100 [append fen reduce ['at -50x0 (to-set-word  rejoin  ["B" i]) 'image (random/only listeBonus) ]]
append fen [
 at 0x0 box sizeBox2 0.0.0.200 all-over focus cursor img on-down [
                        if tir1? [
                        poke wpn1/draw 2 red poke wpn12/draw 2 red poke wpn13/draw 2 red
                        if all [ not double? not triple?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn1/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                                        ]
                        if all  [not triple? double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 3) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 2) / 3) - (wpn12/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                            ]
                        if all  [triple? not double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 4) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 3) / 4) - (wpn12/size/x / 2)) 0)]
                        if not weapon13? [wpn13/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn13/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                        if not touche13? [weapon13?: true]
                            ]
                        ]
                        if tir2? [
                        poke wpn1/draw 2 cyan poke wpn12/draw 2 cyan poke wpn13/draw 2 cyan
                        if all [ not double? not triple?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn1/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                                        ]
                        if all  [not triple? double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 3) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 2) / 3) - (wpn12/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                            ]
                        if all  [triple? not double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 4) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 3) / 4) - (wpn12/size/x / 2)) 0)]
                        if not weapon13? [wpn13/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn13/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                        if not touche13? [weapon13?: true]
                            ]
                        ]
                        ]
                        on-alt-down [pause?: false either pause? [text_pause/offset: 500x300 bille1/rate: none bille2/rate: none bille3/rate: none bille4/rate: none bille5/rate: none titre/rate: none][text_pause/offset: -100x0 bille1/rate: 25 bille2/rate: 25 bille3/rate: 25 bille4/rate: 25 bille5/rate: 25 titre/rate: 25 if begin? [tempsNiveau: to-time 0 begin?: false]]]
    on-key  [
               switch event/key [
                        #"1" [tir2?: false tir1?: true triple?: true double?: false]
                        #"2" [tir1?: false tir2?: true triple?: true double?: false]
                        #"^M" [pause?: false either pause? [text_pause/offset: 500x300 bille1/rate: none bille2/rate: none bille3/rate: none bille4/rate: none bille5/rate: none titre/rate: none][text_pause/offset: -100x0 bille1/rate: 25 bille2/rate: 25 bille3/rate: 25 bille4/rate: 25 bille5/rate: 25 titre/rate: 25 if begin? [tempsNiveau: to-time 0 begin?: false]]]
                        #"^[" [pause_game view layout [	title "Boum Breaker 2021" backdrop snow across text 280x100 font-size 20 "Voulez vous quitter Boum Breaker 2021?" bold  return text 65 button "Oui" [if son? [bass/free] quit] text 20 button "Non" [unview] at 20x100 image %./img/Boum_Breaker.gif]]
                        up [
                        if tir1? [
                        poke wpn1/draw 2 red poke wpn12/draw 2 red poke wpn13/draw 2 red
                        if all [ not double? not triple?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn1/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                                        ]
                        if all  [not triple? double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 3) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 2) / 3) - (wpn12/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                            ]
                        if all  [triple? not double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 4) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 3) / 4) - (wpn12/size/x / 2)) 0)]
                        if not weapon13? [wpn13/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn13/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                        if not touche13? [weapon13?: true]
                            ]
                        ]
                        if tir2? [
                        poke wpn1/draw 2 cyan poke wpn12/draw 2 cyan poke wpn13/draw 2 cyan
                        if all [ not double? not triple?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn1/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                                        ]
                        if all  [not triple? double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 3) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 2) / 3) - (wpn12/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                            ]
                        if all  [triple? not double?] [
                        if not weapon1? [wpn1/offset: raquette/offset + (as-pair ((raquette/size/x / 4) - (wpn1/size/x / 2)) 0)]
                        if not weapon12? [wpn12/offset: raquette/offset + (as-pair (((raquette/size/x * 3) / 4) - (wpn12/size/x / 2)) 0)]
                        if not weapon13? [wpn13/offset: raquette/offset + (as-pair ((raquette/size/x / 2) - (wpn13/size/x / 2)) 0)]
                        if not touche1? [weapon1?: true]
                        if not touche12? [weapon12?: true]
                        if not touche13? [weapon13?: true]
                            ]
                        ]
                        ]

               ]
       ]
]
fen: layout fen 
view/options/flags fen [
    offset: 0x0
    actors: make object! [
on-over: func [face [object!] event [event!]][
if event/type = 'over [move_mouse event/offset]
]
]
do [
pause_game
if son? [bass/do  [
	channel: play music1  [volume: 1.0]   
]]
]
][modal ]
