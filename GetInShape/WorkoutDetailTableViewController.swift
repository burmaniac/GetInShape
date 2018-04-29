//
//  WorkoutDetailTableViewController.swift
//  GetInShape
//
//  Created by Klaas Burmania on 18-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import UIKit

protocol WorkoutDetailViewControllerDelegate: class {
    func workoutDetailViewControllerDidCancel(_ controller: WorkoutDetailTableViewController)
    func workoutDetailViewController(_ controller: WorkoutDetailTableViewController, didFinishAdding workoutList: Workout)
    func workoutDetailViewController(_ controller: WorkoutDetailTableViewController, didFinishEditing workoutList: Workout)
}

class WorkoutDetailTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: WorkoutDetailViewControllerDelegate?
    
    var workoutToEdit: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        if let workout = workoutToEdit {
            title = "Oefening schema aanpassen"
            textField.text = workout.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let workout = workoutToEdit {
            workout.name = textField.text!
            delegate?.workoutDetailViewController(self, didFinishEditing: workout)
        } else {
            let workout = Workout(name: textField.text!)
            delegate?.workoutDetailViewController(self, didFinishAdding: workout)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.workoutDetailViewControllerDidCancel(self)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}


