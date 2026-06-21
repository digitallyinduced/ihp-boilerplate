module WorkerMain () where

import IHP.Prelude
import IHP.FrameworkConfig (RootApplication (..))
import IHP.Job.Types (Worker (..))

instance Worker RootApplication where
    workers _ =
        []
        -- Generator Marker
