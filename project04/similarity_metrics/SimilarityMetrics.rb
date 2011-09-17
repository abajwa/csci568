# Assuming (for all functions) both of the objects are of 
# the same type with the same attributes that are all numbers

# Euclidean Distance function
def euclideanDistance(obj1, obj2)
	running_total = 0
	for obVar in obj1.instance_variables
		running_total += (obj1.instance_variable_get(obVar) - obj2.instance_variable_get(obVar))**2
	end
	1.0/(1.0 + Math.sqrt(running_total))
end

# Simple Matching Coefficients (SMC) function
def smc(obj1, obj2)
	similar = 0.0;
	for obVar in obj1.instance_variables
		if obj1.instance_variable_get(obVar) == obj2.instance_variable_get(obVar)
			similar += 1.0
		end
	end
	similar/obj1.instance_variables.length
end

# Tanimoto function
def tanimoto(obj1, obj2)
	dot = dotProduct(obj1, obj2)
	mx = magnitude(obj1)
	my = magnitude(obj2)
	1.0/(1.0 + (dot/(mx**2 + my**2 - dot)).abs)
end

# calculates the dot product for a given object
def dotProduct(obj1, obj2)
	dotProduct = 0
	for obVar in obj1.instance_variables
		dotProduct += obj1.instance_variable_get(obVar) * obj2.instance_variable_get(obVar)
	end
	dotProduct
end

# calculates the magnitude for a given object
def magnitude(obj)
	mag = 0
	for obVar in obj.instance_variables
		mag += obj.instance_variable_get(obVar)
	end
	Math.sqrt(mag)
end

# Pearson's Correlation function
def pearsons(obj1, obj2)
	xAvg = mean(obj1)
	yAvg = mean(obj2)
	stdX = 0.0
	stdY = 0.0
	covar = 0.0
	for obVar in obj1.instance_variables
		x = obj1.instance_variable_get(obVar)
		y = obj2.instance_variable_get(obVar)
		covar += (x - xAvg)*(y - yAvg)
		stdX += (x - xAvg)**2
		stdY += (y - yAvg)**2
	end
	preN = 1.0 / (obj1.instance_variables.length - 1.0)
	covar = preN * covar
	stdX = Math.sqrt(preN * stdX)
	stdY = Math.sqrt(preN * stdY)
	covar/(stdX * stdY)
end

# calculates the mean for a given object
def mean(obj)
	mean = 0.0
	for obVar in obj.instance_variables
		mean += obj.instance_variable_get(obVar)
	end
	mean/obj.instance_variables.length
end

# Cosine Similarity function
def cosineSimilarity(obj1, obj2)
	dotProduct(obj1, obj2)/(magnitude(obj1) * magnitude(obj2))
end