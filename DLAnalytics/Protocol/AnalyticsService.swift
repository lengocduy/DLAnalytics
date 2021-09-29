//
//  AnalyticsService.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
public typealias ViewController = UIViewController
#elseif os(macOS)
import AppKit
public typealias ViewController = NSViewController
#endif

public protocol AnalyticsService {
	/// Whitelist events handle by the service. Handle all events as default if it does not specify
	var allowEvents: Set<String> { get }
	
	/// To support identify the user we need to help set these properties as global properties
	func setUserIdentifyProperty(_ property: [String: String])
	
	/// Reset all data related to the user e.g user logout
	func reset()
	
	/// Send an event to Analytics
    func send(event: AnalyticsEvent)
	
	/// Send an event to Analytics from a ViewController
	func send(event: AnalyticsEvent, from viewController: ViewController)
}

public extension AnalyticsService {
	var allowEvents: Set<String> { Set<String>() }
	
	func send(event: AnalyticsEvent, from viewController: ViewController) {}
}
