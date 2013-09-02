module Account where

type Amount = Double
data Account = Account { balance :: Amount } deriving (Eq, Show)

pay :: Account -> Amount -> Account
pay account amount = Account ((balance account) + amount)

withdraw :: Account -> Amount -> Account
withdraw account amount = Account ((balance account) - amount)

transfer :: Account -> Account -> Amount -> (Account, Account)
transfer account1 account2 amount = (withdraw account1 amount, pay account2 amount)
