//
//  vector.swift
//  Markov Chain
//
//  Created by Andrew Perry on 3/29/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

class Vector : Collection, CustomStringConvertible {
	
	private var data_: [Double]
	private var m_: Int
	private var n_: Int
	var startIndex: Int
	var endIndex: Int
	
	init() {
		self.data_ = [Double]()
		self.m_ = 0; self.n_ = 0
		self.startIndex = 0
		self.endIndex = self.data_.count
	}
	
	init(n: Int, v: Double, column: Bool = true) {
		self.data_ = [Double](repeatElement(v, count: n))
		self.startIndex = 0
		self.endIndex = self.data_.count
		if(column) {
			self.m_ = n
			self.n_ = 1
		} else {
			self.m_ = 1
			self.n_ = n
		}
	}
	
	init(_ vals: [Double], column: Bool = true) {
		self.data_ = vals
		self.startIndex = 0
		self.endIndex = self.data_.count
		if(column) {
			self.m_ = vals.count
			self.n_ = 1
		} else {
			self.m_ = 1
			self.n_ = vals.count
		}
	}

	
	subscript(i: Int) -> Double {
		get {
			precondition(i >= 0 && i < self.data_.count, Constants.index_error)
			return(self.data_[i])
		}
		set(newVal) {
			precondition(i >= 0 && i < self.data_.count, Constants.index_error)
			self.data_[i] = newVal
		}
	}
	
	func index(after i: Int) -> Int {
		precondition(i >= 0 && i < self.data_.count, Constants.index_error)
		return(i + 1)
	}
	
	var description: String {
		var res: String = "["
		for i in 0..<self.data_.count {
			if(i + 1 == self.data_.count) {
				res += "\(self.data_[i])"
			} else {
				res += "\(self.data_[i]), "
			}
		}
		res += "]"
		return(res)
	}
	
	var size: Int {
		return(self.data_.count)
	}
	
	var count: Int {
		return(self.size)
	}
	
	var dim: (Int, Int) {
		return((self.m_, self.n_))
	}
	
	var T: Vector {
		swap(&self.m_, &self.n_)
		return(self)
	}
	
	var column: Bool {
		if(self.m_ >= 1 && self.n_ == 1) {
			return(true)
		} else if(self.m_ == 1 && self.n_ >= 1) {
			return(false)
		} else {
			return(true)
		}
	}
	
	func transpose() -> Vector {
		return(Vector(self.data_, column: false))
	}
	
	static func ==(l: Vector, r: Vector) -> Bool {
		if(l.dim != r.dim) {return(false)}
		for (v1, v2) in zip(l, r) {
			if(v1 != v2) {return(false)}
		}
		return(true)
	}
	
	static func !=(l: Vector, r: Vector) -> Bool {
		return(!(l == r))
	}
	
	private static func assign(_ v1: Vector, _ v2: Vector, _ op: (Double, Double) -> Double) -> Vector {
		precondition(v1.dim == v2.dim, Constants.vec_size_error)
		let res: Vector = Vector(n: v1.count, v: 0.0)
		for i in 0..<res.count {
			res[i] = op(v1[i], v2[i])
		}
		return(res)
	}
	
	private static func assign(_ v: Vector, _ d: Double, _ op: (Double, Double) -> Double) -> Vector {
		let res: Vector = Vector(n: v.count, v: 0.0)
		for i in 0..<res.count {
			res[i] = op(v[i], d)
		}
		return(res)
	}
	
	var norm_1: Double {
		var res: Double = 0.0
		for v in self {
			res += abs(v)
		}
		return(res)
	}
	
	var norm_2: Double {
		var res: Double = 0.0
		for v in self {
			res += v * v
		}
		return(res)
	}
	
	var norm_inf: Double {
		let max = self.data_.max()!
		let min = self.data_.min()!
		return(abs(max) > abs(min) ? max : min)
	}
	
	static func dot(_ l: Vector, _ r: Vector) -> Double {
		precondition(l.size == r.size, Constants.vec_size_error)
		var res: Double = 0.0
		for (v1, v2) in zip(l, r) {
			res += v1 * v2
		}
		return(res)
	}
	
	func cross(_ r: Vector) -> Vector {
		precondition(self.size == 3 && r.size == 3, Constants.vec_size_error)
		let v1 = self.data_[1] * r[2] - self.data_[2] * r[1]
		let v2 = self.data_[2] * r[0] - self.data_[0] * r[2]
		let v3 = self.data_[0] * r[1] - self.data_[1] * r[0]
		return(Vector([v1, v2, v3]))
	}
	
	func angle_between_vec(_ r: Vector) -> Double {
		return(acos(self * r / (self.norm_2 * r.norm_2)))
	}
	
	static prefix func -(v: Vector) -> Vector {return(assign(v, -1.0, *))}
	
	static func +(l: Vector, r: Vector) -> Vector {return(assign(l, r, +))}
	static func -(l: Vector, r: Vector) -> Vector {return(assign(l, r, -))}
	static func *(l: Vector, r: Vector) -> Double {return(dot(l, r))}
	static func /(l: Vector, r: Vector) -> Vector {return(assign(l, r, /))}
	
	static func +(l: Vector, r: Double) -> Vector {return(assign(l, r, +))}
	static func -(l: Vector, r: Double) -> Vector {return(assign(l, r, -))}
	static func *(l: Vector, r: Double) -> Vector {return(assign(l, r, *))}
	static func /(l: Vector, r: Double) -> Vector {return(assign(l, r, /))}
	
	static func +(l: Double, r: Vector) -> Vector {return(assign(r, l, +))}
	static func *(l: Double, r: Vector) -> Vector {return(assign(r, l, *))}
	
	static func +=(l: inout Vector, r: Vector) {l = l + r}
	static func -=(l: inout Vector, r: Vector) {l = l - r}
	static func /=(l: inout Vector, r: Vector) {l = l / r}
	

}
