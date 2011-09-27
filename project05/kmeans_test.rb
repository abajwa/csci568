require 'k_means'

filename = 'iris.csv'
file = File.new(filename, 'r')

data = Array.new
file.each_line("\n") do |row|
	columns = row.split(",")
	data.push([columns[0].to_f, columns[1].to_f, columns[2].to_f, columns[3].to_f, columns[4]])
end


clusters = k_means(3, data)

#clusters.each do |clus|
#	puts "cluster------------------------------------------------------------"
#	clus.each do |cl|
#		puts cl
#	end
#	puts "-------------------------------------------------------------------"
#end
