# Table of Contents <a name="anchor_main"></a>
---
1. [File Relationships](#anchor_1)
2. [Part 1 - c](#anchor_2)
3. [Part 2 - a](#anchor_3)
4. [Part 2 - b](#anchor_4)
5. [References](#anchor_5)

## File Relationships <a name="anchor_1"></a> [top](#anchor_main)
1. TestGaussSolve.m is wrapper (main()).
2. GaussSolve.m (Gauss eliminator) is a sub-function that is called by the wrapper.
3. kill.m (a cleaner) is a sub-function that is called by the wrapper.

* Below will cover contents of the wrapper.

## Part 1 - c <a name="anchor_2"></a> [top](#anchor_main)
* GaussSolve with different sample sizes part; Showing how long does it take for a matrix (A) of increasing size to be Gauss eliminated

## Part 2 - a <a name="anchor_3"></a> [top](#anchor_main)
* Truss, column order in F1, F2, F3, H2, V2, V3 part; Setting matrix 'A' and 'b' to be feeded into [x, det] = GaussSolve(A, b)
* Gauss elimination part; Calling GaussSolve.m & Printing the results

## Part 2 - b <a name="anchor_4"></a> [top](#anchor_main)
* Traffic, column order in x\_1, x\_2, x\_3, x\_4, x\_5 part; Setting matrix 'A' and 'b' to be feeded into [x, det] = GaussSolve(A, b)
* Gauss elimination part; Calling GaussSolve.m, but this does not work out, thus we have to solve the problem manually.
* Free variables part; The manual solvation with some free variables & Printing the results

## References <a name="anchor_5"></a> [top](#anchor_main)
Please check Git repo for [latest update][1]

Please send any questions to: <kwb425@icloud.com>

<!--Links to addresses, reference Markdowns-->
[1]: https://github.com/kwb425/KU_Applied_Mathematics_2016_Spring.git
<!--Links to images, reference Markdowns-->