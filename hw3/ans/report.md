

1. Using your code for Task 1, discuss features of object-oriented Perl that are different from the object-oriented features of Ruby.

     In Ruby, there is a concrete concept for class, where in Perl, class and inheritance feels like a hack using the package system. The overall support for object-oriented programming is also worse in Perl. For example every method have to write `my $self = shift;`, to retrive the instance, and after all `a->b(c)` is just a syntax sugar for `b(a, c)`, which can make things more difficult to understand, like when should I use which syntax? Perl also does not have constructor, so any constructor has to create an object, then `blass` it. While it is not used in my homework2, Ruby supports private methods and variables, and Perl doesn't, which means encapsulation has to be enforced by convention.

   ​

2. Using your codes for Task 2, compare the differences of scoping in C/C++ and Perl. Also, explain and justify the variable type declarations of your correct Perl program.

   In C, everything is lexical scoped, and it is easier to understand than Perl's different scoping modes. While `local` in Perl can be convenient, it is every difficult to trace the current scope which make maintance more difficult. Global scoping in C can be archived by simply declaring a variable at the root level, which I think is more clear then Perl's implicit way.

   In the corrected program I wrote, I simply used `my` everywhere, except for credit limit because stricter scoping makes code easier to understand. `$creditLimit` is `local` scopped because it can be override by another `local` variable in a subroutine. Using `local` allows me to change the behaviour of other subroutine without adding another argument. Since `$creditLimit` was declared at the root level, I think it is clear for different subroutines to expect the variable is not going to be a constant, and therefore overriding it with `local` should be acceptable.

   ​

3. Using your codes for Task 2, explain whether dynamic scoping is needed in a programming language.

    I think dynamic scroping is not needed in a programming language, having dynamic scoping means every subroutine has an implicit input other than arguments, and it is hard to debug.

   Also, designing a system without dynamic scoping should not be that hard. In our case, it is wrong to assume everyone has the same credit limit, and therefore credit limit should not be a global variable, but a variable that "sticks" with the account ID, it can be implemented by object-oriented way (Every `User` object has a creditLimit property) or just by creating a accountID-to-creditLimit map. Apart from that, I can imagine dynamic scoping makes optimization difficult.

   Perl uses reference counting for memory management, but using scope like `local`, it is not possible for the compiler to know whether a variable will be used or not in the future, so the only way is to keep the object until the stack pops. If it is `my` scopped, it would be easy to scan the last usage of the variable in that scope.

