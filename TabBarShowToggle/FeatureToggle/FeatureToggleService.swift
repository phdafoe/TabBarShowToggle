//
//  FeatureToggleService.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public final class FeatureToggleService {
    
    private init() {}
    static let shared = FeatureToggleService()
    private var featureToggles: [FeatureToggle] = []
    
    public func fetchFeatureToggles(mainProvider: FeatureToggleProviderProtocol,
                                    fallbackProvider: FeatureToggleProviderProtocol?,
                                    completionHandler: @escaping ([FeatureToggle]?) -> Void) {
        
        mainProvider.fetchFeatureToggles { [weak self] resultFeaturedToggle in
            guard let self = self else { return }
            if !(resultFeaturedToggle?.isEmpty ?? false) {
                if let resultFeaturedToggleDes = resultFeaturedToggle {
                    self.featureToggles = resultFeaturedToggleDes
                }
            } else if let fallbackProviderDes = fallbackProvider {
                self.useFallbackFeatureToggle(fallbackProviderDes)
            }
            
            completionHandler(self.featureToggles)
        }
    }
    
    private func useFallbackFeatureToggle(_ fallbackProvider: FeatureToggleProviderProtocol) {
        fallbackProvider.fetchFeatureToggles { [weak self] resultToggles in
            if let self = self {
                if let resultTogglesDes = resultToggles {
                    self.featureToggles = resultTogglesDes
                }
            }
        }
    }
    
    public func isEnable(_ feature: Feature) -> Bool {
        let featureEnable = self.featureToggles.first {
            $0.feature == feature
        }
        return featureEnable?.enable ?? false
    }
}
