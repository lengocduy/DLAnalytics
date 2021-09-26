//
//  AnalyticsService.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

public protocol AnalyticsService {
	/// To support identify the user we need to help set these properties as global properties
	func setUserIdentifyProperty(_ property: [String: String])
	
	/// Reset all data related to the user e.g user logout
	func reset()
	
	/// Send an event to Analytics
    func send(event: AnalyticsEvent)
}
