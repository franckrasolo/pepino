{-# LANGUAGE QuasiQuotes #-}
module TransfersFeature (feature) where

import Data.String.Here
import Pepino

feature :: Feature
feature = Feature "Account Transfers" [notes|
    PEP-3000: Amounts can be transferred from one account to another.
|] [ transferAmount, transferAmountWithExamples ]

transferAmount :: Scenario
transferAmount = Scenario "Transferring Amount From One Account To Another" "" $ do
    Given "a first account with a balance of ${5} bitcoins" $ \balance1 ->
        let account1 = Account balance1

    And "a second account with a balance of ${3} bitcoins" $ \balance2 ->
        let account2 = Account balance2

    When "${4} bitcoins are transferred from the first to the second account" $ \amount ->
        let (account1', account2') = transfer amount account1 account2

    Then "${1} bitcoin remains in the first account" $ \balance1' ->
        (balance account1') `mustBe` balance1'

    And "the second account has a balance of ${7} bitcoins" $ \balance2' ->
        (balance account2') `mustBe` balance2'

transferAmountWithExamples :: ScenarioOutline
transferAmountWithExamples = ScenarioOutline "Transferring Amount From One Account To Another" "" $ do
    Given "a first account with <balance1> bitcoins" $ \balance1 ->
        let account1 = Account balance1

    And "a second account with <balance2> bitcoins" $ \balance2 ->
        let account2 = Account balance2

    When "<amount> bitcoins are transferred from the first to the second account" $ \amount ->
        let (account1', account2') = transfer amount account1 account2

    Then "the first account has <balance1'> bitcoins" $ \balance1' ->
        (balance account1') `mustBe` balance1'

    And "the second account has <balance2'> bitcoins" $ \balance2' ->
        (balance account2') `mustBe` balance2'

    Examples "Successful Transfers" [notes|
        A transfer is successful when the paying account preserves a positive balance.

        In a future example, we will introduce the concept of an overdraft limit
        that account transactions will be subjected to.
    |] $
        | balance1 | balance2 | amount | balance1' | balance2' |
        |  5.0     |  3.0     |  4.0   |  1.0      |  7.0      |
        |  4.0     | -5.0     |  3.0   |  1.0      | -2.0      |

    Examples "Unsuccessful Transfers" [notes|
        A transfer is unsuccessful if the paying account would end up with
        a negative balance as a result of the withdrawal.
    |] $
        | balance1 | balance2 | amount | balance1' | balance2' |
        |  5.0     |  3.0     |  7.0   |  5.0      |  3.0      |
        |  1.0     |  7.0     |  2.0   |  1.0      |  7.0      |
