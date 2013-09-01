module AccountSpec where

import Pepino

main = pepino [ transferAmount, transferAmountWithExamples ]

transferAmount :: Scenario
transferAmount = describe "Transferring Amount From One Account To Another" $ do
	Given "a first account with a balance of five bitcoins" $
		let account1 = Account 5.0

	Given "a second account with a balance of three bitcoins" $
		let account2 = Account 3.0

	When "four bitcoins are transferred from the first to the second account" $
		(account1, account2) = transfer account1 account2 4.0

	Then "one bitcoin remains in the first account" $
		(balance account1) `mustBe` 1.0

	And "the second account has a balance of seven bitcoins" $
		(balance account1) `mustBe` 7.0

transferAmountWithExamples :: Scenario
transferAmountWithExamples = describe "Transferring Amount From One Account To Another" $ do
	Given "a first account with a balance of (\d+) bitcoins" $ \balance' ->
		let account1 = Account balance

	Given "a second account with a balance of (\d+) bitcoins" $ \balance' ->
		let account2 = Account balance

	When "(\d+) bitcoins are transferred from the first to the second account" $ \amount ->
		(account1, account2) = transfer account1 account2 amount

	Then "the first account has a balance of (\d+) bitcoins" $ \balance'' ->
		(balance account1) `mustBe` balance''

	And "the second account has a balance of (\d+) bitcoins" $ \balance'' ->
		(balance account1) `mustBe` balance''

	Examples $
    | Payer | Payee | Amount | Payer | Payee |
    |  5.0  |  3.0  |  4.0   |  1.0  |  7.0  |
    |  1.0  |  7.0  |  2.0   | -1.0  |  9.0  |
    |  4.0  | -2.0  |  3.0   |  1.0  |  1.0  |
