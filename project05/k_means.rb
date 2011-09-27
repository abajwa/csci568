
def k_means(k, data)

	centroids = []

	while centroids.length != k
		c = rand(data.length)
		if centroids.include?(data[c]) == false
			centroids.push(data[c][0..3])
			puts data[c][0..3]
		end
	end

	clusters = []
	for i in 0...k
		clusters[i] = Array.new
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