{-# LANGUAGE TemplateHaskell #-}
module Account where

import Control.Lens

type Amount = Double
data Account = Account { _balance :: Amount } deriving (Eq, Show)
makeLenses ''Account

pay :: Amount -> Account -> Account
pay amount account = (balance +~ amount) account

withdraw :: Amount -> Account -> Account
withdraw amount account = (balance -~ amount) account

transfer :: Amount -> Account -> Account -> (Account, Account)
transfer amount account1 account2 = (withdraw amount account1, pay amount account2)
