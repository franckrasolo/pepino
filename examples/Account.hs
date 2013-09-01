module Account where

type Amount = Double
data Account = Account { balance :: Amount } deriving (Eq, Show)

transfer :: Account -> Account -> Amount -> (Account, Account)
transfer account1 account2 amount = (Account ((balance account1) - amount), Account ((balance account2) + amount))

(account1, account2) = transfer (Account 5.0) (Account 3.0) 6.0
