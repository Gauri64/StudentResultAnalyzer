# Student Result and Grade Analyzer (Haskell)

A beginner-friendly Functional Programming mini-project that calculates student averages, assigns grades, reports pass/fail status, validates marks, and identifies the topper.

## Features

- Validates student names and marks (each mark must be between 0 and 100).
- Calculates average marks.
- Assigns grades using the rules below.
- Displays pass/fail status.
- Counts students with an average of at least 50.
- Finds the topper among valid student records.
- Shows an error message for invalid records instead of creating a student with invalid marks.

## Grade rules

| Average | Grade | Result |
|---:|:---:|:---|
| 80–100 | A | Pass |
| 70–79.99 | B | Pass |
| 60–69.99 | C | Pass |
| 50–59.99 | D | Pass |
| Below 50 | F | Fail |

A mark below 0 or above 100 is invalid. An average of 50 or above is considered a pass.

## Run online (no installation needed)

1. Open [OnlineGDB Haskell Compiler](https://www.onlinegdb.com/online_haskell_compiler) or [OneCompiler Haskell](https://onecompiler.com/haskell).
2. Open `StudentResultAnalyzer.hs` in a text editor and copy all its contents.
3. Paste the code into the online compiler's editor.
4. Click **Run** and check the output panel.

## Run locally with GHC

Install the Glasgow Haskell Compiler (GHC), then open a terminal in this folder.

Compile:

```bash
ghc StudentResultAnalyzer.hs -o StudentResultAnalyzer
```

Run on Windows PowerShell:

```powershell
.\StudentResultAnalyzer.exe
```

Run on Linux/macOS:

```bash
./StudentResultAnalyzer
```

## Functional programming concepts demonstrated

- **Algebraic data types:** `Grade` and `Student`.
- **Immutability:** student records are created as values and are not modified in place.
- **Pure functions:** `averageMarks`, `gradeFor`, and `roundTo2` return results without changing program state.
- **Higher-order functions:** `map` and `filter`.
- **Function composition:** `((>= 50) . averageMarks)`.
- **Pattern matching:** grade results and `Either`/`Maybe` values.
- **Functional error handling:** `Either String Student` represents valid and invalid input; `Maybe Student` represents the possibility that no topper exists.
- **Recursion:** the `topper` helper searches for the highest average.

## Sample output

See [`sample_output.txt`](sample_output.txt) for the expected output. Run the program to verify it in your compiler.

## Project scope

The program uses sample student records written in the source code. It does not currently read student data from a file or ask for interactive keyboard input.

## Repository checklist

- [ ] Replace or supplement sample records as required by your assignment.
- [ ] Run the program and verify the output.
- [ ] Add your actual group/member details in your report separately.
- [ ] Push the files to your GitHub repository and share the repository URL with your group.
