{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Api.Stats where

import  Control.Monad.Except    (MonadIO)    
import  Control.Monad.Logger    (logDebugNS)    
import  Servant

import  Database.Persist.Postgresql  (Entity (..), selectList)

import  Config  (AppT (..))
import  Models (Stats (Stats), runDb, statsTitle)
import qualified Models as M


type StatsAPI =
    "stats" :> Get '[JSON] [Entity Stats]    


statsApi :: Proxy StatsAPI
statsApi = Proxy

statsServer :: MonadIO m => ServerT StatsAPI (AppT m)
statsServer = allStats

allStats :: MonadIO m => AppT m [Entity Stats]
allStats = do
    logDebugNS "api" "allStats"
    runDb (selectList [] [])