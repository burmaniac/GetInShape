//
//  DataModel.swift
//  GetInShape
//
//  Created by Klaas Burmania on 18-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import Foundation

class DataModel {
    var workoutLists = [Workout]()
    
    init() {
        loadChecklists()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(
            "WorkoutItem.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(workoutLists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                workoutLists = try decoder.decode([Workout].self, from: data)
            } catch {
                print("Error decoding item array!")
            }
        }
    }
}
