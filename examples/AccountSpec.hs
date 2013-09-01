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
	Given "a first account with ${balance1} bitcoins" $ \balance1 ->
		let account1 = Account balance1

	Given "a second account with ${balance2} bitcoins" $ \balance2 ->
		let account2 = Account balance2

	When "${amount} bitcoins are transferred from the first to the second account" $ \amount ->
		(account1, account2) = transfer account1 account2 amount

	Then "the first account has ${balance1'} bitcoins" $ \balance1' ->
		(balance account1) `mustBe` balance1'

	And "the second account has ${balance2'} bitcoins" $ \balance2' ->
		(balance account1) `mustBe` balance2'

	Examples $
    | balance1 | balance2 | amount | balance1' | balance2' |
    |  5.0     |  3.0     |  4.0   |  1.0      |  7.0      |
    |  1.0     |  7.0     |  2.0   | -1.0      |  9.0      |
    |  4.0     | -5.0     |  3.0   |  1.0      | -2.0      |
