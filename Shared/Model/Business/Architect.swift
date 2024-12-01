//
//  Architect.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

struct Architect: Decodable, Identifiable, Hashable {
    
    let id: Int
    let lastName: String
    let firstName: String
    let fullName: String
}
