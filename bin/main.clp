; 2301911842 - Alyssa Imani
; 2301867873 - Yulia Stefani


(deffunction cls ()
	(for (bind ?i 0) (< ?i 25) (++ ?i)
        (printout t crlf)
    )
)

(deftemplate FLOKEMON_FIRE
    (slot fireId)
	(slot fireName)
	(slot fireDmg)
	(slot fireDfs)
	(slot fireLvl)
    (slot fireBurn)
	(slot firePrc)
)

(deffacts FLOKEMON_FIRE_FACTS
	(FLOKEMON_FIRE (fireId 5) (fireName "Charmeloen") (fireDmg 1200) (fireDfs 250) (fireLvl 85) (fireBurn 90) (firePrc 230000))
	(FLOKEMON_FIRE (fireId 4) (fireName "NineTales") (fireDmg 1400) (fireDfs 270) (fireLvl 80) (fireBurn 80) (firePrc 540000))
	(FLOKEMON_FIRE (fireId 3) (fireName "Gloqlithe") (fireDmg 2100) (fireDfs 150) (fireLvl 65) (fireBurn 60) (firePrc 300000))
	(FLOKEMON_FIRE (fireId 2) (fireName "Magmar") (fireDmg 400) (fireDfs 120) (fireLvl 60) (fireBurn 40) (firePrc 200000))
	(FLOKEMON_FIRE (fireId 1) (fireName "Rapidash") (fireDmg 500) (fireDfs 50) (fireLvl 10) (fireBurn 10) (firePrc 50000))
)

(deftemplate FLOKEMON_WATER
    (slot waterId)
	(slot waterName)
	(slot waterDmg)
	(slot waterDfs)
	(slot waterLvl)
	(slot waterPrc)
)

(deffacts FLOKEMON_WATER_FACTS
	(FLOKEMON_WATER (waterId 5) (waterName "Blastoise") (waterDmg 1500) (waterDfs 200) (waterLvl 80) (waterPrc 150000))
	(FLOKEMON_WATER (waterId 4) (waterName "Goldluck") (waterDmg 2000) (waterDfs 250) (waterLvl 90) (waterPrc 200000))
	(FLOKEMON_WATER (waterId 3) (waterName "Poliwhirl") (waterDmg 500) (waterDfs 90) (waterLvl 20) (waterPrc 250000))
	(FLOKEMON_WATER (waterId 2) (waterName "Staryu") (waterDmg 800) (waterDfs 70) (waterLvl 30) (waterPrc 50000))
	(FLOKEMON_WATER (waterId 1) (waterName "Vaporeon") (waterDmg 900) (waterDfs 120) (waterLvl 45) (waterPrc 80000))
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
    (printout t "1. Fire Flokemon" crlf)
    (printout t "2. Water Flokemon" crlf)
    (printout t "3. Back" crlf)
    (printout t "Choose: ")
)

(defglobal 
    ?*numFlokemonFire* = 5
    ?*numFlokemonWater* = 5 
    ?*num* = 1
)

(defrule viewRuleFlokemonFire
    (printFlokemonFire)
	(FLOKEMON_FIRE (fireId ?fid) (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-20d|%-10d|" ?fid ?fn ?fg ?fd ?fl ?fb ?fp)
    (printout t crlf)
)

(defrule viewRuleFlokemonWater
    (printFlokemonWater)
	(FLOKEMON_WATER (waterId ?wid) (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-10d|" ?wid ?wn ?wg ?wd ?wl ?wp)
    (printout t crlf)
)

(defrule retractFlokemonFire
    (deleteFlokemonFire ?idx)
    ?i<-(FLOKEMON_FIRE (fireId  ?idx))
    =>
    (retract ?i))

(defrule retractFlokemonWater
    (deleteFlokemonWater ?idx)
    ?i<-(FLOKEMON_WATER (waterId  ?idx))
    =>
    (retract ?i))

(defrule updateRuleFlokemonFire
    (modifyFlokemonFire ?fid ?fn ?fg ?fd ?fl ?fb ?fp)
    ?f<-(FLOKEMON_FIRE (fireId ?fid))
    =>
    (modify ?f (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp)))

(defrule updateRuleFlokemonWater
    (modifyFlokemonWater ?wid ?wn ?wg ?wd ?wl ?wp)
    ?w<-(FLOKEMON_WATER (waterId ?wid))
    =>
    (modify ?w (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp)))

(deffunction viewFlokemonFire ()
    (printout t "Fire Flokemon List" crlf)
    (printout t "====================================================================================================" crlf)
    (printout t "|No.|Name                         |Damage    |Defense   |Level     |Burn Damage         |Price     |" crlf)
    (printout t "====================================================================================================" crlf)
    (retract-string "(printFlokemonFire)")
    (assert(printFlokemonFire))
    (run)
    (printout t "====================================================================================================" crlf)
    (printout t))

(deffunction viewFlokemonWater ()
    (printout t "Water Flokemon List" crlf)
    (printout t "===============================================================================" crlf)
    (printout t "|No.|Name                         |Damage    |Defense   |Level     |Price     |" crlf)
    (printout t "===============================================================================" crlf)
    (retract-string "(printFlokemonWater)")
    (assert(printFlokemonWater))
    (run)
    (printout t "===============================================================================" crlf)
    (printout t))

(deffunction addFlokemonFire()
    (bind ?fireName "")
    (while (or (eq (lexemep ?fireName) FALSE ) (< (str-length ?fireName) 5 ) (> (str-length ?fireName) 25 ))
        (printout t "Insert Flokemon Name [5 - 25 Character] : ")
        (bind ?fireName (readline))
    )
    
    (bind ?fireDmg 0) 
    (while (or (eq (lexemep ?fireDmg) TRUE ) (< ?fireDmg 10) (> ?fireDmg 5000))
        (printout t "Insert Flokemon Damage [10 - 5000] : ")
        (bind ?fireDmg (read))
    )
    
    (bind ?fireDfs 0) 
    (while (or (eq (lexemep ?fireDfs) TRUE ) (< ?fireDfs 5) (> ?fireDfs 300))
        (printout t "Insert Flokemon Defense [5 - 300] : ")
        (bind ?fireDfs (read))
    )
    
    (bind ?fireLvl 0) 
    (while (or (eq (lexemep ?fireLvl) TRUE ) (< ?fireLvl 1) (> ?fireLvl 100))
        (printout t "Insert Flokemon Level [1 - 100] : ")
        (bind ?fireLvl (read))
    )
    
    (bind ?firePrc 0) 
    (while (or (eq (lexemep ?firePrc) TRUE ) (< ?firePrc 1000) (> ?firePrc 1000000))
        (printout t "Insert Flokemon Price [1000 - 1000000] : ")
        (bind ?firePrc (read))
    )
    
    (bind ?fireBurn 0) 
    (while (or (eq (lexemep ?fireBurn) TRUE ) (< ?fireBurn 5) (> ?fireBurn 100))
        (printout t "Insert Flokemon Burn Damage [5 - 100] : ")
        (bind ?fireBurn (read))
    )
    (++ ?*numFlokemonFire*)
    (bind ?fireId  ?*numFlokemonFire*)
    (assert (FLOKEMON_FIRE (fireId ?fireId) (fireName ?fireName) (fireDmg ?fireDmg) (fireDfs ?fireDfs) (fireLvl ?fireLvl) (fireBurn ?fireBurn) (firePrc ?firePrc)))
    )

(deffunction addFlokemonWater()
    (bind ?waterName "")
    (while (or (eq (lexemep ?waterName) FALSE ) (< (str-length ?waterName) 5 ) (> (str-length ?waterName) 25 ))                  
	    (printout t "Insert Flokemon Name [5 - 25 Character] : ")
        (bind ?waterName (readline))
    )
    
    (bind ?waterDmg 0) 
    (while (or (eq (lexemep ?waterDmg) TRUE ) (< ?waterDmg 10) (> ?waterDmg 5000))
        (printout t "Insert Flokemon Damage [10 - 5000] : ")
        (bind ?waterDmg (read))
    )
    
    (bind ?waterDfs 0) 
    (while (or (eq (lexemep ?waterDfs) TRUE ) (< ?waterDfs 5) (> ?waterDfs 300))
        (printout t "Insert Flokemon Defense [5 - 300] : ")
        (bind ?waterDfs (read))
    )
    
    (bind ?waterLvl 0) 
    (while (or (eq (lexemep ?waterLvl) TRUE ) (< ?waterLvl 1) (> ?waterLvl 100))
        (printout t "Insert Flokemon Level [1 - 100] : ")
        (bind ?waterLvl (read))
    )
    
    (bind ?waterPrc 0) 
    (while (or (eq (lexemep ?waterPrc) TRUE ) (< ?waterPrc 1000) (> ?waterPrc 1000000))
        (printout t "Insert Flokemon Price [1000 - 1000000] : ")
        (bind ?waterPrc (read))
    )
    (++ ?*numFlokemonWater*)
	(bind ?waterId ?*numFlokemonWater*)
    (assert (FLOKEMON_WATER (waterId ?waterId) (waterName ?waterName) (waterDmg ?waterDmg) (waterDfs ?waterDfs) (waterLvl ?waterLvl) (waterPrc ?waterPrc)))
	)

(deffunction updateFlokemonFire()

    (bind ?idx 0)
    (while (or (eq (lexemep ?idx) TRUE ) (< ?idx 1) (> ?idx ?*numFlokemonFire*))
        (format t "Input flokemon number to be updated [%d - %d]: " 1 ?*numFlokemonFire*)
        (bind ?idx (read))
        )
    
    (bind ?fireName "")
    (while (or (eq (lexemep ?fireName) FALSE ) (< (str-length ?fireName) 5 ) (> (str-length ?fireName) 25 ))
            (printout t "Insert Flokemon Name [5 - 25 Character] : ")
            (bind ?fireName (readline))
        )
        
    (bind ?fireDmg 0) 
    (while (or (eq (lexemep ?fireDmg) TRUE ) (< ?fireDmg 10) (> ?fireDmg 5000))
        (printout t "Insert Flokemon Damage [10 - 5000] : ")
        (bind ?fireDmg (read))
    )
    
    (bind ?fireDfs 0) 
    (while (or (eq (lexemep ?fireDfs) TRUE ) (< ?fireDfs 5) (> ?fireDfs 300))
        (printout t "Insert Flokemon Defense [5 - 300] : ")
        (bind ?fireDfs (read))
    )
    
    (bind ?fireLvl 0) 
    (while (or (eq (lexemep ?fireLvl) TRUE ) (< ?fireLvl 1) (> ?fireLvl 100))
        (printout t "Insert Flokemon Level [1 - 100] : ")
        (bind ?fireLvl (read))
    )
    
    (bind ?firePrc 0) 
    (while (or (eq (lexemep ?firePrc) TRUE ) (< ?firePrc 1000) (> ?firePrc 1000000))
        (printout t "Insert Flokemon Price [1000 - 1000000] : ")
        (bind ?firePrc (read))
    )
    
    (bind ?fireBurn 0) 
    (while (or (eq (lexemep ?fireBurn) TRUE ) (< ?fireBurn 5) (> ?fireBurn 100))
        (printout t "Insert Flokemon Burn Damage [5 - 100] : ")
        (bind ?fireBurn (read))
    )
    (assert (modifyFlokemonFire ?idx ?fireName ?fireDmg ?fireDfs ?fireLvl ?fireBurn ?firePrc))
   )

(deffunction updateFlokemonWater()
    (bind ?idx 0)
    (while (or (eq (lexemep ?idx) TRUE ) (< ?idx 1) (> ?idx ?*numFlokemonFire*))
        (format t "Input flokemon number to be updated [%d - %d]: " 1 ?*numFlokemonFire*)
        (bind ?idx (read))
        )
    (bind ?waterName "")
    (while (or (eq (lexemep ?waterName) FALSE ) (< (str-length ?waterName) 5 ) (> (str-length ?waterName) 25 ))                  
        (printout t "Insert Flokemon Name [5 - 25 Character] : ")
        (bind ?waterName (readline))
    )
    
    (bind ?waterDmg 0) 
    (while (or (eq (lexemep ?waterDmg) TRUE ) (< ?waterDmg 10) (> ?waterDmg 5000))
        (printout t "Insert Flokemon Damage [10 - 5000] : ")
        (bind ?waterDmg (read))
    )
    
    (bind ?waterDfs 0) 
    (while (or (eq (lexemep ?waterDfs) TRUE ) (< ?waterDfs 5) (> ?waterDfs 300))
        (printout t "Insert Flokemon Defense [5 - 300] : ")
        (bind ?waterDfs (read))
    )
    
    (bind ?waterLvl 0) 
    (while (or (eq (lexemep ?waterLvl) TRUE ) (< ?waterLvl 1) (> ?waterLvl 100))
        (printout t "Insert Flokemon Level [1 - 100] : ")
        (bind ?waterLvl (read))
    )
    
    (bind ?waterPrc 0) 
    (while (or (eq (lexemep ?waterPrc) TRUE ) (< ?waterPrc 1000) (> ?waterPrc 1000000))
        (printout t "Insert Flokemon Price [1000 - 1000000] : ")
        (bind ?waterPrc (read))
        )
    (assert (modifyFlokemonWater ?idx ?waterName ?waterDmg ?waterDfs ?waterLvl ?waterPrc))
    )

(reset)
(bind ?choose 0)
(while (neq ?choose 6)
    (menu)
    (bind ?choose 0)
    (while (or (eq (lexemep ?choose) TRUE ) (< ?choose 1) (> ?choose 6))
        (printout t "Choose: ")
        (bind ?choose (read))
        (if (eq (numberp ?choose) FALSE) 
            then (bind ?choose 0)
        )
    )
    
    ; Masuk menu VIEW
    (if (eq ?choose 1)
        then (bind ?choose1 0)
	    (cls)
	    (while (or (eq (lexemep ?choose1) TRUE ) (< ?choose1 1) (> ?choose1 3))
            (printout t "Choose Flokemon Type to view" crlf)
	        (menuFlokemon)
	        (bind ?choose1 (read))
	        (if (eq (numberp ?choose1) FALSE) 
	            then (bind ?choose1 0)
	        )
	            
		    ; Masuk View
		    (if (eq ?choose1 1)
		        then (viewFlokemonFire)
                (printout t "Press ENTER to continue ..." crlf)
    			(readline)
		                
		     elif (eq ?choose1 2)
		        then (viewFlokemonWater)
		        (printout t "Press ENTER to continue ..." crlf)
    			(readline)        
		     else
             )
                 
	    )
        
        
    ; Masuk menu ADD    
    elif (eq ?choose 2)
        then (bind ?choose2 0)
        (cls)
        (while (or (eq (lexemep ?choose2) TRUE ) (< ?choose2 1) (> ?choose2 3))
            (printout t "Choose Flokemon Type to add" crlf)
            (menuFlokemon)
            (bind ?choose2 (read))
            (if (eq (numberp ?choose2) FALSE) 
                then (bind ?choose2 0)
            )
         
	        ; Masuk Add Fire Flokemon
	        (if (eq ?choose2 1)
	           then
                (addFlokemonFire) 
                (printout t)
			    (printout t "Flokemon successfully added..." crlf)
			    (printout t "Press ENTER to continue ..." crlf)
			    (readline)
	          
	         elif (eq ?choose2 2)
	           then
                (addFlokemonWater)
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
        (while (or (eq (lexemep ?choose3) TRUE ) (< ?choose3 1) (> ?choose3 3))
            (printout t "Choose Flokemon Type to update" crlf)
            (menuFlokemon)
            (bind ?choose3 (read))
            (if (eq (numberp ?choose3) FALSE) 
                then (bind ?choose3 0)
                )
            
            (if (eq ?choose3 1)
                then (cls)
                (viewFlokemonFire)
                (updateFlokemonFire)
                (run)
                (printout t)
                (printout t "Successfully update fire flokemon!" crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             elif (eq ?choose3 2)
                then (cls)
                (viewFlokemonWater)
               	(updateFlokemonWater)
                (run)
                (printout t)
                (printout t "Successfully update water flokemon!" crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             else
                
            )
        )
    
    ; Masuk menu REMOVE  
    elif (eq ?choose 4)
        then (bind ?choose4 0)
        (cls)
        (while (or (eq (lexemep ?choose4) TRUE ) (< ?choose4 1) (> ?choose4 3))
            (printout t "Choose Flokemon Type to remove" crlf)
            (menuFlokemon)
            (bind ?choose4 (read))
            (if (eq (numberp ?choose4) FALSE) 
                then (bind ?choose4 0)
                )
            
            (if (eq ?choose4 1)
                then 
                (cls)
                (viewFlokemonFire)
                (bind ?idx 0)
                (while (or (eq (lexemep ?idx) TRUE ) (< ?idx 1) (> ?idx ?*numFlokemonFire*))
                    (format t "Input flokemon number to be deleted [%d - %d]:" 1 ?*numFlokemonFire*)
                    (bind ?idx (read)))
                (printout t)
                (assert(deleteFlokemonFire ?idx))
                ;Run Error
                (run)
                (-- ?*numFlokemonFire*)
                (printout t "Successfully deleted!" crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             elif (eq ?choose4 2)
                then 
                (cls)
                (viewFlokemonWater)
                (bind ?idx 0)
                (while (or (eq (lexemep ?idx) TRUE ) (< ?idx 1) (> ?idx ?*numFlokemonWater*))
                    (format t "Input flokemon number to be deleted [%d - %d]: " 1 ?*numFlokemonWater*)
                    (bind ?idx (read)))
                (printout t)
                (assert(deleteFlokemonWater ?idx))
                ;Run Error
                (run)
                (-- ?*numFlokemonWater*)
                (printout t "Successfully deleted!" crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             else
                
            )
        )
        
    ; Masuk menu FIND
    elif (eq ?choose 5)
        then (cls)
        (printout t "Find Flokemon" crlf)
        (printout t "-----------------" crlf)
        (bind ?type "")
<<<<<<< HEAD
        (while (and (eq (lexemep ?type) FALSE ) (neq (str-compare ?type "Fire") 0 ) (neq (str-compare ?type "Water") 0 ))
=======
        (while (and (neq (eq (lexemep ?type) FALSE ) (neq (str-compare ?type "Fire") 0 ) (neq (str-compare ?type "Water") 0 )))
>>>>>>> a61aad3ae52e50f4f7ab83084d971b0c6df0eabb
            (printout t "Demanded type [Fire | Water]: ")
        	(bind ?type (read)))            
            
    	(bind ?power "")
<<<<<<< HEAD
        (while (and (eq (lexemep ?power) FALSE ) (neq (str-compare ?power "Weak") 0 ) (neq (str-compare ?power "Strong") 0 ))
=======
        (while (and (neq (eq (lexemep ?power) FALSE ) (neq (str-compare ?power "Weak") 0 ) (neq (str-compare ?power "Strong") 0 )))
>>>>>>> a61aad3ae52e50f4f7ab83084d971b0c6df0eabb
            (printout t "Demanded power [Weak | Strong]: ")
        	(bind ?power (read)))            
            
		(bind ?defense "")
<<<<<<< HEAD
        (while (and (neq (eq (lexemep ?defense) FALSE ) (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 ))
=======
        (while (and (neq (eq (lexemep ?defense) FALSE ) (neq (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 )))
>>>>>>> a61aad3ae52e50f4f7ab83084d971b0c6df0eabb
            (printout t "Demanded defense [Soft | Hard]: ")
        	(bind ?defense (read)))
        
        (bind ?lvl 0)
        (while (or (eq (lexemep ?lvl) TRUE ) (< ?lvl 1) (> ?lvl 100))
            (printout t "Demanded minimum flokemon level [1 - 100]: ")
        	(bind ?lvl (read)))            
        
        (bind ?budget 0)
        (while (or (eq (lexemep ?budget) TRUE ) (< ?budget 1000) (> ?budget 1000000))
            (printout t "Budget for flokemon [1000 - 1000000]: ")
        	(bind ?budget (read)))    
        
        (bind ?confirm "")
        (while (and (eq (lexemep ?confirm) FALSE ) (neq (str-compare ?confirm "Y") 0 ) (neq (str-compare ?confirm "N") 0 ))
            (printout t "Are you sure to find this type of flokemon [Y | N]: ")
        	(bind ?confirm (read)))   
        
    else
        (printout t "Thank You for using this program! ^^" crlf)
        (printout t "Created by Alyssa & Yulia" crlf)
    )
)