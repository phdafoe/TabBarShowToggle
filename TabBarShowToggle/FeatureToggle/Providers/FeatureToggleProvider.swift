//
//  FeatureToggleProvider.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public protocol FeatureToggleProviderProtocol {
    func fetchFeatureToggles(_ completionHandler: @escaping ([FeatureToggle]?) -> Void)
}
