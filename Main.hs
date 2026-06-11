module Main
  ( Level,
  )
where

data Level
  = -- | A fatal diagnostic that should reject the current operation.
    Error
  | -- | A non-fatal diagnostic worth surfacing to users.
    Warn
  | Info
