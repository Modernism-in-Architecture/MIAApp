//
//  ArchitectDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

public struct ArchitectDetail: Hashable {
    
    public let id: Int
    public let lastName: String
    public let firstName: String
    public let fullName: String
    public let birthDay: String
    public let birthPlace: String
    public let birthCountry: String
    public let deathDay: String
    public let deathPlace: String
    public let deathCountry: String
    public let description: String
    public let relatedBuildings: [Building]
    public let attributedDescription: AttributedString
    public let birth: String
    public let death: String
    public let absoluteURL: URL
}
