{-# LANGUAGE QuasiQuotes #-}
module Draft where

import Data.String.Here
import Pepino

main :: IO ()
main = print feature

feature :: Feature
feature = Feature "<feature title>" [hereLit|
    <feature description>
|] (Background "" "") [ scenario ]

scenario :: Scenario
scenario = Scenario "<scenario title>" [hereLit|
    A scenario
    can be described
    over multiple lines.
|] $
    Given "a first step" :
    And   "a second step" :
    But   "under different conditions" :
    When  "an action is performed" :
    Then  "a first condition holds true" :
    But   "the second one doesn't" :
    And   "all is good" :
    []
