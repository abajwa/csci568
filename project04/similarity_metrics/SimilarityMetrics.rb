# Assuming (for all functions) both of the objects are of the same type with the same attributes

# Euclidean Distance function
def euclideanDistance(obj1, obj2)
	running_total = 0
	for obVar in obj1.instance_variables
		running_total += (obj1.instance_variable_get(obVar) - obj2.instance_variable_get(obVar))**2
	end
	Math.sqrt(running_total)
end

# Simple Matching Coefficients (SMC) function
def smc(obj1, obj2)
	similar = 0;
	for obVar in obj1.instance_variables
		if obj1.instance_variable_get(obVar) == obj2.instance_variable_get(obVar)
			similar += 1
		end
	end
	similar/obj1.instance_variables.length
end
