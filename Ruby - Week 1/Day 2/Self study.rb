#Print the contents of an array of sixteen numbers, four numbers at a time, using just `each`. Now, do the same with `each_slice` in Enumerable.

arr = (1..16).to_a

puts "manual"
arr_other = []
arr.each do |el|
    arr_other.push(el)
    if arr_other.size >= 4 then
        puts arr_other.to_s
        arr_other.clear
    end
end

puts
puts "slice"

arr.each_slice(4) { |el| puts el.to_s }

# see tree2.rb for next exercise

puts
puts "Type a word to look for in this file:"
word = gets(chomp: true)
lines = ''
File.open('Self study.rb', 'r') do |f|
    lines = f.readlines
end
line_number = 0
puts lines.map{ |el| [line_number += 1, el] }.select { |l| l[1].index(word) }.map { |el| "#{el[0]}: #{el[1]}" }