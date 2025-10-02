import UIKit

// Basic Graph Using Adjacency List

class Graph {
    
    var adjacencyList: [String: [String]] = [:]
    
    func addVertex(_ vertex: String) {
        adjacencyList[vertex] = []
    }
    
    func addEdge(_ source: String, _ destination: String, isDirected: Bool = false) {
        adjacencyList[source]?.append(destination)
        if !isDirected {
            adjacencyList[destination]?.append(source)
        }
    }
    
    func printGraph() {
        for (vertex, edges) in adjacencyList {
            print("\(vertex): \(edges)")
        }
    }
}


 
   //Example
   
//let graph = Graph()
//graph.addVertex("A")
//graph.addVertex("B")
//graph.addVertex("C")
//graph.addEdge("A", "B")
//graph.addEdge("A", "C")
//graph.addEdge("B", "C")
//
//graph.printGraph()


// Output:
// A: ["B", "C"]
// B: ["A", "C"]
// C: ["A", "B"]



//Graph with Weights



struct Edge {
    let destination: String
    let weight: Int
}

class WeightedGraph {
    var adjacencyList: [String: [Edge]] = [:]

    func addVertex(_ vertex: String) {
        adjacencyList[vertex] = []
    }

    func addEdge(from: String, to: String, weight: Int, isDirected: Bool = false) {
        adjacencyList[from]?.append(Edge(destination: to, weight: weight))
        if !isDirected {
            adjacencyList[to]?.append(Edge(destination: from, weight: weight))
        }
    }

    func printGraph() {
        for (vertex, edges) in adjacencyList {
            let edgeStr = edges.map { "\($0.destination)(\($0.weight))" }.joined(separator: ", ")
            print("\(vertex): \(edgeStr)")
        }
    }
}

func bfs(start: String, graph: [String: [String]]) {
    var visited: Set<String> = []
    var queue: [String] = [start]

    while !queue.isEmpty {
        let node = queue.removeFirst()
        if !visited.contains(node) {
            print(node)
            visited.insert(node)
            queue.append(contentsOf: graph[node] ?? [])
        }
    }
}
