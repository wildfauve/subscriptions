class Fn

  class << self

    # Common curried map higher order fn
    def map
      ->(f, enum) { enum.map {|e| f.(e) } }.curry
    end

    # Curryed fn that removes elements from a collection where f.(e) is true
    def remove
      ->(f, enum) { enum.delete_if {|e| f.(e) } }.curry
    end

    # finds the first element in a collecton where f.(e) is true
    def find
      ->(f, enum) { enum.find { |e| f.(e) } }.curry
    end

    def select
      ->(f, enum) { enum.select { |e| f.(e) } }.curry
    end

    def max
      ->(f, enum) { f.(enum).max }.curry
    end

    def all?
      ->(f, enum) { enum.all? { |e| f.(e) } }.curry
    end

    def identity
      ->(i) { i }
    end

    # the famous compose
    def compose
      ->(f, g, v) { f.(g.(v)) }.curry
    end

  end

end
