require'SimilarityMetrics'

# class with 4 instance variables used to test the similarity metrics
class TestClass
	def initialize(i1, i2, i3, i4)
		@i1 = i1
		@i2 = i2
		@i3 = i3
		@i4 = i4
	end
end

object1 = TestClass.new(1,3,4,6)
object2 = TestClass.new(1,4,5,9)
object3 = TestClass.new(8,7,5,10)
object4 = TestClass.new(4,5,3,5)

print "Euclidean Distance test..."
euclideanAnswer = 1/(1 + Math.sqrt(11))
if euclideanAnswer ==  euclideanDistance(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end

print "SMC test..."
smcAnswer = 1.0/4.0
if smcAnswer == smc(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end

print "Tanimoto test..."
tani = 87.0/(62.0+123.0-87.0)
tani = 1.0/(1.0 + tani.abs)
if tani == tanimoto(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end

print "Pearsons Correlation test..."
pearsons = (20.5 * 1.0/3.0)/(Math.sqrt(13.0 * 1.0/3.0) * Math.sqrt(32.75 * 1.0/3.0))
if pearsons == pearsons(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end

print "Cosine Similarity test..."
cosine = 87.0/(Math.sqrt(62) * Math.sqrt(123))
if cosine == cosineSimilarity(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end