//
//  Architect.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

public struct Architect: Decodable, Identifiable, Hashable, Sendable {
    
    public init(
        id: Int,
        lastName: String,
        firstName: String,
        fullName: String
    ) {
        
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.fullName = fullName
    }
    
    public let id: Int
    public let lastName: String
    public let firstName: String
    public let fullName: String
}
