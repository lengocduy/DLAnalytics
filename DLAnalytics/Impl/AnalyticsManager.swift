//
//  AnalyticsManager.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

// MARK: - Open Class
public final class AnalyticsManager: AnalyticsService {
    public static let sharedInstance = AnalyticsManager()
    
    private(set) var analyticsServices: [AnalyticsService] = []
    private let readWriteLock = ReadWriteLock(label: "DLAnalyticsLock")
    
    private init() {}
    
    /// Add an implementation of `AnalyticsService` to a list of registered handlers.
    ///
    /// - parameter service: An implementation of AnalyticsService.
    /// - returns: Void.
    public func addAnalyticsService(_ service: AnalyticsService) {
        readWriteLock.write {
            analyticsServices.append(service)
        }
    }
    
    /// Send an Event to Analytics service.
    /// This function will invoke all its childens to perform sending event.
    ///
    /// - returns: Void
    public func send(event: AnalyticsEvent) {
        var services = [AnalyticsService]()
        readWriteLock.read {
            services = self.analyticsServices
        }
        
        services.forEach { $0.send(event: event) }
    }
}
