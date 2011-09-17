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
euclideanAnswer = Math.sqrt(11)
if euclideanAnswer ==  euclideanDistance(object1, object2)
	puts "PASS"
else
	puts "FAIL"
end

print "SMC test..."
smcAnswer = 1/4
if(smcAnswer == smc(object1, object2))
	puts "PASS"
else
	puts "FAIL"
end

