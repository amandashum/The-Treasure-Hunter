(define (problem p1-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location
    key1 key2 key3 key4 - key
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

  (:init

    ; Hero location and carrying status
    (at loc-1-2)
    (hand-free)
    (not (holding key1))
    (not (holding key2))
    (not (holding key3))
    (not (holding key4))

    ; Location <> Corridor Connections
    (connected c3132 loc-3-1 loc-3-2) (connected c3132 loc-3-2 loc-3-1)
    (connected c1222 loc-1-2 loc-2-2) (connected c1222 loc-2-2 loc-1-2)
    (connected c2232 loc-2-2 loc-3-2) (connected c2232 loc-3-2 loc-2-2)
    (connected c3242 loc-3-2 loc-4-2) (connected c3242 loc-4-2 loc-3-2)
    (connected c2223 loc-2-2 loc-2-3) (connected c2223 loc-2-3 loc-2-2)
    (connected c3233 loc-3-2 loc-3-3) (connected c3233 loc-3-3 loc-3-2)
    (connected c2333 loc-2-3 loc-3-3) (connected c2333 loc-3-3 loc-2-3)
    (connected c2324 loc-2-3 loc-2-4) (connected c2324 loc-2-4 loc-2-3)
    (connected c3334 loc-3-3 loc-3-4) (connected c3334 loc-3-4 loc-3-3)
    (connected c2434 loc-2-4 loc-3-4) (connected c2434 loc-3-4 loc-2-4)
    (connected c3444 loc-3-4 loc-4-4) (connected c3444 loc-4-4 loc-3-4)

    ; Key locations
    (key-at key1 loc-2-2)
    (key-at key2 loc-2-4)
    (key-at key3 loc-4-2)
    (key-at key4 loc-4-4)

    ; Locked corridors
    (locked c2324 red)
    (locked c2434 red)
    (locked c3242 purple)
    (locked c3444 yellow)
    (locked c3132 rainbow)

    ; Unlocked corridors
    (unlocked c1222)
    (unlocked c2232)
    (unlocked c2223)
    (unlocked c2333)
    (unlocked c3233)
    (unlocked c3334)

    ; Room loc that can unlock a corridor
    (rm-cor loc-2-3 c2324)
    (rm-cor loc-2-4 c2434)
    (rm-cor loc-2-4 c2324)
    (rm-cor loc-3-4 c2434)
    (rm-cor loc-3-2 c3242)
    (rm-cor loc-3-4 c3444)
    (rm-cor loc-3-2 c3132)
    
    ; Risky corridors
    (risky c2324)
    (risky c2434)

    ; Key colours
    (key-col key1 red)
    (key-col key2 yellow)
    (key-col key3 rainbow)
    (key-col key4 purple)

    ; Key usage properties (one use, two use, etc)
    (not (unusable key1))
    (two-use key2)
    (one-use key3)
    (one-use key4)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (at loc-3-1)
    )
  )

)
