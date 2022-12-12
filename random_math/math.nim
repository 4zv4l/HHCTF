import random, strutils, strformat

proc main() =
  randomize()

  const operations = ['+','-', '/', '*']

  var
    n1 = rand(-256..265)
    n2 = rand(-256..265)
  if n2 == 0: n2 = rand(1..1024)

  let op: char = operations[rand(0..3)]
  let res = case op:
    of '+': n1+n2
    of '-': n1-n2
    of '/': (n1/n2).int
    of '*': n1*n2
    else: 0

  echo fmt"{n1} {op} {n2} = ?"
  let input = readline(stdin)

  if parseInt(input) == res: echo "Congrats, the flag is {HELLO_NIM}"
  else: echo "NOT RIGHT"


try: main()
except CatchableError as e: echo e.msg
