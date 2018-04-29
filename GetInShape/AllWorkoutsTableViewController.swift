//
//  AllWorkoutsTableViewController.swift
//  GetInShape
//
//  Created by Klaas Burmania on 18-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import UIKit

class AllWorkoutsTableViewController: UITableViewController, WorkoutDetailViewControllerDelegate {

    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 248/255, green: 148/255, blue: 6/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkoutItems" {
            let controller = segue.destination as! WorkoutTableViewController
            controller.workout = sender as! Workout
        } else if segue.identifier == "addWorkout" {
            let controller = segue.destination as! WorkoutDetailTableViewController
            controller.delegate = self
        }
    }

    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.workoutLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        
        let workout = dataModel.workoutLists[indexPath.row]
        cell.textLabel?.text = workout.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = dataModel.workoutLists[indexPath.row]
        performSegue(withIdentifier: "showWorkoutItems", sender: workout)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.workoutLists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "WorkoutDetailTableViewController") as! WorkoutDetailTableViewController
        controller.delegate = self
        
        let workout = dataModel.workoutLists[indexPath.row]
        controller.workoutToEdit = workout
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func workoutDetailViewControllerDidCancel(_ controller: WorkoutDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func workoutDetailViewController(_ controller: WorkoutDetailTableViewController, didFinishAdding workoutList: Workout) {
        let newRowIndex = dataModel.workoutLists.count
        dataModel.workoutLists.append(workoutList)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func workoutDetailViewController(_ controller: WorkoutDetailTableViewController, didFinishEditing workoutList: Workout) {
        if let index = dataModel.workoutLists.index(of: workoutList) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = workoutList.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
