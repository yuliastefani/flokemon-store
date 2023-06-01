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

(deftemplate Flokemon_Match
	(slot name)
    (slot damage)
    (slot defense)
    (slot level)
    (slot burn_damage)
    (slot price)
)

(deftemplate Flokemon_demand
    (slot type)
	(slot power)
    (slot defense)
    (slot size)
    (slot price)
)

(defquery flokemon-found
	(Flokemon_Match (name ?name) (damage ?damage) (defense ?defense) (level ?level) (burn_damage ?burn_damage) (price ?price))
)

(defquery retrieve-info
    (Flokemon_demand (type ?type) (power ?power) (defense ?defense) (size ?size) (price ?price))
)

(defrule deleteMatch
    (deleteMatch)
	?i <- (Flokemon_Match)
	=>
    (retract ?i)
)

(defrule foundFlokemon
	(foundFlokemon)
    (Flokemon_Match (name ?name) (damage ?damage) (defense ?defense) (level ?level) (burn_damage ?burn_damage) (price ?price))
	=>
    (assert (deleteMatch))
    (run)
    (retract-string "(deleteMatch)")
)

(deffunction menu()
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

(deffunction menuFlokemon()
    (printout t "1. Fire Flokemon" crlf)
    (printout t "2. Water Flokemon" crlf)
    (printout t "3. Back" crlf)
    (printout t "Choose: ")
)

(defglobal 
    ?*numFlokemonFire* = 5
    ?*numFlokemonWater* = 5
    ?*num* = 1
    ?*number* = 1
    
    ?*lvl* = 0
    ?*budget* = 0
    ?*confirm* = ""
)

(defrule viewRuleFlokemonFire
    (printFlokemonFire)
	(FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-20d|%-10d|" ?*num* ?fn ?fg ?fd ?fl ?fb ?fp)
    (printout t crlf)
    (++ ?*num*)
)

(defrule viewRuleFlokemonWater
    (printFlokemonWater)
	(FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (format t "|%2d.|%-29s|%-10d|%-10d|%-10d|%-10d|" ?*num* ?wn ?wg ?wd ?wl ?wp)
    (printout t crlf)
    (++ ?*num*)
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
    ?f<-(modifyFlokemonFire ?fid ?fn ?fg ?fd ?fl ?fb ?fp)
    ?ff<-(FLOKEMON_FIRE)
    =>
    (if(eq ?fid ?*num*)
        then
        (modify ?ff (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))      
        (retract ?f)  
    	(bind ?*num* 1)
    else
    	(++ ?*num*)        
        )
    )

(defrule updateRuleFlokemonWater
    ?f<-(modifyFlokemonWater ?wid ?wn ?wg ?wd ?wl ?wp)
    ?fw<-(FLOKEMON_WATER)
    =>
    (if(eq ?wid ?*num*)
        then
        (modify ?fw (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
        (retract ?f)
        (bind ?*num* 1)
    else
        (++ ?*num*)
    )
)

(deffunction retract-i (?i)
	(++ ?*number*)
    (if (eq ?*number* 10)
        then (retract ?i)   
        (bind ?*number* 1)
    )
)

(defrule Fire
    ?i<-(Fire)
    =>
    (bind ?power "")
    (while (and (neq (eq (lexemep ?power) FALSE ) (neq (str-compare ?power "Weak") 0 ) (neq (str-compare ?power "Strong") 0 )))
        (printout t "Demanded power [Weak | Strong]: ")
        (bind ?power (readline)))
    (if (eq ?power "Weak")
        then (assert(FireWeak))
     elif (eq ?power "Strong")
        then (assert(FireStrong))
    )
    (retract ?i)
)

(defrule FireWeak
	?i<-(FireWeak)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (bind ?defense "")
    (while (and (neq (eq (lexemep ?defense) FALSE ) (neq (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 )))
        (printout t "Demanded defense [Soft | Hard]: ")
        (bind ?defense (readline)))
    (if (eq ?defense "Soft")
        then (inputFind)
        (assert (FireWeakSoft ?*lvl* ?*budget* ?*confirm*))
     elif (eq ?defense "Hard")
        then (inputFind)
        (assert(FireWeakHard ?*lvl* ?*budget* ?*confirm*))
    )
    (retract ?i)
)

(defrule FireStrong
	?i<-(FireStrong)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (bind ?defense "")
    (while (and (neq (eq (lexemep ?defense) FALSE ) (neq (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 )))
        (printout t "Demanded defense [Soft | Hard]: ")
        (bind ?defense (readline)))
    (if (eq ?defense "Soft")
        then (inputFind)
        (assert(FireStrongSoft ?*lvl* ?*budget* ?*confirm*))
     elif (eq ?defense "Hard")
        then (inputFind) 
        (assert(FireStrongHard ?*lvl* ?*budget* ?*confirm*))
    )
    (retract ?i)
)

(defrule FireWeakSoft
	?i<-(FireWeakSoft ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (< ?fd 100) (< ?fg 1000) (eq ?type "Fire"))
	            then (bind ?matchFId 0)
	            (if (and (>= ?fl ?*lvl*) (<= ?fp ?*budget*))
	                then (assert (Flokemon_Match (name ?fn) (damage ?fg) (defense ?fd) (level ?fl) (burn_damage ?fb) (price ?fp)))
	                (assert (Flokemon_demand (type "Fire") (power "Weak") (defense "Soft") (size ?*lvl*) (price ?*budget*)))
            	)
                (new main.GUI)
         	)
        )
    (retract-i ?i)
)

(defrule FireWeakHard
	?i<-(FireWeakHard ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (>= ?fd 100) (< ?fg 1000) (eq ?type "Fire"))
	            then (bind ?matchFId 0)
	            (if (and (>= ?fl ?*lvl*) (<= ?fp ?*budget*))
	                then (assert (Flokemon_Match (name ?fn) (damage ?fg) (defense ?fd) (level ?fl) (burn_damage ?fb) (price ?fp)))
	                (assert (Flokemon_demand (type "Fire") (power "Weak") (defense "Hard") (size ?*lvl*) (price ?*budget*)))
            	)
                (new main.GUI)
         	)
        )
    (retract-i ?i)
)

(defrule FireStrongSoft
	?i<-(FireStrongSoft ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (< ?fd 100) (>= ?fg 1000) (eq ?type "Fire"))
	            then (bind ?matchFId 0)
	            (if (and (>= ?fl ?*lvl*) (<= ?fp ?*budget*))
	                then (assert (Flokemon_Match (name ?fn) (damage ?fg) (defense ?fd) (level ?fl) (burn_damage ?fb) (price ?fp)))
	                (assert (Flokemon_demand (type "Fire") (power "Strong") (defense "Soft") (size ?*lvl*) (price ?*budget*)))
            	)	
                (new main.GUI)
         	)
        )
    (retract-i ?i)
)

(defrule FireStrongHard
	?i<-(FireStrongHard ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_FIRE (fireName ?fn) (fireDmg ?fg) (fireDfs ?fd) (fireLvl ?fl) (fireBurn ?fb) (firePrc ?fp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (>= ?fd 100) (>= ?fg 1000) (eq ?type "Fire"))
	            then (bind ?matchFId 0)
	            (if (and (>= ?fl ?*lvl*) (<= ?fp ?*budget*))
	                then (assert (Flokemon_Match (name ?fn) (damage ?fg) (defense ?fd) (level ?fl) (burn_damage ?fb) (price ?fp)))
	                (assert (Flokemon_demand (type "Fire") (power "Strong") (defense "Hard") (size ?*lvl*) (price ?*budget*)))
            	)
            (new main.GUI)
         )
        
    )
    (retract-i ?i)
)

(defrule Water
    ?i<-(Water)
    =>
    (bind ?power "")
    (while (and (neq (eq (lexemep ?power) FALSE ) (neq (str-compare ?power "Weak") 0 ) (neq (str-compare ?power "Strong") 0 )))
        (printout t "Demanded power [Weak | Strong]: ")
        (bind ?power (readline)))
    (if (eq ?power "Weak")
        then (assert(WaterWeak))
     elif (eq ?power "Strong")
        then (assert(WaterStrong))
    )
    (retract ?i)
)

(defrule WaterWeak
	?i<-(WaterWeak)
    (FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (bind ?defense "")
    (while (and (neq (eq (lexemep ?defense) FALSE ) (neq (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 )))
        (printout t "Demanded defense [Soft | Hard]: ")
        (bind ?defense (readline)))
    (if (eq ?defense "Soft")
        then (inputFind)
        (assert(WaterWeakSoft ?*lvl* ?*budget* ?*confirm*))
     elif (eq ?defense "Hard")
        then (inputFind)
        (assert(WaterWeakHard ?*lvl* ?*budget* ?*confirm*))
    )
    (retract ?i)
)

(defrule WaterStrong
	?i<-(WaterStrong)
	=>
    (bind ?defense "")
    (while (and (neq (eq (lexemep ?defense) FALSE ) (neq (str-compare ?defense "Soft") 0 ) (neq (str-compare ?defense "Hard") 0 )))
        (printout t "Demanded defense [Soft | Hard]: ")
        (bind ?defense (readline)))
    (if (eq ?defense "Soft")
        then (inputFind)
        (assert(WaterStrongSoft ?*lvl* ?*budget* ?*confirm*))
     elif (eq ?defense "Hard")
        then (inputFind)
        (assert(WaterStrongHard ?*lvl* ?*budget* ?*confirm*))
    )
    (retract ?i)
)

(defrule WaterWeakSoft
	?i<-(WaterWeakSoft ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (< ?wd 100) (< ?wg 1000) (eq ?type "Water"))
            then (bind ?matchWId 0)
            (if (and (>= ?wl ?*lvl*) (<= ?wp ?*budget*))
                then (assert (Flokemon_Match (name ?wn) (damage ?wg) (defense ?wd) (level ?wl) (price ?wp)))
                (assert (Flokemon_demand (type "Water") (power "Weak") (defense "Soft") (size ?*lvl*) (price ?*budget*)))
             )
        )
    )
    
    (new main.GUI)
    (retract-i ?i)
)

(defrule WaterWeakHard
	?i<-(WaterWeakHard ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (>= ?wd 100) (< ?wg 1000) (eq ?type "Water"))
            then (bind ?matchWId 0)
            (if (and (>= ?wl ?*lvl*) (<= ?wp ?*budget*))
                then (assert (Flokemon_Match (name ?wn) (damage ?wg) (defense ?wd) (level ?wl) (price ?wp)))
                (assert (Flokemon_demand (type "Water") (power "Weak") (defense "Hard") (size ?*lvl*) (price ?*budget*)))
             )
        )
    )
    
    (new main.GUI)
    
    (retract-i ?i)
)

(defrule WaterStrongSoft
	?i<-(WaterStrongSoft ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (< ?wd 100) (>= ?wg 1000) (eq ?type "Water"))
            then (bind ?matchWId 0)
            (if (and (>= ?wl ?*lvl*) (<= ?wp ?*budget*))
                then (assert (Flokemon_Match (name ?wn) (damage ?wg) (defense ?wd) (level ?wl) (price ?wp)))
                (assert (Flokemon_demand (type "Water") (power "Strong") (defense "Soft") (size ?*lvl*) (price ?*budget*)))
             )
             (new main.GUI)
        )
    )
    (retract-i ?i)
)

(defrule WaterStrongHard
	?i<-(WaterStrongHard ?*lvl* ?*budget* ?*confirm*)
    (FLOKEMON_WATER (waterName ?wn) (waterDmg ?wg) (waterDfs ?wd) (waterLvl ?wl) (waterPrc ?wp))
	=>
    (if (eq ?*confirm* "Y")
        then 
        (if (and (>= ?wd 100) (>= ?wg 1000) (eq ?type "Water"))
            then (bind ?matchWId 0)
            (if (and (>= ?wl ?*lvl*) (<= ?wp ?*budget*))
                then (assert (Flokemon_Match (name ?wn) (damage ?wg) (defense ?wd) (level ?wl) (price ?wp)))
                (assert (Flokemon_demand (type "Water") (power "Strong") (defense "Hard") (size ?*lvl*) (price ?*budget*)))
             )
            (new main.GUI)
        )
    )
    (retract-i ?i)
)



(deffunction viewFlokemonFire()
    (printout t "Fire Flokemon List" crlf)
    (printout t "====================================================================================================" crlf)
    (printout t "|No.|Name                         |Damage    |Defense   |Level     |Burn Damage         |Price     |" crlf)
    (printout t "====================================================================================================" crlf)
    (retract-string "(printFlokemonFire)")
    (assert(printFlokemonFire))
    (run)
    (printout t "====================================================================================================" crlf)
    (printout t))

(deffunction viewFlokemonWater()
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

(deffunction inputFind()
    (bind ?*lvl* 0)
    (while (or (eq (lexemep ?*lvl*) TRUE ) (< ?*lvl* 1) (> ?*lvl* 100))
        (printout t "Demanded minimum flokemon level [1 - 100]: ")
        (bind ?*lvl* (read)))
    
    (bind ?*budget* 0)
    (while (or (eq (lexemep ?*budget*) TRUE ) (< ?*budget* 1000) (> ?*budget* 1000000))
        (printout t "Budget for flokemon [1000 - 1000000]: ")
    	(bind ?*budget* (read)))
    
    (bind ?*confirm* "")
    (while (and (neq (eq (lexemep ?*confirm*) FALSE ) (neq (str-compare ?*confirm* "Y") 0 ) (neq (str-compare ?*confirm* "N") 0 )))
        (printout t "Are you sure to find this type of flokemon [Y | N]: ")
    	(bind ?*confirm* (readline)))
     )

(reset)
(bind ?choose 0)
(while (neq ?choose 6)
    (bind ?*num* 1)
    (run)
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
                (printout t)
                (printout t "Successfully update fire flokemon!" crlf)
                (printout t "Press ENTER to continue ..." crlf)
                (readline)
                
             elif (eq ?choose3 2)
                then (cls)
                (viewFlokemonWater)
               	(updateFlokemonWater)
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

        (while (and (neq (eq (lexemep ?type) FALSE ) (neq (str-compare ?type "Fire") 0 ) (neq (str-compare ?type "Water") 0 )))
            (printout t "Demanded type [Fire | Water]: ")
        	(bind ?type (readline)))
        (if (eq ?type "Fire")
            then (assert (Fire))
         elif (eq ?type "Water")
            then (assert (Water))
        )
        (run)
        
    else
        (printout t "Thank You for using this program! ^^" crlf)
        (printout t "Created by Alyssa & Yulia" crlf)
    )
)