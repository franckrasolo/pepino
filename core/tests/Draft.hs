{-# LANGUAGE QuasiQuotes #-}
module Draft where

import Pepino
import Pepino.Renderers.Ansi()
import Text.PrettyPrint.ANSI.Leijen

main :: IO ()
main = do
    let doc = pretty feature
    --putDoc $ plain doc
    putDoc doc

feature :: Feature
feature = Feature "<feature title>" [notes|
    A feature
    can be described
    over multiple lines.
|] (Background "" "") [ scenario1, scenario2, scenario3 ]

scenario1 :: Scenario
scenario1 = Scenario "" "" $ [
    Given "a step",
    When  "an action is performed",
    Then  "a condition holds true"
    ]

scenario2 :: Scenario
scenario2 = Scenario "<scenario title>" "" $ [
    Given "a step",
    But   "under different conditions",
    When  "an action is performed",
    Then  "the same condition no longer holds true"
    ]

scenario3 :: Scenario
scenario3 = Scenario "<scenario title>" [notes|
    A scenario
    can be described
    over multiple lines.
|] $ [
    Given "a first step",
    And   "a second step",
    But   "under different conditions",
    When  "an action is performed",
    Then  "a first condition holds true",
    But   "the second one doesn't",
    And   "all is good"
    ]
