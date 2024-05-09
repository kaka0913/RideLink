//
//  FrendInfoModel.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/24.
//

import Foundation


struct FriendInfoModel: Identifiable, Decodable {
    var id = UUID().uuidString
    let isOnline: Bool
    let profile: UserProfileModel
}

struct FriendResponse: Decodable {
    let friends: [FriendInfoModel]
}
