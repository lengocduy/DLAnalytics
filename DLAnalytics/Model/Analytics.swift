//
//  Analytics.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

public enum Analytics {
	/// Register an imlementation of Analytics Services as consumer e.g MixPanel, Firebase, Instabug, etc..
	public static func registerAnalyticsService(_ service: AnalyticsService) {
		AnalyticsManager.sharedInstance.addAnalyticsService(service)
	}
	
    /// Allow Client to send an event via.
    public static func send(event: AnalyticsEvent) {
        AnalyticsManager.sharedInstance.send(event: event)
    }
	
	/// To support personalization better we need to add more general properties that share with all events
	public static func setCustomizedProperty(_ property: [String: Any]) {
		AnalyticsManager.sharedInstance.setCustomizedProperty(property)
	}
	
	/// To support identify the user we need to help set these properties as global properties
	public static func setUserIdentifyProperty(_ property: [String: String]) {
		AnalyticsManager.sharedInstance.setUserIdentifyProperty(property)
	}
	
	/// Reset all data related to the user e.g user logout
	public static func reset() {
		AnalyticsManager.sharedInstance.reset()
	}
	
	/// Support some cases want to track from or present some screens inside specific consumer (Analytics services)
	public static func send(event: AnalyticsEvent, from viewController: ViewController) {
		AnalyticsManager.sharedInstance.send(event: event, from: viewController)
	}
}
