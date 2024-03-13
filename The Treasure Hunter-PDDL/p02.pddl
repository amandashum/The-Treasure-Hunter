(define (problem loc-2-3p2-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 - location
    key1 key2 key3 key4 - key
    c2122 c1222 c2232 c3242 c2223 - corridor
  )

  (:init

    ; Hero location and carrying status
    (at loc-2-2)
    (hand-free)
    (not (holding key1))
    (not (holding key2))
    (not (holding key3))
    (not (holding key4))    

    ; Location <> Corridor Connections
    (connected c1222 loc-1-2 loc-2-2) (connected c1222 loc-2-2 loc-1-2)
    (connected c2122 loc-2-1 loc-2-2) (connected c2122 loc-2-2 loc-2-1)
    (connected c2232 loc-2-2 loc-3-2) (connected c2232 loc-3-2 loc-2-2)
    (connected c3242 loc-3-2 loc-4-2) (connected c3242 loc-4-2 loc-3-2)
    (connected c2223 loc-2-2 loc-2-3) (connected c2223 loc-2-3 loc-2-2)

    ; Key locations
    (key-at key2 loc-1-2)
    (key-at key1 loc-2-1)
    (key-at key3 loc-2-2)
    (key-at key4 loc-2-3)
    
    ; Locked corridors
    (locked c1222 yellow)
    (locked c2232 yellow)
    (locked c2122 purple)
    (locked c2223 green)
    (locked c3242 rainbow)


    ; Risky corridors

    ; Location that can unlock a colored corridor
    (rm-cor loc-1-2  c1222)
    (rm-cor loc-2-2  c2232)
    (rm-cor loc-2-2  c1222)
    (rm-cor loc-3-2  c2232)
    (rm-cor loc-2-2  c2122)
    (rm-cor loc-2-1  c2122)
    (rm-cor loc-2-2  c2223)
    (rm-cor loc-2-3  c2223)
    (rm-cor loc-3-2  c3242)

    ; Key colours
    (key-col key1 green)    
    (key-col key2 rainbow)
    (key-col key3 purple)
    (key-col key4 yellow)

    ; Key usage properties (one use, two use, etc)
    (one-use key1)
    (one-use key2)
    (one-use key3)
    (two-use key4)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (at loc-4-2)
    )
  )

)
