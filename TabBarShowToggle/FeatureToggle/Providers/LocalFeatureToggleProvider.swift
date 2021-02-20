//
//  LocalFeatureToggleProvider.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public struct LocalFeatureToggleProvider: FeatureToggleProviderProtocol {
    public func fetchFeatureToggles(_ completionHandler: @escaping ([FeatureToggle]?) -> Void) {
        let configuration = LocalFeatureToggleProvider.loadConfiguration() ?? []
        completionHandler(configuration)
    }
}

extension LocalFeatureToggleProvider {
    static let jsonContainerName: String = "featureToggles"
    static let configurationName: String = "FeatureToggles"
    static let configurationType: String = "json"
    
    static func loadConfiguration() -> [FeatureToggle]? {
        guard let configurationDes = bundledConfigurationURL(),
              let data = try? Data(contentsOf: configurationDes) else { return nil }
        return parseConfiguration(data: data)
    }
    
    static func bundledConfigurationURL() -> URL? {
        return Bundle.main.url(forResource: configurationName, withExtension: configurationType)
    }
    
    static func parseConfiguration(data: Data) -> [FeatureToggle]? {
        return JSONParsingService().parse(data, containerName: jsonContainerName)
    }
}
