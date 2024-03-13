(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-1-3 loc-2-3 loc-2-4 loc-2-5 - location
    c1121 c1112 c1222 c1213 c2232 c2223 c1323 c2324 c2425 - corridor
    key1 key2 key3 key4 key5 - key
  )

  (:init

    ; Hero location and carrying status
    (at loc-1-1)
    (hand-free)
    (not (holding key1))
    (not (holding key2))
    (not (holding key3))
    (not (holding key4))
    (not (holding key5))
  

    ; Location <> Corridor Connections
    (connected c1121 loc-1-1 loc-2-1) (connected c1121 loc-2-1 loc-1-1)
    (connected c1112 loc-1-1 loc-1-2) (connected c1112 loc-1-2 loc-1-1)
    (connected c1222 loc-1-2 loc-2-2) (connected c1222 loc-2-2 loc-1-2)
    (connected c1213 loc-1-2 loc-1-3) (connected c1213 loc-1-3 loc-1-2)
    (connected c2232 loc-2-2 loc-3-2) (connected c2232 loc-3-2 loc-2-2)
    (connected c2223 loc-2-2 loc-2-3) (connected c2223 loc-2-3 loc-2-2)
  
    (connected c1323 loc-1-3 loc-2-3) (connected c1323 loc-2-3 loc-1-3)
    (connected c2324 loc-2-3 loc-2-4) (connected c2324 loc-2-4 loc-2-3)
    (connected c2425 loc-2-4 loc-2-5) (connected c2425 loc-2-5 loc-2-4)

    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-1-2)
    (key-at key3 loc-2-2)
    (key-at key4 loc-3-2)
    (key-at key5 loc-2-3)

    ; Locked corridors
    (locked c1112 red)
    (locked c2223 red)
    (locked c1222 yellow)
    (locked c1213 yellow)
    (locked c2232 purple)
    (locked c2324 green)
    (locked c2425 rainbow)

    ; Unlocked corridors
    (unlocked c1121)
    (unlocked c1323)

    ; Risky corridors
    (risky c1112)
    (risky c2223)

    ; Key colours
    (key-col key1 red)
    (key-col key2 yellow)
    (key-col key3 purple)
    (key-col key4 rainbow)
    (key-col key5 green)   

    ; Key usage properties (one use, two use, etc)
    (not (unusable key1))
    (two-use key2)
    (one-use key3)
    (one-use key4)
    (one-use key5)

    ; Room loc that can unlock a corridor
    (rm-cor loc-1-1  c1112)

    (rm-cor loc-1-2  c1222) (rm-cor loc-1-2  c1213) 
    (rm-cor loc-2-2  c1222) (rm-cor loc-2-2  c2232) (rm-cor loc-2-2  c2223)
    (rm-cor loc-2-3  c2324) (rm-cor loc-2-3  c2223)
    (rm-cor loc-1-3  c1213) 
    (rm-cor loc-2-4  c2425) (rm-cor loc-2-4  c2324)
    (rm-cor loc-3-2  c2232)
    

  )
  (:goal
    (and
      ; Hero's final location goes here
      (at loc-2-5)      
    )
  )

)
