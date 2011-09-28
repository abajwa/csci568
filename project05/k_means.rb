
def k_means(k, data, n)
	centroids = Array.new

	while centroids.length != k
		c = rand(data.length)
		if centroids.include?(data[c]) == false
			centroids.push(data[c][0..n])
		end
	end

	clusters = Array.new(k)
	centroidsChanged = true

	while centroidsChanged.equal?(true)

		for i in 0...k
			clusters[i] = Array.new
		end

		centroidsChanged = false

		# assign each data point to the closest centroid
		data.each do |d|
			minDist = euclideanDistance(d[0..n], centroids[0])
			minDistCentroid = 0
			i = 0
			# figures out the centroid closest to the data point
			centroids.each do |c|
				edist = euclideanDistance(d[0..n],c)
				if minDist > edist
					minDist = edist
					minDistCentroid = i
				end
				i+=1
			end
			clusters[minDistCentroid].push(d)
		end

		oldCentroids = centroids
		centroids = Array.new
		# move the location of the centroid to the middle of the cluster
		clusters.each do |cluster|
			avgArray = Array.new(n+1)
			avgArray.fill(0.0)
			cluster.each do |iris|
				for i in 0...n+1
					avgArray[i] += iris[i]
				end
			end
			for i in 0...avgArray.length
				avgArray[i] = avgArray[i]/cluster.length
			end
			centroids.push(avgArray)
		end

		# checks to see if any of the centroids moved
		centroids.each do |centroid|

			if not oldCentroids.include?(centroid)
				centroidsChanged = true
			end
		end
	end

	clusters
end

# similarity metric used for k-means
def euclideanDistance(obj1, obj2)
	euc = 0
	for d in 0...obj1.length
		euc += (obj1[d] - obj2[d])**2
	end
	Math.sqrt(euc)
end