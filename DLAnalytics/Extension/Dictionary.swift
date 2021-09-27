//
//  Dictionary.swift
//  DLAnalytics
//
//  Created by LeNgocDuy on 9/24/21.
//  Copyright © 2021 askbills. All rights reserved.
//

import Foundation

public extension Dictionary {
	mutating func merge(dict: [Key: Value]) {
		for (key, value) in dict {
			updateValue(value, forKey: key)
		}
	}
}
