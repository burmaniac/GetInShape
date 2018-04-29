//
//  ViewController.swift
//  GetInShape
//
//  Created by Klaas Burmania on 05-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController, ItemDetailTableViewControllerDelegate {
    var workout: Workout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = workout.name
        
        navigationItem.largeTitleDisplayMode = .never
    }

    func encodeImage(image: UIImage) -> Data {
        let imageData: Data = UIImagePNGRepresentation(image)!
        return imageData
    }
    
    func decodeImage(image: Data) -> UIImage {
        let imageFromData = UIImage(data: image)
        return imageFromData!
    }
    
    func configureText(for cell: UITableViewCell, with item: WorkoutItem) {
        let nameExcercise = cell.viewWithTag(1000) as! UILabel
        nameExcercise.text = item.nameExercise
        
        let set = cell.viewWithTag(1001) as! UILabel
        set.text = item.set
        
        let weight = cell.viewWithTag(1002) as! UILabel
        weight.text = item.weight
    }
    
    func itemDetailTableViewControllerDidCancel(_ controller: ItemDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishAdding item: WorkoutItem) {
        let newRowIndex = workout.workoutItems.count
        workout.workoutItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: WorkoutItem) {
        if let index = workout.workoutItems.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWorkoutItem" {
            let controller = segue.destination as! ItemDetailTableViewController
            controller.delegate = self
        } else if segue.identifier == "EditWorkoutItem" {
            let controller = segue.destination as! ItemDetailTableViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.workoutItemToEdit = workout.workoutItems[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.workout.workoutItems[sourceIndexPath.row]
        workout.workoutItems.remove(at: sourceIndexPath.row)
        workout.workoutItems.insert(movedObject, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.workoutItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutItem", for: indexPath)
        
        let item = workout.workoutItems[indexPath.row]
        
        configureText(for: cell, with: item)
        
        let imageView = cell.viewWithTag(1004) as! UIImageView
        imageView.image = decodeImage(image: item.workoutImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
           performSegue(withIdentifier: "EditWorkoutItem", sender: cell)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        workout.workoutItems.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}

