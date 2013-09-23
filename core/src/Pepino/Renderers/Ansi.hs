{-# OPTIONS_GHC -fno-warn-orphans #-}
module Pepino.Renderers.Ansi where

import Pepino
import Text.PrettyPrint.ANSI.Leijen

instance Pretty Feature where
    pretty (Feature title description background scenarios) = section "Feature:" title description
        <> pretty background
        <$> asDocs scenarios

instance Pretty Background where
    pretty (Background "" "") = empty
    pretty (Background title description) = section "Background:" title description

instance Pretty Scenario where
    pretty (Scenario title description steps) = section "Scenario:" title description
        <$> asDocs steps
    pretty (Outline  title description steps examples) = section "Scenario Outline:" title description
        <$> asDocs steps
        <$> asDocs examples

instance Pretty Examples where
    pretty (Examples title description) = section "Examples:" title description

instance Pretty Step where
    pretty (Given sentence) = step "Given" sentence
    pretty (When  sentence) = step " When" sentence
    pretty (Then  sentence) = step " Then" sentence
    pretty (And   sentence) = step "  And" sentence
    pretty (But   sentence) = step "  But" sentence

section :: String -> Title -> Description -> Doc
section name title description = (bold . underline . yellow . text) name <> render title description
    where
        render :: Title -> Description -> Doc
        render ""    "" = linebreak
        render title "" = space <> white (text title) <> linebreak
        render title description = space <> white (text title <$> text description)

asDocs :: (Pretty a) => [a] -> Doc
asDocs xs = vsep (map pretty xs) <> linebreak

step :: String -> Sentence -> Doc
step keyword sentence = indent 4 $ (bold . yellow . text) keyword <+> (green . text) sentence
