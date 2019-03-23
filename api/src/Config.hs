{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Config where

import  Control.Concurrent                      (ThreadId)    
import  Control.Monad.Except                    (ExceptT, MonadError)
import  Control.Monad.Trans.Class
import  Control.Monad.Reader                    (MonadIO, MonadReader, ReaderT, asks)    
import  Control.Monad.IO.Class          
import  Control.Monad.Logger                    (MonadLogger (..))
import  Network.Wai                             (Middleware)
import  Network.Wai.Handler.Warp                (Port)
import  Network.Wai.Middleware.RequestLogger    (logStdout, logStdoutDev)

import  Database.Persist.Postgresql             (ConnectionPool, ConnectionString, createPostgresqlPool)
import  Data.Monoid                             ((<>))
import  Servant                                 (ServantErr)
import  Logger

import qualified Data.ByteString.Char8          as BS


newtype AppT m a
    = AppT
    { runApp :: ReaderT Config (ExceptT ServantErr m) a
    } deriving
    ( Functor, Applicative, Monad, MonadReader Config, MonadError ServantErr
    , MonadIO
    )

type App = AppT IO    

data Config
    = Config
    { configPool        :: ConnectionPool
    , configEnv         :: Environment
    , configLogEnv      :: LogEnv
    , configPort        :: Port
    }

-- | Katip instance for @AppT m@
instance MonadIO m => Katip (AppT m) where
    getLogEnv = asks configLogEnv
    localLogEnv = error "not implemented"

-- | MonadLogger instance to use within @AppT m@
instance MonadIO m => MonadLogger (AppT m) where
    monadLoggerLog = adapt logMsg

-- | MonadLogger instance to use in @makePool@
instance MonadIO m => MonadLogger (KatipT m) where
    monadLoggerLog = adapt logMsg    

data Environment
    = Development
    | Test
    | Production
    deriving (Eq, Show, Read)  
    
setLogger :: Environment -> Middleware
setLogger Test        = id
setLogger Development = logStdoutDev
setLogger Production  = logStdout    

makePool :: Environment -> LogEnv -> IO ConnectionPool
makePool env logEnv =
    runKatipT logEnv (createPostgresqlPool (connStr "") 1 )
        
connStr :: BS.ByteString -> ConnectionString
connStr db = 
    "host=localhost dbname=shorelands" <> db <> " user=test password=test port=5432"
    
