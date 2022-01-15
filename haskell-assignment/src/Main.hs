module Main where

import Args
  ( AddOptions (..),
    Args (..),
    GetOptions (..),
    SearchOptions (..),
    parseArgs,
  )
import qualified Data.List as L
import Data.Maybe
import qualified Entry.DB as DB
import Entry.Entry
  ( Entry (..),
    FmtEntry (FmtEntry),
    matchedByAllQueries,
    matchedByQuery,
  )
import Result
import System.Environment (getArgs)
import Test.SimpleTest.Mock
import Prelude hiding (print, putStrLn, readFile)
import qualified Prelude

usageMsg :: String
usageMsg =
  L.intercalate
    "\n"
    [ "snip - code snippet manager",
      "Usage: ",
      "snip add <filename> lang [description] [..tags]",
      "snip search [code:term] [desc:term] [tag:term] [lang:term]",
      "snip get <id>",
      "snip init"
    ]

-- | Handle the init command
handleInit :: TestableMonadIO m => m ()
handleInit =
  do
    let empty_database = DB.empty
    DB.save empty_database
    return ()

-- | Handle the get command
handleGet :: TestableMonadIO m => GetOptions -> m ()
handleGet getOpts =
  do
    database_load <- DB.load
    case database_load of
      Success snippet_list -> putStrLn $ entrySnippet (fromJust (DB.findFirst (\x -> entryId x == getOptId getOpts) snippet_list))
      Error err -> putStrLn "Failed to load DB"

-- | Handle the search command
handleSearch :: TestableMonadIO m => SearchOptions -> m ()
handleSearch (SearchOptions query_list) =
  do
    database_load <- DB.load
    case database_load of
      Success snippets ->
        do
          let entries = DB.findAll (matchedByAllQueries query_list) snippets
          if length entries == 0
            then putStrLn "No entries found"
            else putStrLn (head (map (\x -> (head . lines) (show (FmtEntry x))) entries))
      Error err -> putStrLn "Failed to load DB"
    return ()

-- | Handle the add command
handleAdd :: TestableMonadIO m => AddOptions -> m ()
handleAdd addOpts = do
  snip <- readFile (addOptFilename addOpts)
  db <- DB.load

  case db of
    Error _ -> putStrLn "Failed to load DB"
    _ -> putStrLn ""
  let db' = getSuccess db DB.empty
      db'' = DB.insertWith (\id -> makeEntry id snip addOpts) db'

  DB.save db''
  return ()
  where
    makeEntry :: Int -> String -> AddOptions -> Entry
    makeEntry id snippet addOpts =
      Entry
        { entryId = id,
          entrySnippet = snippet,
          entryFilename = addOptFilename addOpts,
          entryLanguage = addOptLanguage addOpts,
          entryDescription = addOptDescription addOpts,
          entryTags = addOptTags addOpts
        }

-- | Dispatch the handler for each command
run :: TestableMonadIO m => Args -> m ()
run (Add addOpts) = handleAdd addOpts
run (Search searchOpts) = handleSearch searchOpts
run (Get getOpts) = handleGet getOpts
run Init = handleInit
run Help = putStrLn usageMsg

main :: IO ()
main = do
  args <- getArgs
  let parsed = parseArgs args
  case parsed of
    (Error err) -> Prelude.putStrLn usageMsg
    (Success args) -> run args
