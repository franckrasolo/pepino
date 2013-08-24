module ArithmeticSpec (spec) where

import Arithmetic
import Control.Rematch
import Test.Hspec
import Test.Hspec.HUnit()
import Test.Rematch.HUnit

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "An arithmetic expression defined as a GADT" $ do
	it "can represent an integer" $
		expect (eval (I 5)) (is 5)

	it "can represent the addition of two integers" $
		expect (eval (I 5 `Add` I 1)) (is 6)

	it "can represent the multiplication of two integers" $
		expect (eval (I 5 `Mul` I 3)) (is 15)

	it "can represent the composition of a multiplication over an addition" $
		expect (eval ((I 5 `Add` I 1) `Mul` (I 2))) (is 12)

	it "can be compared for equality" $
		expect ((I 5 `Add` I 1) `Mul` (I 2)) (isNot (equalTo ((I 5 `Add` I 1) `Mul` (I 3))))
