//
//  Data.swift
//  Todoey
//
//  Created by Никита Гагаринов on 27/11/2018.
//  Copyright © 2018 nikita. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
