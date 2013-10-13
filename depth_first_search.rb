require_relative 'graph'

# A graph can be represented by its adjacency matrix G,
# where G[i][j] == 1 if there is an edge between
# vertices(=nodes) i and j and 0 otherwise.

# G[i][j] should be seen in the next matrix as y,x coordinates.
# I found this confusing in the beginning... but that's just me.

#          S A B C D E F G
GMATRIX = [0,1,0,0,1,0,0,0], # S
          [1,0,1,0,1,0,0,0], # A
          [0,1,0,1,0,1,0,0], # B
          [0,0,1,0,0,0,0,0], # C
          [1,1,0,0,0,1,0,0], # D
          [0,0,1,0,1,0,1,0], # E
          [0,0,0,0,0,1,0,1], # F
          [0,0,0,0,0,0,1,0]  # G

LABELS = %w(S A B C D E F G)

@explored = {}
@stack = []     # Frontier

# depth first search (recursion) - a path, not shortest path
def depth_first_search(vertex, goal_vertex)
  @stack.push(vertex)                                         # Add vertex to frontier
  return 1 if vertex == goal_vertex                           # If goal_vertex is reached, return 1. ! Not necessarily shortest path !
  @explored[vertex.label] = true                              # Mark vertex as being explored
  vertex.edges.each { |edge|                                  # Expand current vertex
    unless @explored.has_key? edge.label                      # If already explored, then ignore the vertex
      return 1 if depth_first_search(edge, goal_vertex) == 1  # Recursively do depth_first on the vertices
    end
  }
  @stack.pop() #Backtracking so popping the vertex from the stack
end

@queue = []

# depth first search as in Winston book (with queue) - a path, not shortest path
def depth_first_search_winston(vertex, goal_vertex)
  @queue.push([vertex])
  @explored = {}
  @explored[vertex.label] = true
  while(!@queue.nil?)
    vertices = @queue.pop
    vertices.last.edges.reverse_each { |edge|
      unless @explored.has_key? edge.label
        @explored[vertex.label] = true
        @queue.push(vertices.dup.push(edge))
        return 1 if edge == goal_vertex
      end
    }
  end
end

# BFS is actually an iterative algorithm, but it can also be done recursively...
# http://stackoverflow.com/questions/2549541/performing-breadth-first-search-recursively
# http://stackoverflow.com/questions/2969033/recursive-breadth-first-travel-function-in-java-or-c
# You can also use iterative deepening depth-first search, but we'll show that later on
def breadth_first_search(vertex, goal_vertex)

end

def breadth_first_search_winston(vertex, goal_vertex)

end


graph = Graph.new(GMATRIX, LABELS) # Create graph from matrix

depth_first_search(graph.vertices.values[0], graph.vertices.values[5]) # Do depth first search from S to E
print 'Depth first search: '
puts 'No Path found' if @stack.nil?
@stack.each { |vertex| print vertex.label } unless @stack.nil?

print "\nDepth first search winston style: "
depth_first_search_winston(graph.vertices.values[0], graph.vertices.values[5]) # Do depth first search from S to E
puts 'No Path found' if @queue.nil?
@queue.last.each { |vertex| print vertex.label } unless @queue.nil?