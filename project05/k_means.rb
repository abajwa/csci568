
def k_means(k, data, n)

	centroids = []

	while centroids.length != k
		c = rand(data.length)
		if centroids.include?(data[c]) == false
			centroids.push(data[c][0..n])
			puts data[c][0..n]
		end
	end

	clusters = []
	for i in 0...k
		clusters[i] = Array.new
	end

	# assign each data point to the closest centroid
	data.each do |d|
		minDist = euclideanDistance(d[0..n], centroids[0][0..n])
		minDistCentroid = 0
		i = 0
		# figures out the centroid closest to the data point
		centroids.each do |c|
			edist = euclideanDistance(d[0..n],c[0..n])
			if minDist > edist
				minDist = edist
				minDistCentroid = i
			end
			i+=1
		end

		clusters[minDistCentroid].push(d)
	end


	# repeat
end

# similarity metric used for k-means
def euclideanDistance(obj1, obj2)
	euc = 0
	for d in 0...obj1.length
		euc += (obj1[d] - obj2[d])**2
	end
	1.0/(1.0 + Math.sqrt(euc))
end