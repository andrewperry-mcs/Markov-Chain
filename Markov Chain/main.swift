//
//  main.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/29/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

func main() {
	let m = Matrix([[4, 1], [1, 3]])
	let v = Vector([1, 2])
	let sol = cg_solver(A: m, b: v)
	print(sol)
}

main()

