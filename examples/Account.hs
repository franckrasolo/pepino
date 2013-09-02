module Account where

type Amount = Double
data Account = Account { balance :: Amount } deriving (Eq, Show)

pay :: Amount -> Account -> Account
pay amount account = Account ((balance account) + amount)

withdraw :: Amount -> Account -> Account
withdraw amount account = Account ((balance account) - amount)

transfer :: Amount -> Account -> Account -> (Account, Account)
transfer amount account1 account2 = (withdraw amount account1, pay amount account2)
