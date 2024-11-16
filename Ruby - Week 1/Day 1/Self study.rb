puts "Hello, World."

puts "Hello, Ruby".index("Ruby")

i = 0
while i < 10
  puts "Axel"
  i = i + 1
end

i = 1
while i <= 10
  puts "This is sentence number #{i}"
  i = i + 1
end

puts "Lets play a game. Guess a number between 0 and 99, inclusive."

to_guess = rand(100)
ans = -1
while ans != to_guess
    ans = gets().to_i
    puts "Too low" if ans < to_guess
    puts "Too high" if to_guess < ans
end
puts "You figured it out!"