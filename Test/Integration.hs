module Main where

import Test.Hspec
import IHP.Prelude

-- Import your integration test specs here:
-- import Test.Controller.MyControllerSpec

-- Integration tests run with a temporary PostgreSQL database.
-- See: https://ihp.digitallyinduced.com/Guide/testing.html
main :: IO ()
main = hspec do
    describe "Integration" do
        it "should pass" do
            1 + 1 `shouldBe` (2 :: Int)
