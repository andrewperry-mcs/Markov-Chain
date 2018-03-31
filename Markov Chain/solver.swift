//
//  solver.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/30/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

func cg_solver(A: Matrix, b: Vector) -> Vector {
	var x: Vector = Vector(n: b.size, v: 1.0)
	var r: Vector = b - A * x
	var p: Vector = r
	var L0: Double = r * r
	for _ in 0..<b.size {
		let alpha: Double = L0 / (p.transpose() * (A * p))
		x += alpha * p
		r -= alpha * (A * p)
		let L: Double = r * r
		if(sqrt(L) < 1e-10) {break}
		p = r + (L / L0) * p
		L0 = L
	}
	return(x)
}
