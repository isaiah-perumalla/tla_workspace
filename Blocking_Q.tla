----------------------------- MODULE Blocking_Q -----------------------------
EXTENDS Sequences, Naturals, FiniteSets
CONSTANTS Producers, Consumers, BufferCap

ASSUME PreConditions == 
                    /\ Producers # {}
                    /\ Consumers # {}
                    /\ Producers \intersect Consumers = {}

VARIABLES counter, waitset
vars == <<counter, waitset>>


Init == 
    /\ counter = 0
    /\ waitset = {} 

    
Wait(t) == 
    /\ waitset' = waitset \cup {t}
    /\ UNCHANGED counter

WakeOne ==
    IF waitset = {} THEN UNCHANGED waitset
    ELSE \E t \in waitset: waitset' = waitset \ {t} 


Put(t) == 
    /\ t \notin waitset
    /\  \/ /\ counter = BufferCap
            /\ Wait(t)
        \/  /\ counter < BufferCap
            /\ counter' = counter + 1
            /\ WakeOne    
            

Get(t) ==
    /\ t \notin waitset
    /\  \/   /\ counter = 0
             /\ Wait(t)
        
        \/   /\ counter > 0
             /\ counter' = counter - 1
             /\ WakeOne 

Next == \/ \E t \in Producers : Put(t)
        \/ \E t \in Consumers : Get(t)

NoDeadLock == Producers \cup Consumers # waitset
================================================