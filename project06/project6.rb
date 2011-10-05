
# check number of vowels in each name
# check number of consonants in each name
# num letters in first name
# num letters in last name
# num total letters

require 'csv'

names = Array.new
CSV.open('winners_losers.csv', 'r', ',') do |row|
	names.push([row[0], row[1]])
end

names.each do |name|
	name.push(name[0].count('aeiouAEIOU'))
	name.push(name[0].count('a-zA-Z', '^aeiouAEIOU'))
	splitName = name[0].split
	len = 0
	splitName.each do |part|
		len += part.length
	end
	name.push(len)
	name.push(splitName[0].length)
	name.push(splitName[splitName.length-1].length)
end

CSV.open('WLNewStats.csv', 'w') do |writer|
	names.each do |name|
		writer << name
	end
end

puts names[0]
