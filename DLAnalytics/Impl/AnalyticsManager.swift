//
//  AnalyticsManager.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

// MARK: - AnalyticsManager
final class AnalyticsManager {
	
	static var sharedInstance = AnalyticsManager()
    
    private(set) var analyticsServices: [AnalyticsService] = []
    private let readWriteLock = ReadWriteLock(label: "DLAnalyticsLock")
	
	private var userProperty = [String: Any]()
    
    private init() {}
    
    /// Add an implementation of `AnalyticsService` to a list of registered handlers.
    ///
    /// - parameter service: An implementation of AnalyticsService.
    /// - returns: Void.
    func addAnalyticsService(_ service: AnalyticsService) {
        readWriteLock.write {
            analyticsServices.append(service)
        }
    }
	
	/// To support personalization better we need to add more general properties that share with all events
	func setCustomizedProperty(_ property: [String: Any]) {
		userProperty.merge(dict: property)
	}
}

// MARK: - CombineEvent
public struct CombineEvent: AnalyticsEvent {
	public var name: String
	public var payload: [String: Any]
}

// MARK: - AnalyticsService Implementation
extension AnalyticsManager: AnalyticsService {
	/// To support identify the user we need to help set these properties as global properties
	func setUserIdentifyProperty(_ property: [String: String]) {
		var services = [AnalyticsService]()
		readWriteLock.read {
			services = self.analyticsServices
		}
		
		services.forEach {
			$0.setUserIdentifyProperty(property)
		}
	}
	
	/// Reset all data related to the user e.g user logout
	func reset() {
		var services = [AnalyticsService]()
		readWriteLock.read {
			services = self.analyticsServices
		}
		
		services.forEach {
			$0.reset()
		}
	}
	
	/// Send an Event to Analytics service.
	/// This function will invoke all its childens to perform sending event.
	///
	/// - returns: Void
	func send(event: AnalyticsEvent) {
		var services = [AnalyticsService]()
		readWriteLock.read {
			services = self.analyticsServices
		}
		
		services.forEach {
			var combinedPayload = userProperty
			combinedPayload.merge(dict: event.payload)
			let combinedEvent = CombineEvent(name: event.name, payload: combinedPayload)
			$0.send(event: combinedEvent)
		}
	}
}
