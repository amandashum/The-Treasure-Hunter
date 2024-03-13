(define (domain Dungeon)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )

    ; Do not modify the types
    (:types
        location colour key corridor
    )

    ; Do not modify the constants
    (:constants
        red yellow green purple rainbow - colour
    )

    ; You may introduce whatever predicates you would like to use
    (:predicates

        ; One predicate given for free!
        ; hero's current location
        (at ?loc - location)
        
        ; corridor is locked
        (locked ?cor - corridor ?col - colour)
        
        ; unlocked corridor
        (unlocked ?cor - corridor)
        
        ; corridor will collapse
        (collapse ?cor - corridor)
        
        ; corridor is risky
        (risky ?cor - corridor)
        
        ; amanda
        (messy ?loc - location)
        
        ; corridor is connected ?from
        (connected ?cor - corridor ?from ?to - location)
        
        ; key at the current ?location
        (key-at ?k - key ?loc - location)
        
        
        ; hero's hand is free
        (hand-free)
        
        ; holding a key
        (holding ?k - key)
        
        ; room loc that can unlock a corridor
        (rm-cor ?loc - location ?cor - corridor)
        
        ; key colour
        (key-col ?k - key ?col - colour)
        
        ; key usage
        (one-use ?k - key)
        (two-use ?k - key)
        (multi-use ?k - key)
        (unusable ?k - key)

    )

    ; IMPORTANT: You should not change/add/remove the action names or parameters

    ;Hero can move if the
    ;    - hero is at current location ?from,
    ;    - wants to move to location ?to,
    ;    - corridor ?cor exists between the ?from and ?to locations
    ;    - there isn't a locked door in corridor ?cor
    ;Effects move the hero, and collapse the corridor if it's "risky"
    (:action move

        :parameters (?from ?to - location ?cor - corridor)

        :precondition (and
        ; hero is at ?from
        (at ?from)
        ; hero is not at ?to
        (not (at ?to))
        ; corridor is exists
        (connected ?cor ?from ?to)
        ; corridor is not locked
        (unlocked ?cor)
        
        (not (collapse ?cor))


        )

        :effect (and
        ; hero is at ?to
        (at ?to)
        ; hero is at ?from
        (not (at ?from))
        ; collapse if it is risky
        (when
            ; antecedent
            (and (risky ?cor))
            ; consequence
            (and (collapse ?cor)
                 (messy ?to ))
            )
        
        )
    )

    ;Clean if the
    ;    - hero is at current location ?loc,
    ;    - location is not messy 
    ;Effects not messy location
    (:action clean 
        :parameters(?loc - location)
        :precondition (and 
            (messy ?loc )
            (at ?loc)
        )
        :effect (and
            (not(messy ?loc ))
         )     
    )
    
    ;Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;Effect will have the hero holding the key and their arm no longer being free
    (:action pick-up

        :parameters (?loc - location ?k - key)

        :precondition (and
        ; hero is at ?loc
        (at ?loc)
        ; key is at the location
        (key-at ?k ?loc)
        ; hero's hand is free
        (hand-free)
        ; hero is not holding a key
        (not (holding ?k))
        
        ;amanda
        (not (messy ?loc))


        )

        :effect (and
        ; no longer hand-free
        (not (hand-free))
        ; hero is holding the key
        (holding ?k)

        )
    )

    ;Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ;Effect will be that the hero is no longer holding the key
    (:action drop

        :parameters (?loc - location ?k - key)

        :precondition (and
        ; hero is holing a key
        (holding ?k)
        ; hero is not hand-free
        (not (hand-free))
        ; hero's location
        (at ?loc)
            

        )

        :effect (and
        ; hero is no longer holding a key
        (hand-free)
        (not (holding ?k))

        )
    )


    ;Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is if the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ;Effect will be that the corridor is unlocked and the key usage will be updated if necessary
    (:action unlock

        :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)

        :precondition (and
        ; the hero is holding a key
        (not (hand-free))
        (holding ?k)
        ; key can be used
        (not (unusable ?k))
        ; the corridor ?cor is locked with colour ?col
        (locked ?cor ?col)
        ; the key ?k is if the right colour ?col
        (key-col ?k ?col)
 
        ; the hero is at the location ?loc
        (at ?loc)
        ; the corridor is connected to the location ?loc
        (rm-cor ?loc ?cor)
        

        )

        :effect (and
        ; unlocked
        (unlocked ?cor)
        ; update key usage
        (when
            ; antecedent
            (two-use ?k)
            ; consequence
            (one-use ?k)
        )
            
        (when
            ; antecedent
            (one-use ?k)
            ; consequence
            (unusable ?k)
        
        )
        )
    )

)