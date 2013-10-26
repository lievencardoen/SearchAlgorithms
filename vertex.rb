class Vertex
  attr_reader :label
  attr_reader :edges

  def initialize(label)
    @label = label
    @edges = []
    @r = Random.new
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

  #Same as depth-first-search, but now not left to right, but randomly
  def non_deterministic_search(goal_vertex)
    @explored = {}
    @stack = []     #
    non_deterministic_recursive(self, goal_vertex)
    @stack
  end

  # depth first search (recursion) - a path, not shortest path
  def non_deterministic_recursive(vertex, goal_vertex)
    @stack.push(vertex)                                         # Add vertex to frontier
    return 1 if vertex == goal_vertex                           # If goal_vertex is reached, return 1. ! Not necessarily shortest path !
    @explored[vertex.label] = true                              # Mark vertex as being explored
    vertex.edges.shuffle!.each { |edge|                          # Expand current vertex
      unless @explored.has_key? edge.label                      # If already explored, then ignore the vertex
        return 1 if non_deterministic_recursive(edge, goal_vertex) == 1       # Recursively do depth_first on the vertices
      end
    }
    @stack.pop() #Backtracking so popping the vertex from the stack
  end

  # iterative deepening search
  def iterative_deepening_search(goal_vertex)
    max_depth = 1
    begin
      @explored = {}
      @stack = [] # Frontier
      puts "search with max_depth #{max_depth}"
      ids_recursive(self, goal_vertex, 0, max_depth)
      max_depth = max_depth + 1
    end while @stack.empty?
    @stack
  end

  # depth first search (recursion) - a path, not shortest path
  def ids_recursive(vertex, goal_vertex, depth, max_depth)
    @stack.push(vertex)                                         # Add vertex to frontier
    return 1 if vertex == goal_vertex                           # If goal_vertex is reached, return 1. ! Not necessarily shortest path !
    @stack.pop() && return if depth == max_depth
    @explored[vertex.label] = true                              # Mark vertex as being explored
    depth = depth + 1
    vertex.edges.each { |edge|                                  # Expand current vertex
      unless @explored.has_key? edge.label                      # If already explored, then ignore the vertex
        return 1 if ids_recursive(edge, goal_vertex, depth, max_depth) == 1  # Recursively do depth_first on the vertices
      end
    }
    @stack.pop() #Backtracking so popping the vertex from the stack
  end

  def bi_directional_search(goal_vertex)

  end

  private :dfs_recursive
  private :non_deterministic_recursive
end