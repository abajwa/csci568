
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

nump = 0
numVowelWrong = 0
numConsWrong = 0
names.each do |name|
	# stripping the whitespace from the winner/loser attribute
	name[1] = name[1].squeeze(" ").strip

	#name.push(name[0].count('aeiouAEIOU'))
	#name.push(name[0].count('a-zA-Z', '^aeiouAEIOU'))
	splitName = name[0].split
	len = 0
	splitName.each do |part|
		len += part.length
	end

	# length of the name
	#name.push(len)
	# length of the first name
	#name.push(splitName[0].length)
	# length of the last name
	#name.push(splitName[splitName.length-1].length)

	# if the first letter is a consonant and the second is a vowel then mark it as 1
	firstLetter = name[0][0]
	secondLetter = name[0][1]
	'''
	if name[1] =~ /[+]/ and ("aeiouAEIOU".index(secondLetter)) == nil
		numVowelWrong+=1
	end
	if name[1] =~ /[+]/ and "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ".index(firstLetter) == nil
		numConsWrong+=1
	end
	if ("aeiouAEIOU".index(secondLetter)) != nil and "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ".index(firstLetter) != nil
		name.push(1)
		if  name[1] =~ /[+]/
			nump+=1
		else
			puts name[0]
		end
	else
		name.push(0)
	end


	# if the first letter is a consonant
	if "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ".index(firstLetter) != nil
		name.push(1)
	else
		name.push(0)
	end
	'''

	# if the second letter is a vowel 
	if "aeiouAEIOU".index(secondLetter) != nil
		if name[1] =~ /[-]/
			puts name[0]
		end
		name.push(1)
	else
		if name[1] =~ /[+]/
			puts name[0]
		end
		name.push(0)
	end
end

CSV.open('WLNewStats.csv', 'w') do |writer|
	names.each do |name|
		writer << name
	end
end

print "Num WINNERS with consonantVowel attribute: "
puts nump

puts "Number of second letter vowels classified wrong: " + numVowelWrong.to_s
puts "Number of first letter consonants classified wrong: " + numConsWrong.to_s