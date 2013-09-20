module Pepino where

newtype Title = String
newtype Description = String
newtype Sentence = String

data Feature = Feature Title Description Background [Scenario] deriving Show
data Background = Background Title Description deriving Show

data Scenario = Scenario Title Description
              | ScenarioOutline Title Description [Examples]
            deriving Show

data Step = Given Sentence | When Sentence | Then Sentence | And Sentence | But Sentence deriving Show
data Examples = Examples Title Description deriving Show
