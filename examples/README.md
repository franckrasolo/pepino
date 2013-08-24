Building
--------

To build and test, execute the normal cabal steps:

    cabal configure --enable-tests
    cabal build
    cabal test

Example
-------

The following snippet tests that the representation of the arithmetic expression `(5 + 1) * 3` evaluates correctly:

~~~ {.haskell .literate}
import Arithmetic
import Test.Hspec

main :: IO ()
main = hspec $ do
  it "(5 + 1) * 3 == 18" $ do
    eval ((I 5 `Add` I 1) `Mul` (I 3)) `shouldBe` 18
~~~
