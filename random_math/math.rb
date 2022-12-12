#!/bin/ruby

n1 = rand(-256..265)
n2 = rand(-256..265)
n2.zero? && n2 = rand(1..1024)

re = 0

case rand(4)
when 0
  puts "#{n1} + #{n2}"
  re = n1 + n2
when 1
  puts "#{n1} - #{n2}"
  re = n1 - n2
when 2
  puts "#{n1} * #{n2}"
  re = n1 * n2
when 3
  puts "#{n1} / #{n2}"
  re = n1 / n2
end

guess = gets.chomp.to_f

guess == re ? puts('Congrats, the flag is {HELLO_RUBY}') : puts('NOT RIGHT')
