module AccountSpec where

type Amount = Double
data Account = Account { balance :: Amount } deriving (Eq, Show)

transfer :: Account -> Account -> Amount -> (Account, Account)
transfer account1 account2 amount = (Account ((balance account1) - amount), Account ((balance account2) + amount))

main :: IO ()
main = pepino transferSpec

transferSpec :: PepinoSpec
transferSpec = describe "Transferring Money From One Account To Another" $ do
	Given "a first account with a balance of five euros" $
		let account1 = Account 5.0
	Given "a second account with a balance of three euros" $
		let account2 = Account 3.0
	When "four euros are transferred from the first to the second account" $
		(account1, account2) = transfer account1 account2 4.0
	Then "one euro remains in the first account" $
		(balance account1) `mustBe` 1.0
	And "the second account has a balance of seven euros" $
		(balance account1) `mustBe` 7.0
