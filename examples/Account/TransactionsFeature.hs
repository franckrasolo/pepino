module TransactionsFeature (feature) where

import Pepino

-- | PEP-1000: Amounts can either be paid into or withdrawn from an account.
feature :: Feature
feature = Feature "Account Transactions" initialBalances [ payAmount, withdrawAmount ]

{-|
  In these examples, we sometimes initialise customer accounts with a negative
  balance in order to illustrate transactions for overdrawn account.

  In a future example, we will introduce the concept of an overdraft facility
  that account transactions will be subjected to.
-}
initialBalances :: Background
initialBalances = Background "Initialise customer accounts" $
	Given "${accounts} with the following initial balances in bitcoins" $
		|   5.0   |
		|   1.0   |
		|  -4.0   |

{-|
  PEP-1234: Pay an amount into accounts with a positive balance.
  PEP-2345: Pay an amount into accounts with a negative balance.

  Payments can be made from a current account either online or over the counter.
-}
payAmount :: Scenario
payAmount = Scenario "Paying An Amount Into An Account" $ do
	When "each account is credited with ${4} bitcoins" $ \amount ->
		let accounts' = map (pay amount) accounts

	Then "the accounts now have the following balance in bitcoins" $
		|   9.0   |
		|   5.0   |
		|   0.0   |

{-|
  PEP-3456: Withdraw an amount into accounts with a positive balance.
  PEP-4567: Withdraw an amount into accounts with a negative balance.

  Withdrawals can only be made from a current account at an ATM.
-}
withdrawAmount :: Scenario
withdrawAmount = Scenario "Withdrawing An Amount From An Account " $ do
	When "${4} bitcoins are withdrawn from each account" $ \amount ->
		let accounts' = map (withdraw amount) accounts

	Then "the accounts now have the following balance in bitcoins" $
		|   1.0   |
		|  -3.0   |
		|  -8.0   |
