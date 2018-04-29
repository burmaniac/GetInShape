//
//  excercisesViewController.swift
//  GetInShape
//
//  Created by Klaas Burmania on 10-04-18.
//  Copyright © 2018 Klaas Burmania. All rights reserved.
//

import UIKit

protocol ExcerciseViewDelegate: class {
    func excerciseViewController(_ controller: ExcercisesViewController, didSelectExcercise item: ExcerciseItem)
    func excerciseViewControllerDidCancel(_ controller: ExcercisesViewController)
}

class ExcercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ExcerciseViewDelegate?
    
    var excerciseItemArray = [ExcerciseItem]()
    var currentExcerciseArray = [ExcerciseItem]()
    
    required init?(coder aDecoder: NSCoder) {
        // CHEST
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Bench press", excerciseImage: #imageLiteral(resourceName: "dumbbell"), category: .chest))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Incline bench press", excerciseImage: #imageLiteral(resourceName: "upper-chest-training"), category: .chest))
        
        // SHOULDERS
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Military press", excerciseImage: #imageLiteral(resourceName: "shoulderPress"), category: .shoulders))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Upright row", excerciseImage: #imageLiteral(resourceName: "upright-row"), category: .shoulders))
        
        // BACK
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Lat pull down", excerciseImage: #imageLiteral(resourceName: "latPullDown"), category: .back))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Deadlift", excerciseImage: #imageLiteral(resourceName: "deadlift"), category: .back))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Back extension", excerciseImage: #imageLiteral(resourceName: "leg"), category: .back))
        
        // BICEP
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "One arm bicep curl", excerciseImage: #imageLiteral(resourceName: "bicep"), category: .bicep))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Standing barbell curl", excerciseImage: #imageLiteral(resourceName: "weightBar"), category: .bicep))
        
        // TRICEP
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Tricep rope grip", excerciseImage: #imageLiteral(resourceName: "man-lifting-weights"), category: .tricep))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Tricep triangle grip", excerciseImage: #imageLiteral(resourceName: "tricep-bar"), category: .tricep))
        
        // LEGS
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Squat", excerciseImage: #imageLiteral(resourceName: "weightlifting"), category: .legs))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Leg curl", excerciseImage: #imageLiteral(resourceName: "legCurl"), category: .legs))
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Leg press", excerciseImage: #imageLiteral(resourceName: "leg-press"), category: .legs))
        
        // ABS
        excerciseItemArray.append(ExcerciseItem(nameExcercise: "Crunch", excerciseImage: #imageLiteral(resourceName: "abdominal-exercise"), category: .abs))
        
        currentExcerciseArray = excerciseItemArray
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        alterLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        delegate?.excerciseViewControllerDidCancel(self)
    }
    
    func alterLayout() {
        tableView.estimatedSectionHeaderHeight = 50
        tableView.tableHeaderView = UIView()
    }
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return ExcerciseItem.category == .chest }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .chest
            case 2:
                if searchText.isEmpty { return ExcerciseItem.category == .shoulders }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .shoulders
            case 3:
                if searchText.isEmpty { return ExcerciseItem.category == .back }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .back
            case 4:
                if searchText.isEmpty { return ExcerciseItem.category == .bicep }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .bicep
            case 5:
                if searchText.isEmpty { return ExcerciseItem.category == .tricep }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .tricep
            case 6:
                if searchText.isEmpty { return ExcerciseItem.category == .legs }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .legs
            case 7:
                if searchText.isEmpty { return ExcerciseItem.category == .abs }
                return ExcerciseItem.nameExcercise.lowercased().contains(searchText.lowercased()) &&
                    ExcerciseItem.category == .abs
            default:
                return false
            }
        })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0:
            currentExcerciseArray = excerciseItemArray
            navigationItem.title = "Alles"
        case 1:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.chest
            })
            navigationItem.title = "Borst"
        case 2:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.shoulders
            })
            navigationItem.title = "Schouders"
        case 3:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.back
            })
            navigationItem.title = "Rug"
        case 4:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.bicep
            })
            navigationItem.title = "Bicep"
        case 5:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.tricep
            })
            navigationItem.title = "Tricep"
        case 6:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.legs
            })
            navigationItem.title = "Benen"
        case 7:
            currentExcerciseArray = excerciseItemArray.filter({ ExcerciseItem -> Bool in
                ExcerciseItem.category == ExcerciseGroup.abs
            })
            navigationItem.title = "Buik"
        default:
            break
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }

    // search bar in section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentExcerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "excerciseNameCell", for: indexPath)
        let label = cell.viewWithTag(10) as! UILabel
        let image = cell.viewWithTag(11) as! UIImageView
        
        label.text = currentExcerciseArray[indexPath.row].nameExcercise
        image.image = currentExcerciseArray[indexPath.row].excerciseImage
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ExcerciseItem(nameExcercise: currentExcerciseArray[indexPath.row].nameExcercise, excerciseImage: currentExcerciseArray[indexPath.row].excerciseImage, category: currentExcerciseArray[indexPath.row].category)
        
        delegate?.excerciseViewController(self, didSelectExcercise: item)
    }

}
