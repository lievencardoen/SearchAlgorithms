require_relative 'vertex'

class Graph

  # The labels of the nodes
  attr_accessor :labels
  # The matrix from which the graph/net is built
  attr_accessor :matrix
  # There's no root node in a graph/net so we just keep an array of nodes
  attr_accessor :vertices

  def initialize(matrix, labels)
    @matrix = matrix
    @labels = labels
    convert_matrix_to_graph
  end

  def convert_matrix_to_graph
    @vertices = {}
    @labels.each { |label| @vertices[label] = Vertex.new(label)}

    @vertices.each { |key, graph_vertex|
      vertex_index = @labels.index key
      @matrix[vertex_index].each_with_index { |edge,index|
        if edge == 1 && vertex_index != @matrix[vertex_index].index(edge)
          graph_vertex.add_edge @vertices[@labels[index]]
        end
      }
    }
  end
end