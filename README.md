Lisc
====

Lisc is a toy Lisp interpreter written in Objective-C, loosely based on Peter Norvig's [Lispy](http://norvig.com/lispy.html "Lispy"). Originally conceived as a hackday project, Lisc is nowhere near full featured enough to be useful for serious development, but it does serve as an interesting example of how to build a language interpreter from scratch, as well as the peculiar elegance in how Lisp-like languages can be bootstrapped from a small core of expressions. 

Currently the language supports some basic arithmetic, strings, conditionals, list operations, lambdas, and lexically scoped variable binding.

Examples
----

```scheme
(define foo 
  (lambda (x) (+ x 20)))   
(foo 20)
> 40
```

```scheme
(first ("foo" "bar" "baz"))
> "foo"
```

```scheme
(if (is "foo" "foo")
  (print "equal")
  (print "not equal"))
> "equal"
```

```scheme
(if (is "foo" "bar")
  (print "equal")
  (print "not equal"))
> "not equal"
```

