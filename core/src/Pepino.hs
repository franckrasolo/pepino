module Pepino (Feature (..), Background (..), Scenario (..), Examples (..), Step (..), Title, Description, Sentence) where

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
    show (Feature title description background scenarios) = "Feature: " ++ title ++ format description ++ show background ++ list scenarios

instance Show Background where
    show (Background "" "") = ""
    show (Background title description) = "Background: " ++ title ++ format description

instance Show Scenario where
    show (Scenario title description steps) = "Scenario: " ++ title ++ format description ++ list steps
    show (Outline  title description steps examples) = "Scenario Outline: " ++ title ++ format description ++ list steps ++ list examples

instance Show Examples where
    show (Examples title description) = "Examples: " ++ title ++ format description

instance Show Step where
    show (Given sentence) = "    Given " ++ sentence
    show (When  sentence) = "     When " ++ sentence
    show (Then  sentence) = "     Then " ++ sentence
    show (And   sentence) = "      And " ++ sentence
    show (But   sentence) = "      But " ++ sentence

format :: Description -> String
format description = "\n" ++ description ++ "\n"

list :: (Show a) => [a] -> String
list xs = unlines (map show xs)
