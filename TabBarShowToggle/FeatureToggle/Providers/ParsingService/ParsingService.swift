//
//  ParsingService.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public protocol ParsingServiceProtocol {
    func parse(_ data: Data, containerName: String) -> [FeatureToggle]?
}

public struct JSONParsingService: ParsingServiceProtocol {
    
    public func parse(_ data: Data, containerName: String) -> [FeatureToggle]? {
        var toggleData = data
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
           let jsonContainerDes = json as? [String: Any],
           let featureTogglesDes = jsonContainerDes[containerName],
           let featureTogglesDataDes = try? JSONSerialization.data(withJSONObject: featureTogglesDes) {
            toggleData = featureTogglesDataDes
        }
        
        return try? JSONDecoder().decode([FeatureToggle].self, from: toggleData)
    }
}
