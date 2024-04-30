------------------------------- MODULE TransactionCommit ------------------------------
CONSTANTS RM
VARIABLES rmState

TypeOK == rmState \in [RM -> {"working", "prepared", "committed", "aborted"}]

INIT == rmState = [r \in RM |-> "working"]