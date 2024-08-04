//
//  UserModel.swift
//  People
//
//  Created by Adam Elfsborg on 2024-08-04.
//

import Foundation

struct UserModel: Identifiable, Codable, Hashable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let about: String
    let company: String
    let email: String
    let address: String
    let registered: Date
    let tags: [String]
    let friends: [FriendModel]
}
