//
//  ChannelModel.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 18/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation

struct ChannelModel: Decodable {
    private(set) var _id: String!
    private(set) var name: String!
    private(set) var description: String!
    private(set) var __v: Int?
}
