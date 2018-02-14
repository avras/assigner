module Main where

import System.Environment (getArgs)
import System.Random
import System.Random.Shuffle
import Data.Text (Text, breakOn, breakOnEnd, unpack, pack, splitOn, stripStart, empty, append, concat)
import qualified Data.Text.IO as DTI
import qualified Data.ByteString as B
import qualified Crypto.Hash.SHA256 as SHA256
import qualified Data.ByteString.Char8 as C

type Seed = String

beginQuestions :: Text
beginQuestions = pack "\\begin{questions}"

endQuestions :: Text
endQuestions = pack "\\end{questions}"

questionCommand :: Text
questionCommand = pack "\\question[5]"

firstByteofSeedHash :: Seed -> Int
firstByteofSeedHash s = i where
  h = SHA256.hash $ C.pack s      -- Calculate hash of seed
  i = fromIntegral $ B.index h 0  -- Convert first byte of hash into an integer

main :: IO ()
main = do
  args <- getArgs
  case (length args < 2) of
    True -> putStrLn "Usage: stack exec assigner <AssignmentTexFile> <NumQuestionsPerStudent> <SeedLikeStudentRollNo>"
    False -> do
      let fname = args !! 0
      let numq = read $ args !! 1
      let rollno = args !! 2
      putStrLn $ "% EE720 Assignment for " ++ rollno ++ "\n"
      texfilecontents <- DTI.readFile fname
      let (preamble, rest) = breakOnEnd beginQuestions texfilecontents
      putStrLn . unpack $ preamble
      let (qtext, endtext) = breakOn endQuestions rest
      let qlist = splitOn questionCommand $ stripStart qtext -- stripStart removes leading whitespace
      let nonemptyqlist = filter ((/=) empty) qlist
      let lenq = length nonemptyqlist
      let prefixedqlist = fmap (append questionCommand) nonemptyqlist
      let rgen = mkStdGen $ firstByteofSeedHash rollno 
      let permutedqlist = shuffle' prefixedqlist lenq rgen
      putStrLn . unpack . Data.Text.concat $ take numq permutedqlist
      putStrLn . unpack $ endtext
