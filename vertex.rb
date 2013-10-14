class Vertex
  attr_reader :label
  attr_reader :edges

  def initialize(label)
    @label = label
    @edges = []
  end

  def add_edge(vertex)
    @edges.push(vertex)
  end

  def depth_first_search(goal_vertex)
    @explored = {}
    @stack = []     # Frontier
    dfs_recursive(self, goal_vertex)
    @stack
  end

  # depth first search (recursion) - a path, not shortest path
  def dfs_recursive(vertex, goal_vertex)
    @stack.push(vertex)                                         # Add vertex to frontier
    return 1 if vertex == goal_vertex                           # If goal_vertex is reached, return 1. ! Not necessarily shortest path !
    @explored[vertex.label] = true                              # Mark vertex as being explored
    vertex.edges.each { |edge|                                  # Expand current vertex
      unless @explored.has_key? edge.label                      # If already explored, then ignore the vertex
        return 1 if dfs_recursive(edge, goal_vertex) == 1  # Recursively do depth_first on the vertices
      end
    }
    @stack.pop() #Backtracking so popping the vertex from the stack
  end

  private :dfs_recursive
end