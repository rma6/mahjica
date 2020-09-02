# Mahjica

Mahjica is an automatic haskell judge for grading student submission at CIn-UFPE IF686.

# Usage
Just enter the following in the console:
```sh
$ ./mahjica.sh
```

The script output files in csv format to the folder results. A different file is created for each problem evaluated.

# Filenames
Pattern files must be named according to the following reular expression:
``` bash
pattern-q[0-9]*.txt
```
The number represents the problem (question) number. The problem numbers don't need to be in sequence, having only pattern-q3.txt and pattern-q10.txt is completely valid.

Student submissions (codes) must named according to the following reular expression:
``` bash
[a-z]+[0-9]*-q[0-9]*.hs
```
``` [a-z]+[0-9]* ``` represents the student login and ``` q[0-9]* ``` the problem number. A valid name could be ``` rma6-q1.hs ```
# Files organization
Pattern files and student submissions should be inside folders named patterns and codes respectively.

A valid configuration for Mahjica could be:
```
  mahjica.sh
  /patterns
    pattern-q1.txt
  /codes
    rma6-q1.hs
    rma7-q1.hs
```

# Pattern files content
Pattern files contains haskell statements in the following formats:
``` haskell
function param1 param2 ... paramN == expectedValue1
function param1 param2 ... paramN == expectedValue2
...
```
An example is provided:
``` haskell
pow2 2 == 4
pow2 3 == 9
pow2 5 == 25
```
pow2 is a function defined as:
``` haskell
pow2 :: Int -> Int
pow2 n = n*n
```

### Todos

 - Add named arguments in mahjica.sh
   - Add option to evaluate only specific problems
   - Add option to evaluate only for specific students

License
----
GPL

**Created by Rafael Marinho**
rma6@cin.ufpe.br / rafaelmarinhoa@gmail.com
