//
//  FeatureToggle.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public struct FeatureToggle {
    
    let feature: Feature
    let enable: Bool
    
}

extension FeatureToggle: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case feature
        case enable
    }
    
}
