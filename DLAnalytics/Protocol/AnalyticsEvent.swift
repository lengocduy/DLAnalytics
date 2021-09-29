//
//  AnalyticsEvent.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

public protocol AnalyticsEvent {
	var type: String { get }
    var name: String { get }
    var payload: [String: Any] { get }
}

public extension AnalyticsEvent {
	var type: String { "\(Self.self)" }
}
