//
//  main.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/29/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

func main() {
	let g = Graph()
	g.add_node("A")
	g.add_node("B")
	print(g)
	g.add_edge(node_1: g.node("A"), node_2: g.node("B"))
	print(g)
	print(g.has_edge(g.edge(node_1: g.node("A"), node_2: g.node("B"))))
	let _ = g.remove_edge(node_1: g.node("A"), node_2: g.node("B"))
	print(g)
	print(g.has_edge(g.edge(node_1: g.node("A"), node_2: g.node("B"))))
}

main()

