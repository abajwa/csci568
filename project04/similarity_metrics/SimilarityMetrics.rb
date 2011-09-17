# Euclidean distance function.
def euclideanDistance(obj1, obj2)
	running_total = 0
	# Assuming both of the objects are of the same type with the same attributes
	for obVar in obj1.instance_variables
		running_total += (obj1.instance_variable_get(obVar) - obj2.instance_variable_get(obVar))**2
	end
	Math.sqrt(running_total)
end


