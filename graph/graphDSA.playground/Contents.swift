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

//---------------------------------------------LEET CODE ------------------------------------------------------------------------//

// Number of Provinces
//
//There are n cities. A province is a group of directly or indirectly connected cities and no other cities outside of the group. You are given an n x n matrix isConnected where isConnected[i][j] = isConnected[j][i] = 1 if the ith  city and the jth  city are directly connected, and isConnected[i][j] = 0 otherwise. Return the total number of provinces.
//

 
func numberOfProvince(_ isConnected: [[Int]]) -> Int {
    
    var n = isConnected.count
    
    var graph = Array(repeating: [Int](), count: n)
    
    
   
    
    for i in 0..<n {
        for j in (i+1)..<n {
            if isConnected[i][j] == 1 {
                graph[i].append(j)
                graph[j].append(i)
            }
        }
    }
    
    var province = 0 
    var seen = Set<Int>()
    
    func dfs(_ node: Int) {
        for neighbor in graph[node] {
            if !seen.contains(neighbor) {
                seen.insert(neighbor)
                dfs(neighbor)
            }
        }
    }
    
    for i in 0..<n {
        province += 1
        seen.insert(i)
    }
    return province
}



// Number of Islands
//
//Given an m x n 2D binary grid which represents a map of 1 (land) and 0 (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent land cells horizontally or vertically.


func numOfIslands(_ grid: [[Character]]) -> Int {
    var m = grid.count
    var n = grid[0].count 
    
    let direction = [(0,1),(1,0),(0,-1),(-1,0)]
    
    var seen = Set<[Int]>()
    
    func isValid(_ r: Int,_ c: Int)-> Bool {
        return r>=0 && r<m && c>=0 && c<n && grid[r][c] == "1"
    }
    
    func dfs(_ row: Int,_ col: Int) {
        for (dx,dy) in direction {
            let nextRow = row + dx
            let nextCol = col + dy
            
            if isValid(nextRow, nextCol) && !seen.contains([nextRow,nextCol]) {
                seen.insert([nextRow,nextCol])
                dfs(nextRow, nextCol)
            }
            
        }
    }
    
    var ans = 0 
    
    for i in 0..<m {
        for j in 0..<n {
            if grid[i][j] == "1" && !seen.contains([i,j]) {
                ans += 1
                dfs(i,j)
            }
        }
    }
    
    return ans
}

// Reorder Routes to Make All Paths Lead to the City Zero
//
//There are n cities numbered from 0 to n - 1 and n - 1 roads such that there is only one way to travel between two different cities. Roads are represented by connections where connections[i] = [x, y] represents a road from city x to city y. The edges are directed. You need to swap the direction of some edges so that every city can reach city 0. Return the minimum number of swaps needed.

func minOrder(_ n: Int,_ connections: [[Int]]) -> Int {
    
    var roads = Set<String>()
    var graph = Array(repeating: [Int](), count: n)
    
    
    for edge in connections {
        let x = edge[0]
        let y = edge[1]
        
        graph[x].append(y)
        graph[y].append(x)
        roads.insert("\(x),\(y)")
    }
    
    var visited = Set<Int>()
    visited.insert(0)
    
    func dfs(_ node: Int) -> Int {
        var count = 0 
        
        for neighbor in graph[node] {
            if !visited.contains(neighbor) {
                if roads.contains("\(node),\(neighbor)") {
                    count += 1
                }
            }
            visited.insert(neighbor)
            count += dfs(node)
        }
        
        return count
    }
    
    return dfs(0)
}


// Keys and Rooms
//
//There are n rooms labeled from 0 to n - 1 and all the rooms are locked except for room 0. Your goal is to visit all the rooms. When you visit a room, you may find a set of distinct keys in it. Each key has a number on it, denoting which room it unlocks, and you can take all of them with you to unlock the other rooms. Given an array rooms where rooms[i] is the set of keys that you can obtain if you visited room i, return true if you can visit all the rooms, or false otherwise.


func canVisitAllRoom(_ rooms: [[Int]]) -> Bool {
    
    var n = rooms.count
    var visited = Set<Int>()
    
    func dfs(_ room: Int){
        visited.insert(room)
        
        for key in rooms[room] {
            if !visited.contains(key){
                dfs(key)
            }
        }
        
        
    }
    
    dfs(0)
    return visited.count == n
}
