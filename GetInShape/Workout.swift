//
//  Workout.swift
//  GetInShape
//
//  Created by Klaas Burmania on 18-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import Foundation
import UIKit

class Workout: NSObject, Codable {
    var name = ""
    var workoutItems = [WorkoutItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
