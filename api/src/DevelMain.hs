{-# LANGUAGE OverloadedStrings #-}

-- | Running your app inside GHCi.
--
-- > stack ghci
--
-- To start your app, run:
--
-- > :l DevelMain
-- > DevelMain.update

module DevelMain where

import  Prelude

import  Control.Concurrent       (MVar, ThreadId, forkIO, killThread,
                                           newEmptyMVar, putMVar, takeMVar)
import  Control.Exception        (finally)
import  Control.Monad            ((>=>))
import  Data.IORef               (IORef, newIORef, readIORef,
        writeIORef)
import  Foreign.Store            (Store (..), lookupStore, readStore,
                                 storeAction, withStore)
import  GHC.Word                 (Word32)
import  Init                     (runApp)

-- | Start or restart the server.
update :: IO ()
update = do
    mtidStore <- lookupStore tidStoreNum
    case mtidStore of
      -- no server running
      Nothing -> do
          done <- storeAction doneStore newEmptyMVar
          tid <- start done
          _ <- storeAction (Store tidStoreNum) (newIORef tid)
          return ()
      -- server is already running
      Just tidStore -> restartAppInNewThread tidStore
  where
    doneStore :: Store (MVar ())
    doneStore = Store 0

    restartAppInNewThread :: Store (IORef ThreadId) -> IO ()
    restartAppInNewThread tidStore = modifyStoredIORef tidStore $ \tid -> do
        killThread tid
        withStore doneStore takeMVar
        readStore doneStore >>= start


    -- | Start the server in a separate thread.
    start :: MVar () -- ^ Written to when the thread is killed.
          -> IO ThreadId
    start done =
        forkIO (finally runApp
                        (putMVar done ()))

shutdown :: IO ()
shutdown = do
    mtidStore <- lookupStore tidStoreNum
    case mtidStore of
      Nothing -> putStrLn "no app running"
      Just tidStore -> do
          withStore tidStore $ readIORef >=> killThread
          putStrLn "App is shutdown"

tidStoreNum :: Word32
tidStoreNum = 1

modifyStoredIORef :: Store (IORef a) -> (a -> IO a) -> IO ()
modifyStoredIORef store f = withStore store $ \ref -> do
    v <- readIORef ref
    f v >>= writeIORef ref
