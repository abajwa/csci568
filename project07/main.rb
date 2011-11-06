require 'neuron'
require 'layer'
require 'network'

# creates the array that specifies the number of layers and the
# number of neurons in each layer
layerSizes = [3,2,3]
network = Network.new(layerSizes)
network.input([1.0, 0.25, -0.5])
network.result([1.0, -1.0, 0.0])

# displays the results of a simple feed forward through the network
network.train

puts "\nResults: "
puts network.output