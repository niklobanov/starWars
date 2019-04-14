//
//  ReachAbility.swift
//  starWars
//
//  Created by Никита on 15/04/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
import Reachability
import UIKit

fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver()
    func removeReachabilityObserver()
}

// Declaring default implementation of adding/removing observer
extension ReachabilityObserverDelegate {

    /** Subscribe on reachability changing */
    func addReachabilityObserver() {
        reachability = Reachability()

        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }

        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

