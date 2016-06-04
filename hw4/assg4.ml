(*CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
breaches of such policy and regulations, as contained in the website
http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 4 
Name: 
Student ID: 
Email Addr: *)

datatype 'a bTree = nil | bt of 'a bTree * 'a * 'a bTree;

val tree = bt(bt(nil,74,nil),
    105,
    bt(bt(nil,109,nil),
        109,
        bt(nil,121,nil)
    )
)

fun inorder nil = []
  | inorder (bt(left, value, right)) = inorder left @ [value] @ inorder right

fun preorder nil = []
  | preorder (bt(left, value, right)) = [value] @ preorder left @ preorder right

fun postorder nil = []
  | postorder (bt(left, value, right)) = [value] @ postorder left @ postorder right

(* List starts at index 0, but homework specify 1 to n *)
fun symmetric (i, n, xs) = List.nth(xs,i-1) = List.nth(xs,n-i)

fun palindrome(0, _) = true
  | palindrome(1, _) = true
  | palindrome(n, xs) =
        List.all (fn i => symmetric(i, n, xs))
        (List.tabulate (n, fn a => a+1))

fun rev [] = []
  | rev (x::xs) = (rev xs) @ [x]

