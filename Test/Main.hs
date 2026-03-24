module Main where

import Test.Hspec
import IHP.Prelude

-- Import your test specs here:
-- import Test.MySpec

main :: IO ()
main = hspec do
    describe "Example" do
        it "should pass" do
            1 + 1 `shouldBe` (2 :: Int)
