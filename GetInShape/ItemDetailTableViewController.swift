//
//  ItemDetailTableViewController.swift
//  GetInShape
//
//  Created by Klaas Burmania on 09-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import UIKit

protocol ItemDetailTableViewControllerDelegate: class {
    func itemDetailTableViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishAdding item: WorkoutItem)
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: WorkoutItem)
}

class ItemDetailTableViewController: UITableViewController, UITextFieldDelegate, ExcerciseViewDelegate {

    @IBOutlet weak var nameExcerciseLabel: UILabel!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var excerciseImageView: UIImageView!
    @IBOutlet weak var popOverButton: UIButton!
    @IBOutlet weak var setRepeatTextField: UITextField!
    @IBOutlet weak var setMainValueTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    weak var delegate: ItemDetailTableViewControllerDelegate?
    
    var workoutItem = WorkoutItem()
    var workoutItemToEdit = WorkoutItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(workoutItemToEdit.nameExercise)
        
        if workoutItemToEdit.nameExercise != "" {
            title = "Oefening bewerken"
            nameExcerciseLabel.text = workoutItemToEdit.nameExercise
            excerciseImageView.image = decodeImage(image: workoutItemToEdit.workoutImage)
            setRepeatTextField.text = workoutItemToEdit.setRepeatNumb
            setMainValueTextField.text = workoutItemToEdit.setMainNumb
            weightTextField.text = workoutItemToEdit.weight
            doneBarButton.isEnabled = true
            workoutItem = workoutItemToEdit
        }
        self.setTextFields()
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func done(_ sender: UIBarButtonItem) {
        workoutItemPrepareForReturn()
        if workoutItemToEdit.nameExercise != "" {
            delegate?.itemDetailTableViewController(self, didFinishEditing: workoutItem)
        } else {
            delegate?.itemDetailTableViewController(self, didFinishAdding: workoutItem)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.itemDetailTableViewControllerDidCancel(self)
    }
    
    func checkInputFields() {
        if setRepeatTextField.text != "" && setMainValueTextField.text != "" && weightTextField.text != "" && workoutItem.nameExercise != "" {
            doneBarButton.isEnabled = true
        }
    }
    
    func workoutItemPrepareForReturn() {
        workoutItem.set = setRepeatTextField.text! + " x " + setMainValueTextField.text!
        workoutItem.weight = weightTextField.text!
        workoutItem.setRepeatNumb = setRepeatTextField.text!
        workoutItem.setMainNumb = setMainValueTextField.text!
    }
    
    func encodeImage(image: UIImage) -> Data {
        let imageData: Data = UIImagePNGRepresentation(image)!
        return imageData
    }
    
    func decodeImage(image: Data) -> UIImage {
        let imageFromData = UIImage(data: image)
        return imageFromData!
    }
    
    // Delegate functions ExcercisesViewController
    func excerciseViewController(_ controller: ExcercisesViewController, didSelectExcercise item: ExcerciseItem) {
        workoutItem.nameExercise = item.nameExcercise
        workoutItem.workoutImage = encodeImage(image: item.excerciseImage)
        
        self.setWorkoutItemValues()
        //self.setButton()
        navigationController?.popViewController(animated: true)
        checkInputFields()
    }
    
    func excerciseViewControllerDidCancel(_ controller: ExcercisesViewController) {
        self.setWorkoutItemValues()
        navigationController?.popViewController(animated: true)
        checkInputFields()
    }
    
    func setTextFields() {
        setRepeatTextField.delegate = self
        setMainValueTextField.delegate = self
        weightTextField.delegate = self
    }
    
    func setWorkoutItemValues() {
        if workoutItem.nameExercise == "" {
            nameExcerciseLabel.text = "Selecteer oefening"
            excerciseImageView.image = #imageLiteral(resourceName: "image")
        } else {
            nameExcerciseLabel.text = workoutItem.nameExercise
            excerciseImageView.image = decodeImage(image: workoutItem.workoutImage)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! ExcercisesViewController
        controller.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            checkInputFields()
        }
        
        return true
    }

}
