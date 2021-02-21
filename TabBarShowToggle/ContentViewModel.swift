//
//  ContentViewModel.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 21/02/2021.
//

import Foundation
import Combine


class ContentViewModel: ObservableObject {
    
    @Published var isEnableAddItem = false
    @Published var isEnableAddCategory = false
    
    private var didChange = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var featureToggleService: FeatureToggleService!
    
    init(featureToggleService: FeatureToggleService) {
        self.featureToggleService = featureToggleService
        self.showFeaturesEnables()
    }
    
    func showFeaturesEnables() {
        FeatureToggleService.shared.fetchFeatureToggles(mainProvider: FirebaseRemoteConfigProvider(),
                                                        fallbackProvider: LocalFeatureToggleProvider()) { _ in
            
            if self.featureToggleService.isEnable(.addItem) {
                DispatchQueue.main.async {
                    self.isEnableAddItem = true
                    self.didChange.send()
                }
            }
            
            if self.featureToggleService.isEnable(.addCategory) {
                DispatchQueue.main.async {
                    self.isEnableAddCategory = true
                    self.didChange.send()
                }
            }
            
        }
    }
}

