//
//  Feature.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import Foundation

public struct Feature: RawRepresentable {
    
    private var name: String
    
    public init(rawValue: String) {
        self.name = rawValue
    }
    
    public var rawValue: String {
        return self.name
    }
}

extension Feature: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
    }
}

extension Feature {
    static let addCategory = Feature(rawValue: "addCategory")
    static let addItem = Feature(rawValue: "addItem")
}
