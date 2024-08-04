//
//  FriendModel.swift
//  People
//
//  Created by Adam Elfsborg on 2024-08-04.
//

import Foundation

struct FriendModel: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
}
