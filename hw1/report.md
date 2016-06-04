Name: 
SID: 

1. Compare the conveniences and difficulties in implementing the program in Fortran and COBOL. You can divide your comparison into specific tasks such as “file I/O”, “DDA implementation”, etc.

# File I/O

In COBOL, file I/O depends on the format definition in the file section of data division, which is pretty straight and more predictable compare with Fortrans’. In Fortran, the file structure is more flexible, I can read lines with different format easily, thus implements the program much faster.

# Data Structure

COBOL support nested data structure, which I find quite convenient. For example in the following code:

```
000070 WORKING-STORAGE SECTION.
000071 01 GRAPH-TABLE.
000072    03 THE-ROW  OCCURS 23.
000073      05 THE-CELL  PIC X OCCURS 79.
``` 

I can print the whole row (as a string) by just calling `DISPLAY THE-ROW(1).`, and I can reference a single cell by using `THE-CELL(1,2)`. This makes combining data easier. In Fortran, I have to loop over every cell to print it.

# Number types

In COBOL, there are different types for non-integer, which was confusing at the beginning. I mixed up the `99.99` and `99V99`. Where in Fortran, I only need to specific REAL or INTEGER, without saying how large it is, which is more convenient.

# Flow Control

While both of them use GOTO-based flow control, I find COBOL’s way easier to manage. Because its label are in name instead of just number as in Fortran, so I can easily search the labels and probably easier to collaborate if others if needed.


2. Compare Fortran and COBOL with a modern programming language (e.g., C/C++/Java/…) in different aspects (e.g., data types, parameter passing, paradigm, paradigm, etc.). You are free to pick your favorite modern programming language.

Javascript is a modern programming language, but there are some similarities between the languages (mostly behaviour before ES6), which I find them quite interesting.

# Scope

There is no scope in both Fortran and COBOL, and Javascript is function-scoping. Since everything in Fortran and COBOL is global, there is no encapsulation at all, and it makes management rather difficult. It is hard to prevent memory being modified by code that is not suppose to. Javascript suffers a very similar problem, by default there are lots of global objects, and it is very easy to create one. For example a `<div id=“hello”>` would create a global `hello` variable, and assignment without using the `var` keyword means it is a global variable as well (To me, this implicitness feels very similar to Fortran’s implicit variable declaration, and typed by the initial of the name of variable). Luckily, Javascript has function-scoping, which people utilise it and create different patterns around it. Just like every variable is accessible in Fortran and COBOL, every property of an object is accessible in Javascript, there is no internal or private variable, people can easily mess things up by modifying something they should not.

Lack of basic elements like scope and access control would encourage people to implement their own. I believe in the old days, Fortran and COBOL programs tackle this problem by writing documents and enforce the rules manually. This is surprising similar in Javascript.

# Types

Type in Fortran and COBOL is strong and checked during compile time, when reading a file doesn’t fit the type, a runtime error is thrown if it cannot be converted. However in Javascript, types are weak, and would be handled in runtime, unexpected result may be generated during implicit conversion, e.g. you can add a function and an object, and the result is a string. 

Fortran and COBOL has array type, but doesn’t has dictionary or hashmap type, which means we can only associate values with integer, but not another value. There is also no class or object in Fortran and COBOL, while Javascript doesn’t have class, it can relate objects by prototype, which is a very flexible design.

There is one thing that Fortran and COBOL do, but not Javascript doesn’t, which is integer handling. In Javascript, every number is a float, so it has float number’s weirdness, e.g. `0.1+0.2=0.30000000000000004`, where Fortran and COBOL support true integer.

The most interesting thing in Javascript that Fortran and COBOL miss, is function. Although there is subroutine, it is not a value and cannot be passed to somewhere else just like a parameter. Javascript’s API is designed with functions in mind, and therefore can be written in a quite functional way.

# Memory

Fortran and COBOL doesn’t have `alloc` and `free`, it seems to me that there is just a big heap, and memory need to managed by manually, in practice that would be document-based management. In some newer languages, there is dynamic memory allocation, or even automatic reference counting which makes memory management easier. In Javascript, memory is handled by garbage collection, which means it goes back to the alloc-and-free-less style, of course they have very different meaning and design.

Javascript’s memory management is very convenient, because programmers doesn’t have to care about anything, but this also forgo the ability to handle memory manually, which generally means worse performance.