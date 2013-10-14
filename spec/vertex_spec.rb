require 'rspec'
require_relative '../vertex'

LABEL = 'label'

describe Vertex do

  before :each do
    @vertex = Vertex.new(LABEL)
  end

  describe '#new' do
    it 'takes one parameters and returns a Vertex object' do
      @vertex.should be_an_instance_of Vertex
    end

    it 'takes one parameter and sets the label' do
      @vertex.label.should be LABEL
    end

    it 'takes on parameter and initializes edges as an empty array' do
      @vertex.edges.should match_array(Array.new)
    end
  end

  describe 'add_edge' do
    it 'should add a vertex as an edge' do
      vertex_edge = Vertex.new('edge')
      @vertex.add_edge vertex_edge
      @vertex.edges[0].should be vertex_edge
    end
  end
end