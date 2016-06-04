Name:
SID: 

1. Using your codes for Task 2, compare polymorphism obtained with duck typing and with inheritance.

I used C++. Without template and dynamic try casting, it is not possible to upcast to a subclass from a superclass, and therefore subclass’s methods would not be called. That is the biggest problem I had with C++. I finally have to write multiple functions overloading each subclass, to make the correct function being called. Also, it is not possible to create an array with multiple types, so I used macro to work around the looping part, but it feels really hacky and somehow cheating.

On the other hand, ruby’s type system is very dynamic, I can check “just call” the method without knowing which exact is it. This is very convenient and speed up development a lot. But it may result in worse maintainability, it is hard to imagine how is the data look like when looking at a function, and there can be lots of possibility. There isn’t any type check and therefore feel less “safe” than C++.

2. Using your codes for Task 2, give a scenario where the Ruby implementation is better than the Java/C++ implementation. Briefly state your reason.

A very good scenario would be in a small startup making websites for clients. Since most of the jobs received from clients are short-lived, it is better to get the job done quickly and switch to the next project, and Ruby helps this kind of quick-paced development without considering maintainability. It is also very common for clients to change requirements in a nonsense way, Ruby’s dynamic system allows code to be super hacky, we can create similar objects which shim another object, inject or ever override methods in other classes, which helps us to deal with stupid clients. 

It is also very good for making DSL. We can create a group of classes and modules and let user to mixes whatever they want. Therefore it is good for writing little scripts that automating stuffs for everyday uses, for example deleting all the spam from our university.