
f <- function(a,
              b,
              c) { # #nolint
              just(one)
}


f <- function(a,
              b,
              c) # #nolint
  {
  f()
  g()
  f()
  g()
  f()
  g()
  f()
  g()
  f()
  g()

}
