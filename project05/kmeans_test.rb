require 'k_means'
require 'csv'

# loads the data into a 2D array
data = Array.new
CSV.open('iris.csv', 'r', ',') do |row|
	data.push([row[0].to_f, row[1].to_f, row[2].to_f, row[3].to_f, row[4]])
end

data.pop

# does the clustering
clusters = k_means(3, data, 4)
puts "Iris Data Results using k = 3\n\n"
# calculates the SSE per cluster and prints out the results for
# each cluster
i = 1
totalSSE = 0.0
clusters.each do |cluster|
	puts "Cluster: " + i.to_s
	puts "\tNumber of Elements: " + cluster.length.to_s
	centroid = findCentroid(cluster, 4)
	sse = 0.0
	cluster.each do |point|
		sse += euclideanDistance(point[0...4], centroid)**2
	end
	totalSSE += sse
	puts "\tSSE: " + sse.to_s
	i+=1
end
puts "\nTotal SSE: " + totalSSE.to_s