{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module Api (app) where

import  Control.Monad.Reader    (runReaderT)    
import  Servant                 (Proxy (Proxy), Server, serve)
import  Servant.Server


import  Api.Stats            (StatsAPI, statsServer, statsApi)
import  Config                  (AppT (..), Config (..))


appToServer :: Config -> Server StatsAPI
appToServer conf = hoistServer statsApi (convertApp conf) statsServer


convertApp :: Config -> AppT IO a -> Handler a
convertApp conf appT = Handler $ runReaderT (runApp appT) conf


type AppAPI = StatsAPI


appApi :: Proxy AppAPI
appApi = Proxy


app :: Config -> Application
app conf =
    serve appApi (appToServer conf)