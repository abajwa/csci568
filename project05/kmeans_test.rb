require 'k_means'
require 'csv'

data = Array.new
CSV.open('iris.csv', 'r', ',') do |row|
	data.push([row[0].to_f, row[1].to_f, row[2].to_f, row[3].to_f, row[4]])
end

data.pop

clusters = k_means(3, data, 4)

i = 1
sse = 0.0
clusters.each do |cluster|
	puts "Cluster: " + i.to_s + "\tNumber of Elements: " + cluster.length.to_s
	centroid = findCentroid(cluster, 4)
	cluster.each do |point|
		sse += euclideanDistance(point[0...4], centroid)**2
	end
	i+=1
end
puts "\nTotal SSE: " + sse.to_s