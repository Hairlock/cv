{-# LANGUAGE OverloadedStrings #-}

module Init where
   
import  Network.Wai                 (Application)
import  Network.Wai.Handler.Warp    (run)
import  Database.Persist.Postgresql (runSqlPool)

import  System.Environment          (lookupEnv)
import  Control.Exception           (bracket)
import  Safe                        (readMay)
import qualified Katip
import qualified Data.Pool          as Pool

import  Api                         (app)
import  Models                      (doMigrations)
import  Logger                      (defaultLogEnv)
import  Config                      (Config (..), Environment (..),
                                    makePool, setLogger)


runApp :: IO ()
runApp = bracket acquireConfig shutdownApp runApp
    where
        runApp config = run (configPort config) =<< initialize config


initialize :: Config -> IO Application
initialize conf = do
    let logger = setLogger (configEnv conf)
    runSqlPool doMigrations (configPool conf)
    pure . logger . app $ conf


acquireConfig :: IO Config
acquireConfig = do
    port <- lookupSetting "PORT" 8082
    env <- lookupSetting "ENV" Development
    logEnv <- defaultLogEnv
    pool <- makePool env logEnv
    pure Config
        { configPool = pool
        , configEnv = env
        , configLogEnv = logEnv
        , configPort = port
        }


shutdownApp :: Config -> IO ()
shutdownApp conf = do
    Katip.closeScribes (configLogEnv conf)
    Pool.destroyAllResources (configPool conf)
    pure ()     


lookupSetting :: Read a => String -> a -> IO a
lookupSetting env def = do
    maybeValue <- lookupEnv env
    case maybeValue of
        Nothing ->
            return def
        Just str ->
            maybe (handleFailedRead str) return (readMay str)
    where
    handleFailedRead str =
        error $ mconcat
            [ "Failed to read [["
            , str
            , "]] for environment variable "
            , env
            ]    