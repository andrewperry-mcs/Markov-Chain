//
//  matrix.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/29/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

class Matrix : CustomStringConvertible {
	
	private var data_: [[Double]]
	private var m_: Int
	private var n_: Int
	private var t_: Bool
	
	init() {
		self.data_ = [[Double]]()
		self.m_ = 0; self.n_ = 0
		self.t_ = false
	}
	
	init(m: Int, n: Int, v: Double) {
		self.data_ = Array(repeatElement(Array(repeatElement(v, count: n)), count: m))
		self.m_ = m; self.n_ = n; self.t_ = false
	}
	
	init(_ vals: [[Double]]) {
		self.data_ = vals
		self.m_ = vals.count; self.n_ = vals[0].count
		self.t_ = false
	}
	
	var description: String {
		var res: String = ""
		for i in 0..<self.m_ {
			for j in 0..<self.n_ {
				if(j + 1 == self.n_) {
					res += "\(self.data_[i][j])"
				} else {
					res += "\(self.data_[i][j]), "
				}
			}
			res += "\n"
		}
		return(res)
	}
	
	subscript(i: Int, j: Int) -> Double {
		get {
			precondition(i >= 0 && i < self.m_ && j >= 0 && j < self.n_, Constants.index_error)
			return(self.data_[i][j])
		}
		set(newVal) {
			precondition(i >= 0 && i < self.m_ && j >= 0 && j < self.n_, Constants.index_error)
			self.data_[i][j] = newVal
		}
	}
	
	func row(_ i: Int) -> Vector {
		precondition(i >= 0 && i < self.m_, Constants.index_error)
		return(Vector(self.data_[i]))
	}
	
	func col(_ i: Int) -> Vector {
		precondition(i >= 0 && i < self.m_, Constants.index_error)
		var res: [Double] = [Double](repeatElement(0.0, count: self.m_))
		for j in 0..<self.m_ {
			res[j] = self.data_[j][i]
		}
		return(Vector(res))
	}
	
	var dim: (Int, Int) {
		return((self.m_, self.n_))
	}
	
	private static func assign(_ l: Matrix, _ r: Matrix, _ op: (Double, Double) -> Double) -> Matrix {
		precondition(l.dim == r.dim, Constants.mat_size_error)
		let res: Matrix = Matrix(m: l.dim.0, n: l.dim.1, v: 0.0)
		for i in 0..<l.dim.0 {
			for j in 0..<l.dim.1 {
				res[i, j] = op(l[i, j], r[i, j])
			}
		}
		return(res)
	}
	
	private static func assign(_ l: Matrix, _ r: Double, _ op: (Double, Double) -> Double) -> Matrix {
		let res: Matrix = Matrix(m: l.dim.0, n: l.dim.1, v: 0.0)
		for i in 0..<l.dim.0 {
			for j in 0..<l.dim.1 {
				res[i, j] = op(l[i, j], r)
			}
		}
		return(res)
	}
	
	private static func mat_vec_mult(_ l: Matrix, _ r: Vector) -> Vector {
		precondition(l.dim.1 == r.dim.0, Constants.mat_size_error)
		let res: Vector = Vector(n: l.dim.0, v: 0.0)
		for i in 0..<l.dim.0 {
			for j in 0..<l.dim.1 {
				res[i] += l[i, j] * r[j]
			}
		}
		return(res)
	}
	
	private static func mat_vec_mult(_ l: Vector, _ r: Matrix) -> Vector {
		precondition(l.dim.1 == r.dim.0, Constants.mat_size_error)
		let res: Vector = Vector(n: l.dim.1, v: 0.0, column: false)
		for i in 0..<r.dim.1 {
			for j in 0..<r.dim.0 {
				res[i] += l[j] * r[j, i]
			}
		}
		return(res)
	}
	
	private static func mat_mat_mult(_ l: Matrix, _ r: Matrix) -> Matrix {
		precondition(l.dim.1 == l.dim.0, Constants.mat_size_error)
		let res: Matrix = Matrix(m: l.dim.0, n: r.dim.1, v: 0.0)
		for i in 0..<res.dim.0 {
			for j in 0..<res.dim.1 {
				for k in 0..<l.dim.1 {
					res[i, j] += l[i, k] * r[k, j]
				}
			}
		}
		return(res)
	}
	
	static func *(l: Matrix, r: Vector) -> Vector {return(mat_vec_mult(l, r))}
	static func *(l: Vector, r: Matrix) -> Vector {return(mat_vec_mult(l, r))}
	static func *(l: Matrix, r: Matrix) -> Matrix {return(mat_mat_mult(l, r))}
	
	static prefix func -(m: Matrix) -> Matrix {return(assign(m, -1.0, *))}
	
	static func +(l: Matrix, r: Matrix) -> Matrix {return(assign(l, r, +))}
	static func -(l: Matrix, r: Matrix) -> Matrix {return(assign(l, r, -))}
	static func +(l: Matrix, r: Double) -> Matrix {return(assign(l, r, +))}
	static func -(l: Matrix, r: Double) -> Matrix {return(assign(l, r, -))}
	static func *(l: Matrix, r: Double) -> Matrix {return(assign(l, r, *))}
	static func /(l: Matrix, r: Double) -> Matrix {return(assign(l, r, /))}
	static func +(l: Double, r: Matrix) -> Matrix {return(assign(r, l, +))}
	static func *(l: Double, r: Matrix) -> Matrix {return(assign(r, l, *))}
	
	static func +=(l: inout Matrix, r: Matrix) {l = l + r}
	static func -=(l: inout Matrix, r: Matrix) {l = l - r}
	static func *=(l: inout Matrix, r: Matrix) {l = l * r}
	
}
