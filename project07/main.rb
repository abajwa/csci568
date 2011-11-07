require 'neuron'
require 'layer'
require 'network'

# creates the array that specifies the number of layers and the
# number of neurons in each layer
layerSizes = [3,2,3]
network = Network.new(layerSizes)

# defines the network input and target output
network.input([1.0, 0.25, -0.5])
network.target_output([1.0, -1.0, 0.0])

# trains the network with the above input and output
network.train()