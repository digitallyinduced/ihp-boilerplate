{-# LANGUAGE CPP #-}

#ifdef wasi_HOST_OS

module MyMain (main) where

import App (start)
import Language.Javascript.JSaddle.Wasm qualified as JSaddle.Wasm

foreign export javascript "hs_start" main :: IO ()

main :: IO ()
main = JSaddle.Wasm.run start

#else

module Main (main) where

-- HLS doesn't support cross compilers:
-- https://github.com/haskell/haskell-language-server/discussions/4187
main :: IO ()
main = error "Frontend needs a Wasm compiler (native support is just for HLS)!"

#endif
