//
//  File.swift
//  GetInShape
//
//  Created by Klaas Burmania on 09-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import Foundation
import UIKit

class ExcerciseItem: NSObject {
    var nameExcercise: String
    var excerciseImage: UIImage
    var category: ExcerciseGroup
    
    init(nameExcercise: String, excerciseImage: UIImage, category: ExcerciseGroup) {
        self.nameExcercise = nameExcercise
        self.excerciseImage = excerciseImage
        self.category = category
    }
}

enum ExcerciseGroup: String {
    case chest = "Borst"
    case shoulders = "Shouders"
    case back = "Rug"
    case bicep = "Bicep"
    case tricep = "Tricep"
    case legs = "Benen"
    case abs = "Buik"
    case all = "alles"
}
