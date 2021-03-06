//
//  RadioAccessTech.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit
import CoreTelephony

public let RadioAccessTechnologyStateDidChange = NSNotification.Name("StateDidChange")

public class RadioAccessTechnology {
    public static let shared = RadioAccessTechnology()
    
    fileprivate let telephonyNetworkInfo = CTTelephonyNetworkInfo()
    fileprivate(set) var reachability: Reachability?
    public weak var delegate: RadioAccessTechnologyNotifierDelegate?
    
    fileprivate init() {
        defer {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(radioAccessTechnologyDidChange),
                name:.CTRadioAccessTechnologyDidChange,
                object: nil)
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged),
                name: ReachabilityChangedNotification,
                object: nil)
        }
        
        reachability = Reachability()
        try? reachability?.startNotifier()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public fileprivate(set) var currentState: State = .unknown {
        didSet {
            guard currentState != oldValue else {return}
            
            NotificationCenter.default.post(name: RadioAccessTechnologyStateDidChange, object: nil)
            delegate?.didChange(to: currentState)
        }
    }
    
    @objc fileprivate func radioAccessTechnologyDidChange() {
        reachabilityChanged()
    }
    
    @objc fileprivate func reachabilityChanged() {
        currentState = getCurrentStateByReachibility()
    }
    
    fileprivate var currentStateOnWWAN: State {
        guard let radioAccessTechnology = telephonyNetworkInfo.currentRadioAccessTechnology else {return .unknown}
        
        switch radioAccessTechnology {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x: return .edge
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD: return ._3G
        case CTRadioAccessTechnologyLTE: return .lte
        default: return .unknown
        }
    }
    
    fileprivate func getCurrentStateByReachibility() -> State {
        guard let status = reachability?.currentReachabilityStatus else {return .unknown}
        
        switch status {
        case .reachableViaWiFi: return .wifi
        case .reachableViaWWAN: return currentStateOnWWAN
        default: return .unknown
        }
    }
}

extension RadioAccessTechnology {
    public enum State: String {
        case unknown, wifi, lte, _3G, edge
    }
}

public protocol RadioAccessTechnologyNotifierDelegate: class {
    func didChange(to state: RadioAccessTechnology.State)
}

