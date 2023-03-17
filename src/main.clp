; 2301867873 - Yulia Stefani
; 2301911842 - Alyssa Imani


(deffunction cls ()
	(for (bind ?i 0) (< ?i 25) (++ ?i)
        (printout t crlf)
    )
)

(deftemplate FLOKEMON_FIRE
	(slot fireName)
	(slot fireDmg)
	(slot fireDfs)
	(slot fireLvl)
    (slot fireBurn)
	(slot firePrc)
)

(deffacts FLOKEMON_FIRE_FACTS
	(FLOKEMON_FIRE (fireName "Rapidash") (fireDmg 500) (fireDfs 50) (fireLvl 10) (fireBurn 10) (firePrc 50000))
	(FLOKEMON_FIRE (fireName "Magmar") (fireDmg 400) (fireDfs 120) (fireLvl 60) (fireBurn 40) (firePrc 200000))
	(FLOKEMON_FIRE (fireName "Gloqlithe") (fireDmg 2100) (fireDfs 150) (fireLvl 65) (fireBurn 60) (firePrc 300000))
	(FLOKEMON_FIRE (fireName "NineTales") (fireDmg 1400) (fireDfs 270) (fireLvl 80) (fireBurn 80) (firePrc 540000))
	(FLOKEMON_FIRE (fireName "Charmeloen") (fireDmg 1200) (fireDfs 250) (fireLvl 85) (fireBurn 90) (firePrc 230000))
)

(deftemplate FLOKEMON_WATER
	(slot waterName)
	(slot waterDmg)
	(slot waterDfs)
	(slot waterLvl)
	(slot waterPrc)
)

(deffacts FLOKEMON_WATER_FACTS
	(FLOKEMON_WATER (waterName "Vaporeon") (waterDmg 900) (waterDfs 120) (waterLvl 45) (waterPrc 80000))
	(FLOKEMON_WATER (waterName "Staryu") (waterDmg 800) (waterDfs 70) (waterLvl 30) (waterPrc 50000))
	(FLOKEMON_WATER (waterName "Poliwhirl") (waterDmg 500) (waterDfs 90) (waterLvl 20) (waterPrc 250000))
	(FLOKEMON_WATER (waterName "Goldluck") (waterDmg 2000) (waterDfs 250) (waterLvl 90) (waterPrc 200000))
	(FLOKEMON_WATER (waterName "Blastoise") (waterDmg 1500) (waterDfs 200) (waterLvl 80) (waterPrc 150000))
)

(deffunction menu ()
    (cls)
	(printout t "+======================+" crlf)
	(printout t "| Flokemon Store       |" crlf)
	(printout t "+======================+" crlf)
    (printout t "1. View Flokemon" crlf)
    (printout t "2. Add Flokemon" crlf)
    (printout t "3. Update Flokemon" crlf)
    (printout t "4. Remove Flokemon" crlf)
    (printout t "5. Find Flokemon" crlf)
    (printout t "6. Exit" crlf)
	(printout t "+======================+" crlf)
	
)

(deffunction menuFlokemon ()
	(printout t "Choose Flokemon Type to view" crlf)
    (printout t "1. Fire Flokemon" crlf)
    (printout t "2. Water Flokemon" crlf)
    (printout t "3. Back" crlf)
    (printout t "Choose: ")
)

(defglobal 
    ?*num* = 1
)

(defrule viewFlokemonFire
    (printFlokemonFire)
	(FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-20d|%-10d|" ?*num* ?fn ?fg ?fd ?fl ?fb ?fp)
    (printout t crlf)
    (++ ?*num*)
)

(defrule viewFlokemonWater
    (printFlokemonWater)
	(FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-10d|" ?*num* ?wn ?wg ?wd ?wl ?wp)
    (printout t crlf)
    (++ ?*num*)
)

(deffunction viewFlokemon ()
	(bind ?choose1 0)
    (cls)
    (while (or (< ?choose1 1) (> ?choose1 3))
        (menuFlokemon)
        (bind ?choose1 (read))
        (if (eq (numberp ?choose1) FALSE) 
            then (bind ?choose1 0)
        )
            
    ; Masuk View
    (if (eq ?choose1 1)
        then (printout t "Fire Flokemon List" crlf)
        (printout t "====================================================================================================" crlf)
        (printout t "|No.|Name                         |Damage    |Defense   |Level     |Burn Damage         |Price     |" crlf)
        (printout t "====================================================================================================" crlf)
        (assert(printFlokemonFire))
        (run)
        (printout t "====================================================================================================" crlf)
        (printout t)
        (printout t "Press ENTER to continue ..." crlf)
        (readline)
                
     elif (eq ?choose1 2)
        then (printout t "Water Flokemon List" crlf)
        (printout t "===============================================================================" crlf)
        (printout t "|No.|Name                         |Damage    |Defense   |Level     |Price     |" crlf)
        (printout t "===============================================================================" crlf)
        (retract-string "(printFlokemonWater)")
        (assert(printFlokemonWater))
        (run)
        (printout t "===============================================================================" crlf)
        (printout t)
        (printout t "Press ENTER to continue ..." crlf)
        (readline)
                
     else
                
     )
            
            
    )
)

(reset)
(bind ?choose 0)
(while (neq ?choose 6)
    (menu)
    (bind ?choose 0)
    (while (or (< ?choose 1) (> ?choose 6))
        (printout t "Choose: ")
        (bind ?choose (read))
        (if (eq (numberp ?choose) FALSE) 
            then (bind ?choose 0)
        )
    )
    
    ; Masuk menu VIEW
    (if (eq ?choose 1)
        then (viewFlokemon)
        
        
    ; Masuk menu ADD    
    elif (eq ?choose 2)
        then (bind ?choose2 0)
        (cls)
        (while (or (< ?choose2 1) (> ?choose2 3))
            (menuFlokemon)
            (bind ?choose2 (read))
            (if (eq (numberp ?choose2) FALSE) 
                then (bind ?choose2 0)
            )
         
         ; Masuk Add Fire Flokemon
         (if (eq ?choose2 1)
            then (bind ?fireName "")
            (while (or (eq (lexemep ?fireName) FALSE ) (< (str-length ?fireName) 5 ) (> (str-length ?fireName) 25 ))
                    (printout t "Insert Flokemon Name [5 - 25 Character] : ")
                    (bind ?fireName (readline))
                )
                
                (bind ?fireDmg 0) 
                (while (or (< ?fireDmg 10) (> ?fireDmg 5000))
                    (printout t "Insert Flokemon Damage [10 - 5000] : ")
                    (bind ?fireDmg (read))
                )
                
                (bind ?fireDfs 0) 
                (while (or (< ?fireDfs 5) (> ?fireDfs 30))
                    (printout t "Insert Flokemon Defense [5 - 30] : ")
                    (bind ?fireDfs (read))
                )
                
                (bind ?fireLvl 0) 
                (while (or (< ?fireLvl 1) (> ?fireLvl 100))
                    (printout t "Insert Flokemon Level [1 - 100] : ")
                    (bind ?fireLvl (read))
                )
                
                (bind ?firePrc 0) 
                (while (or (< ?firePrc 1000) (> ?firePrc 1000000))
                    (printout t "Insert Flokemon Price [1000 - 1000000] : ")
                    (bind ?firePrc (read))
                )
                
                (bind ?fireBurn 0) 
                (while (or (< ?fireBurn 5) (> ?fireBurn 100))
                    (printout t "Insert Flokemon Burn Damage [5 - 100] : ")
                    (bind ?fireBurn (read))
                )
                
                (assert (FLOKEMON_FIRE (fireName ?fireName) (fireDmg ?fireDmg) (fireDfs ?fireDfs) (fireLvl ?fireLvl) (fireBurn ?fireBurn) (firePrc ?firePrc)))
                
                (printout t)
                (printout t "Flokemon successfully added..." crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
          
          elif (eq ?choose2 2)
            then (bind ?waterName "")
            (while (or (eq (lexemep ?waterName) FALSE ) (< (str-length ?waterName) 5 ) (> (str-length ?waterName) 25 ))                  
                            (printout t "Insert Flokemon Name [5 - 25 Character] : ")
                            (bind ?waterName (readline))
                )
                
                (bind ?waterDmg 0) 
                (while (or (< ?waterDmg 10) (> ?waterDmg 5000))
                    (printout t "Insert Flokemon Damage [10 - 5000] : ")
                    (bind ?waterDmg (read))
                )
                
                (bind ?waterDfs 0) 
                (while (or (< ?waterDfs 5) (> ?waterDfs 30))
                    (printout t "Insert Flokemon Defense [5 - 30] : ")
                    (bind ?waterDfs (read))
                )
                
                (bind ?waterLvl 0) 
                (while (or (< ?waterLvl 1) (> ?waterLvl 100))
                    (printout t "Insert Flokemon Level [1 - 100] : ")
                    (bind ?waterLvl (read))
                )
                
                (bind ?waterPrc 0) 
                (while (or (< ?waterPrc 1000) (> ?waterPrc 1000000))
                    (printout t "Insert Flokemon Price [1000 - 1000000] : ")
                    (bind ?waterPrc (read))
                )
                
                (assert (FLOKEMON_WATER (waterName ?waterName) (waterDmg ?waterDmg) (waterDfs ?waterDfs) (waterLvl ?waterLvl) (waterPrc ?waterPrc)))
                
                (printout t)
                (printout t "Flokemon successfully added..." crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
          
          else
            
         
         )
       )
    
    ; Masuk menu UPDATE
    elif (eq ?choose 3)
        then (bind ?choose3 0)
        (cls)
        (while (or (< ?choose3 1) (> ?choose3 3))
            (menuFlokemon)
            (bind ?choose3 (read))
            (if (eq (numberp ?choose3) FALSE) 
                then (bind ?choose3 0)
                )
            
            (if (eq ?choose3 1)
                then 
                (printout t)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             elif (eq ?choose3 2)
                then 
                (printout t)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             else
                
            )
            
            
        )
    
    ; Masuk menu REMOVE  
    elif (eq ?choose 4)
        then 
        
    ; Masuk menu FIND
    elif (eq ?choose 5)
        then 
    
    else
        (printout t "Thank You for using this program! ^^" crlf)
        (printout t "Created by Alyssa & Yulia" crlf)
    )
)