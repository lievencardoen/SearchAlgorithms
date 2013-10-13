require 'rspec'
require_relative '../graph'

#          S A B C D E F G
MATRIX =  [0,1,0,0,1,0,0,0], # S
          [1,0,1,0,1,0,0,0], # A
          [0,1,0,1,0,1,0,0], # B
          [0,0,1,0,0,0,0,0], # C
          [1,1,0,0,0,1,0,0], # D
          [0,0,1,0,1,0,1,0], # E
          [0,0,0,0,0,1,0,1], # F
          [0,0,0,0,0,0,1,0]  # G

LABELS = %w(S A B C D E F G)

describe Graph do

  before :each do
    @graph = Graph.new(MATRIX, LABELS)
  end

  describe '#new' do
    it 'takes two parameters and returns a Graph object' do
      @graph.should be_an_instance_of Graph
    end

    it 'takes two parameters and sets the graph' do
      @graph.matrix.should be MATRIX
    end

    it 'takes two parameters and sets the labels' do
      @graph.labels.should be LABELS
    end

    it 'takes two parameters and creates for each label a vertex' do
      @graph.vertices.should_not be_nil
      @graph.vertices.keys.each_with_index { |key,index| # For each vertex in the graph, check its edges
        key.should eq LABELS[index] # The graph first creates vertices for each of the passed labels
      }
    end

    it 'takes two parameters and converts the matrix into a graph' do
      @graph.vertices.values.each_with_index { |vertex,vertex_index| # For each vertex in the graph, check its edges
        MATRIX[vertex_index].each_with_index { |matrix_edge, matrix_edge_index| # If value = 0, 0 edges. If value = 1, 1 edge.
          vertex.edges.select{ |vertex_edge|
            vertex_edge.label == LABELS[matrix_edge_index]
          }.count.should eq matrix_edge #
        }
      }
    end

  end

  describe '#matrix' do
    it 'sets the matrix' do
      @graph.matrix = nil
      @graph.matrix.should be_nil
      @graph.matrix = MATRIX
      @graph.matrix.should be MATRIX
    end
  end

  describe '#labels' do
    it 'sets the labels' do
      @graph.labels = nil
      @graph.labels.should be_nil
      @graph.labels = LABELS
      @graph.labels.should be LABELS
    end
  end

  describe 'depth first search' do
    it 'should find SABE' do
      root_vertex = @graph.vertices['S']
      goal_vertex = @graph.vertices['E']
      stack = root_vertex.depth_first_search(goal_vertex)
      stack.map { |vertex| vertex.label }.join().should eq 'SABE'
    end
  end
end