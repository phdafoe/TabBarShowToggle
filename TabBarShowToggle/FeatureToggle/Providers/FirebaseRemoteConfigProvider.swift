//
//  FirebaseRemoteConfigProvider.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation
import Firebase

public struct FirebaseRemoteConfigProvider: FeatureToggleProviderProtocol {
    
    public func fetchFeatureToggles(_ completionHandler: @escaping ([FeatureToggle]?) -> Void) {
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch(withExpirationDuration: 0) { (status, error) -> Void in
            if (status == .success) {
                remoteConfig.activate { (resultBool, error) in
                    let keys = remoteConfig.allKeys(from: .remote)
                    let featureToggles = keys.map {
                        FeatureToggle(feature: Feature(rawValue: $0), enable: remoteConfig[$0].boolValue)
                    }
                    completionHandler(featureToggles)
                }
            } else {
                print(error.debugDescription)
            }
        }
        
    }
}
