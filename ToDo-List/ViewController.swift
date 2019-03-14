//
//  ViewController.swift
//  ToDo-List
//
//  Created by Александра Легостаева on 05/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var item: Item?
    
    @IBOutlet weak var nameItem: UITextField!
    @IBOutlet weak var dateItem: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePickerItem: UIDatePicker!
    
    
    @IBAction func choosingDateItem(_ sender: UITextField) {
        print("open date picker")
        datePickerItem.isHidden = false
        datePickerItem.datePickerMode = UIDatePicker.Mode.date
        
    }
    
    @IBAction func dateChangedPickerItem(_ sender: UIDatePicker) {
        
        print("set changed value in date field")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dateItem.text = dateFormatter.string(from: sender.date)
    }
    
    
    @IBAction func dateInstalled(_ sender: Any) {
        print("hide picker")
         datePickerItem.isHidden = true
    }
    
    static func tommorowDayToString () -> String {
        
        let tommorow = Date().addingTimeInterval(2)
        let tommorowDateFormatter = DateFormatter()
        
        tommorowDateFormatter.dateStyle = .medium
        
        return (tommorowDateFormatter.string(from: tommorow))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerItem.isHidden = true
        dateItem.text = ViewController.tommorowDayToString()
        
        if let item = item {
            nameItem.text = item.name
            dateItem.text = item.date
        }
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            let name = nameItem.text ?? ""
            let date = dateItem.text ?? "\(ViewController.tommorowDayToString())"
            item = Item(name: name, date: date)
        }
    }
    
    
    
}

