require 'thread'

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

  # depth first search
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

  # depth first search as in Winston book (with array behaving as stack) - a path, not shortest path
  def depth_first_search_winston(goal_vertex)
    return [self] if self == goal_vertex
    @stack = [], @explored = {}
    @stack << [self]
    @explored[self.label] = true
    while @stack
      path = @stack.pop
      path.last.edges.reverse_each { |edge|
        unless @explored.has_key? edge.label
          @explored[edge.label] = true
          new_path = path.dup.push(edge)
          edge == goal_vertex ? (return new_path) : @stack << new_path
        end
      }
    end
  end

  # breadth first search as in Winston book (with array behaving as queue) - shortest path
  def breadth_first_search_winston(goal_vertex)
    return [self] if self == goal_vertex
    @queue = []
    @explored = {}
    @queue << [self]
    @explored[self.label] = true
    while @queue
      path = @queue.pop
      path.last.edges.reverse_each{ |edge|
        unless @explored.has_key? edge.label
          @explored[edge.label] = true
          new_path = path.dup.push(edge)
          edge == goal_vertex ? (return new_path) : @queue.unshift(new_path)
        end
      }
    end
  end

  private :dfs_recursive
end