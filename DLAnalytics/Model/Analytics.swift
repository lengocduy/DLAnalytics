//
//  Analytics.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

public enum Analytics {
    /// Allow Client to send an event via.
    public static func send(event: AnalyticsEvent) {
        AnalyticsManager.sharedInstance.send(event: event)
    }
}
