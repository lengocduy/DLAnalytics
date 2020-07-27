//
//  ReadWriteLock.swift
//  DLAnalytics
//
//  Created by Duy Le Ngoc on 7/27/20.
//  Copyright © 2020 askbills. All rights reserved.
//

import Foundation

final class ReadWriteLock {
    let concurrentQueue: DispatchQueue
    typealias Completion = () -> Void
    
    /// Contructor
    ///
    /// - parameter label: A string to help identify this object.
    init(label: String) {
        concurrentQueue = DispatchQueue(label: label, attributes: .concurrent)
    }
    
    /// Perfrom Read
    ///
    /// - parameter completion: A closure to perform action synchronous
    /// - returns: Void
    func read(completion: Completion) {
        concurrentQueue.sync {
            completion()
        }
    }
    
    /// Perfrom Write
    ///
    /// - parameter completion: A closure to perform action synchronous block other event
    /// - returns: Void
    func write(completion: Completion) {
        concurrentQueue.sync(flags: .barrier) {
            completion()
        }
    }
    
}
