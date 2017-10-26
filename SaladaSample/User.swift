//
//  User.swift
//  SaladaSample
//
//  Created by nori on 2017/10/26.
//  Copyright © 2017年 1amageek. All rights reserved.
//

import Foundation
import Salada

@objcMembers
class User: Object {

    dynamic var name: String?
    dynamic var items: Items = []
}
