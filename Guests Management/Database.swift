//
//  DataTable.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Guest: Object {
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var guests: String?
    @objc dynamic var table: String?
    @objc dynamic var section: String?
}

class Event: Object {
    @objc dynamic var name: String?
    @objc dynamic var font: String?
    var fontSize: Int?
    @objc dynamic var fontColor: String?
}
