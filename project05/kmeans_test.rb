require 'k_means'
require 'csv'

data = Array.new
CSV.open('iris.csv', 'r', ',') do |row|
	data.push([row[0].to_f, row[1].to_f, row[2].to_f, row[3].to_f, row[4]])
end

data.pop



clusters = k_means(3, data, 3)




puts clusters[0].size
puts clusters[1].size
puts clusters[2].size

=begin
clusters[1].each do |c|
	puts c
end


=begin
clusters.each do |clus|
	puts "CLUSTER------------------------------------------------------------"
	clus.each do |cl|
		puts cl
	end
	puts "-------------------------------------------------------------------"
end
=end