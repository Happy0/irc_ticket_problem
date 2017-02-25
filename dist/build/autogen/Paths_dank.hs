{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_dank (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/happy0/.cabal/bin"
libdir     = "/home/happy0/.cabal/lib/x86_64-linux-ghc-8.0.1/dank-0.1.0.0"
datadir    = "/home/happy0/.cabal/share/x86_64-linux-ghc-8.0.1/dank-0.1.0.0"
libexecdir = "/home/happy0/.cabal/libexec"
sysconfdir = "/home/happy0/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "dank_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "dank_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "dank_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "dank_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "dank_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
