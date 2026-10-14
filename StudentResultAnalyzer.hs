-- Student Result and Grade Analyzer
-- Functional Programming in Practice - Group Level Mini-Project
-- Compile: ghc StudentResultAnalyzer.hs -o StudentResultAnalyzer
-- Run:     ./StudentResultAnalyzer
-- On Windows PowerShell: .\StudentResultAnalyzer.exe

import Data.List (foldl')

-- Algebraic Data Type (ADT): a grade must be one of these constructors.
data Grade = A | B | C | D | F
  deriving (Eq, Show)

-- Immutable student record.
data Student = Student
  { studentName  :: String
  , studentMarks :: [Int]
  } deriving (Show)

-- Functional error handling with Either; invalid records are not created.
createStudent :: String -> [Int] -> Either String Student
createStudent student marks
  | null (trim student) = Left "student name cannot be empty"
  | null marks = Left ("no marks supplied for " ++ student)
  | any (\m -> m < 0 || m > 100) marks =
      Left ("marks must be between 0 and 100 for " ++ student)
  | otherwise = Right (Student student marks)

-- Small helper to reject names containing only spaces.
trim :: String -> String
trim = reverse . dropWhile (== ' ') . reverse . dropWhile (== ' ')

-- Pure function: computes the average without changing the student record.
averageMarks :: Student -> Double
averageMarks student =
  fromIntegral (foldl' (+) 0 (studentMarks student))
    / fromIntegral (length (studentMarks student))

-- Pure function with guards; Grade is an algebraic data type.
gradeFor :: Double -> Grade
gradeFor percentage
  | percentage >= 80 = A
  | percentage >= 70 = B
  | percentage >= 60 = C
  | percentage >= 50 = D
  | otherwise        = F

-- Pattern matching on Grade.
resultFor :: Grade -> String
resultFor A = "Pass"
resultFor B = "Pass"
resultFor C = "Pass"
resultFor D = "Pass"
resultFor F = "Fail"

-- Higher-order function: map is used to calculate each student's percentage.
percentages :: [Student] -> [Double]
percentages = map averageMarks

-- Higher-order function: filter selects students whose average is at least 50.
passedStudents :: [Student] -> [Student]
passedStudents = filter ((>= 50) . averageMarks)

-- Recursion and pattern matching find the highest-scoring student safely.
topper :: [Student] -> Maybe Student
topper [] = Nothing
topper (firstStudent:remainingStudents) =
  Just (findTopper firstStudent remainingStudents)
  where
    findTopper best [] = best
    findTopper best (current:rest)
      | averageMarks current > averageMarks best =
          findTopper current rest
      | otherwise = findTopper best rest

-- Pattern matching handles both error and success cases.
printStudentReport :: Either String Student -> IO ()
printStudentReport (Left message) =
  putStrLn ("Invalid record: " ++ message)
printStudentReport (Right student) = do
  let avg = averageMarks student
      studentGrade = gradeFor avg
  putStrLn (studentName student ++
    " | Average: " ++ show (roundTo2 avg) ++
    "% | Grade: " ++ show studentGrade ++
    " | Result: " ++ resultFor studentGrade)

-- Display two decimal places without requiring an external package.
roundTo2 :: Double -> Double
roundTo2 value = fromIntegral (round (value * 100) :: Int) / 100

main :: IO ()
main = do
  putStrLn "STUDENT RESULT AND GRADE ANALYZER"
  putStrLn "---------------------------------"

  let records =
        [ createStudent "Asha"  [85, 90, 88]
        , createStudent "Rahul" [72, 68, 75]
        , createStudent "Neha"  [95, 92, 98]
        , createStudent "Aman"  [40, 45, 38]
        , createStudent "Priya" [80, 105, 70] -- demonstrates validation
        ]

      validStudents = [student | Right student <- records]
      passed = passedStudents validStudents

  mapM_ printStudentReport records

  putStrLn ""
  putStrLn ("Students passing (average >= 50): " ++ show (length passed))

  putStr "Topper: "
  case topper validStudents of
    Nothing -> putStrLn "No valid student records"
    Just student ->
      putStrLn (studentName student ++
        " with " ++ show (roundTo2 (averageMarks student)) ++ "%")
