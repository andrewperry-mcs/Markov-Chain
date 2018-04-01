//
//  graph.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/31/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

class Graph {
	
	typealias size_type = UInt64
	typealias real_type = Double
	typealias node_type = Node
	typealias edge_type = Edge
	
	struct Node {
		private var id_: size_type
		private var name_: String
	
		fileprivate init(id: size_type, name: String) {
			self.id_ = id
			self.name_ = name
		}
		
		var id: size_type {
			get {return(self.id_)}
			set(newID) {self.id_ = newID}
		}
		
		var name: String {
			get {return(self.name_)}
			set(newName) {self.name_ = newName}
		}
		
		static func ==(l: Node, r: Node) -> Bool {
			return(l.id == r.id)
		}
		
		static func !=(l: Node, r: Node) -> Bool {
			return(!(l == r))
		}
		
		static func <(l: Node, r: Node) -> Bool {
			return(l.id < r.id)
		}
		
		static func >(l: Node, r: Node) -> Bool {
			return(l.id > r.id)
		}
	}
	
	struct Edge {
		private var id_: size_type
		private var val_: real_type
		private var node_1_: node_type
		private var node_2_: node_type
		
		fileprivate init(id: size_type, val: real_type, node_1: node_type, node_2: node_type) {
			self.id_ = id
			self.val_ = val
			self.node_1_ = node_1
			self.node_2_ = node_2
		}
		
		var id: size_type {
			get {return(self.id_)}
			set(newID) {self.id_ = newID}
		}
		
		var node_1: node_type {
			get {return(self.node_1_)}
			set(newNode) {self.node_1_ = newNode}
		}
		
		var node_2: node_type {
			get {return(self.node_2_)}
			set(newNode) {self.node_2_ = newNode}
		}
		
		static func ==(l: Edge, r: Edge) -> Bool {
			return(l.id == r.id)
		}
		
		static func !=(l: Edge, r: Edge) -> Bool {
			return(!(l == r))
		}
		
		static func <(l: Edge, r: Edge) -> Bool {
			return(l.id < r.id)
		}
		
		static func >(l: Edge, r: Edge) -> Bool {
			return(l.id > r.id)
		}
	}
	
	private var nodes: [size_type : node_type]
	private var edges: [size_type : edge_type]
	
	init() {
		self.nodes = [size_type : node_type]()
		self.edges = [size_type : edge_type]()
	}
	
	var num_nodes: size_type {return(size_type(self.nodes.count))}
	var num_edges: size_type {return(size_type(self.edges.count))}
	var is_empty: Bool {return(self.nodes.isEmpty)}
	
	func add_node(_ name: String = "") {
		let new_node: node_type = node_type(id: self.num_nodes , name: name)
		self.nodes[self.num_nodes] = new_node
	}
	
	func add_edge(node_1: node_type, node_2: node_type, p: real_type = 0.0) {
		let new_edge: edge_type = edge_type(id: self.num_edges, val: p, node_1: node_1, node_2: node_2)
		self.edges[self.num_edges] = new_edge
	}
	
	func has_node(_ n: node_type) -> Bool {
		return(self.nodes[n.id] != nil)
	}
	
	func has_edge(_ e: edge_type) -> Bool {
		return(self.edges[e.id] != nil)
	}
	
	func node(_ id: size_type) -> node_type {
		return(self.nodes[id]!)
	}
	
	func edge(_ id: size_type) -> edge_type {
		return(self.edges[id]!)
	}
	
}
