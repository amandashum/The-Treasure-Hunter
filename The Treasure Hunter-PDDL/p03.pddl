(define (problem p3-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-4 loc-4-5 loc-1-2 loc-2-2 loc-3-2 loc-3-3 loc-2-5 loc-1-3 loc-2-1 loc-1-4 loc-3-5 loc-2-4 loc-4-4 loc-2-3 loc-4-3 - location
    c2122 c1222 c2232 c1213 c1223 c2223 c3223 c3233 c1323 c2333 c1314 c2314 c2324 c2334 c3334 c1424 c2434 c2425 c2535 c3545 c4544 c4443 - corridor
    key1 key2 key3 key4 key5 key6 - key
  )

  (:init

    ; Hero location and carrying status
    (at loc-2-1)
    (hand-free)
    (not (holding key1))
    (not (holding key2))
    (not (holding key3))
    (not (holding key4))
    (not (holding key5))
    (not (holding key6))

    ; Location <> Corridor Connections
    (connected c2122 loc-2-1 loc-2-2) (connected c2122 loc-2-2 loc-2-1)
    (connected c1222 loc-1-2 loc-2-2) (connected c1222 loc-2-2 loc-1-2)
    (connected c2232 loc-2-2 loc-3-2) (connected c2232 loc-3-2 loc-2-2)
    (connected c1213 loc-1-2 loc-1-3) (connected c1213 loc-1-3 loc-1-2)
    (connected c1223 loc-1-2 loc-2-3) (connected c1223 loc-2-3 loc-1-2)
    (connected c2223 loc-2-2 loc-2-3) (connected c2223 loc-2-3 loc-2-2)
    (connected c3223 loc-3-2 loc-2-3) (connected c3223 loc-2-3 loc-3-2)
    (connected c3233 loc-3-2 loc-3-3) (connected c3233 loc-3-3 loc-3-2)
    (connected c1323 loc-1-3 loc-2-3) (connected c1323 loc-2-3 loc-1-3)
    (connected c2333 loc-2-3 loc-3-3) (connected c2333 loc-3-3 loc-2-3)
    (connected c1314 loc-1-3 loc-1-4) (connected c1314 loc-1-4 loc-1-3)
    (connected c2314 loc-2-3 loc-1-4) (connected c2314 loc-1-4 loc-2-3)
    (connected c2324 loc-2-3 loc-2-4) (connected c2324 loc-2-4 loc-2-3)
    (connected c2334 loc-2-3 loc-3-4) (connected c2334 loc-3-4 loc-2-3)
    (connected c3334 loc-3-3 loc-3-4) (connected c3334 loc-3-4 loc-3-3)
    (connected c1424 loc-1-4 loc-2-4) (connected c1424 loc-2-4 loc-1-4)
    (connected c2434 loc-2-4 loc-3-4) (connected c2434 loc-3-4 loc-2-4)
    (connected c2425 loc-2-4 loc-2-5) (connected c2425 loc-2-5 loc-2-4)
    (connected c2535 loc-2-5 loc-3-5) (connected c2535 loc-3-5 loc-2-5)
    (connected c3545 loc-3-5 loc-4-5) (connected c3545 loc-4-5 loc-3-5)
    (connected c4544 loc-4-5 loc-4-4) (connected c4544 loc-4-4 loc-4-5)
    (connected c4443 loc-4-4 loc-4-3) (connected c4443 loc-4-3 loc-4-4)

    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-2-3)
    (key-at key3 loc-2-3)
    (key-at key4 loc-2-3)
    (key-at key5 loc-2-3)
    (key-at key6 loc-4-4)

    ; Locked corridors
    (locked c1223 red)
    (locked c2223 red)
    (locked c3223 red)
    (locked c1323 red)
    (locked c2333 red)
    (locked c2314 red)
    (locked c2324 red)
    (locked c2334 red)
    (locked c2425 purple)
    (locked c2535 green)
    (locked c3545 purple)
    (locked c4443 rainbow)
    (locked c4544 green)

    ; Unlocked corridors
    (unlocked c1222)
    (unlocked c2122)
    (unlocked c2232)
    (unlocked c1213)
    (unlocked c3233)
    (unlocked c1314)
    (unlocked c1424)
    (unlocked c2434)
    (unlocked c3233)

    ; Risky corridors
    (risky c1223)
    (risky c2223)
    (risky c3223)
    (risky c1323)
    (risky c2333)
    (risky c2314)
    (risky c2324)
    (risky c2334)

    ; Key colours
    (key-col key1 red)
    (key-col key2 green)
    (key-col key3 green)
    (key-col key4 purple)
    (key-col key5 purple)
    (key-col key6 rainbow)

    ; Key usage properties (one use, two use, etc)
    (not (unusable key1))
    (one-use key2)
    (one-use key3)
    (one-use key4)
    (one-use key5)
    (one-use key6)

    ; Room loc that can unlock a corridor
    (rm-cor loc-1-2  c1223)
    (rm-cor loc-2-2  c2223)

    (rm-cor loc-2-3  c1223) (rm-cor loc-2-3  c2223) (rm-cor loc-2-3  c3223)
    (rm-cor loc-2-3  c1323) (rm-cor loc-2-3  c2333) (rm-cor loc-2-3  c2314)
    (rm-cor loc-2-3  c2324) (rm-cor loc-2-3  c2334)

    (rm-cor loc-1-3  c1223)
    (rm-cor loc-1-4  c2314)
    (rm-cor loc-2-4  c2324)
    (rm-cor loc-3-4  c2334)
    (rm-cor loc-3-3  c2333)
    (rm-cor loc-3-2  c2334)
    (rm-cor loc-2-4  c2425)
    (rm-cor loc-2-5  c2425)
    (rm-cor loc-3-5  c3545)
    (rm-cor loc-2-5  c2535)
    (rm-cor loc-3-5  c2535)
    (rm-cor loc-4-5  c4544)
    (rm-cor loc-4-5  c3545)
    (rm-cor loc-4-4  c4544)
    (rm-cor loc-4-4  c4443)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (at loc-4-3)      
    )
  )

)
