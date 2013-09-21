module Pepino where

import Data.List (intercalate)

type Title = String
type Description = String
type Sentence = String

data Feature = Feature Title Description Background [Scenario]
data Background = Background Title Description

data Scenario = Scenario Title Description [Step]
              | Outline  Title Description [Step] [Examples]

data Step = Given Sentence | When Sentence | Then Sentence | And Sentence | But Sentence
data Examples = Examples Title Description

instance Show Feature where
    show (Feature title description _ scenarios) = "Feature: " ++ title ++ format description ++ intercalate "\n" (map show scenarios)

instance Show Background where
    show (Background title description) = "Background: " ++ title ++ format description

instance Show Scenario where
    show (Scenario title description steps) = "Scenario: " ++ title ++ format description ++ intercalate "\n    " ("    " : (map show steps))
    show (Outline  title description steps examples) = "Scenario Outline: " ++ title ++ format description ++ show steps ++ "\n" ++ show examples

instance Show Examples where
    show (Examples title description) = "Examples: " ++ title ++ format description

instance Show Step where
    show (Given sentence) = "Given " ++ sentence
    show (When  sentence) = "When  " ++ sentence
    show (Then  sentence) = "Then  " ++ sentence
    show (And   sentence) = "And   " ++ sentence
    show (But   sentence) = "But   " ++ sentence

format :: Description -> String
format description = "\n" ++ description ++ "\n"
