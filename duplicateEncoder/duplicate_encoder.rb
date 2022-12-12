#!/bin/ruby

def gets_with_timeout(sec, timeout_val = nil)
  return gets.chomp if select([$stdin], nil, nil, sec)

  timeout_val
end

def duplicate_encode(str)
  result = ''
  str.each_char { |c| result += str.count(c) >= 2 ? ')' : '(' }
  result
end

str = [
  'Hello, World',
  'House',
  'hhhhhhhhhhhhhi',
  '())(#)))/)()(.))',
  'This is a random message',
  'Its Over Anakin',
  'I have the high ground',
  'Ah sh*t',
  'Here we go again'
]

random = str.sample
puts random
guess = gets_with_timeout(2)

if guess == duplicate_encode(random)
  puts 'HHCTF{DUP_ENC)(}'
else
  puts 'NOPE :('
end
