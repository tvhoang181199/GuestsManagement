//
//  AddGuestViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/7/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class AddGuestViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var guestsTextField: UITextField!
    @IBOutlet weak var tableTextField: UITextField!
    @IBOutlet weak var sectionTextField: UITextField!
    
    let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //url of Realm file in simulator device
        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButton(_ sender: Any) {
        if (firstNameTextField.text == "" || lastNameTextField.text == "" || guestsTextField.text == "" || tableTextField.text == "" || sectionTextField.text == "") {
            SCLAlertView().showError("Error", subTitle: "Please complete all information!!!")
        }
        else {
            let myGuest = Guest()
            
            myGuest.firstName = firstNameTextField.text
            myGuest.lastName = lastNameTextField.text
            myGuest.guests = guestsTextField.text
            myGuest.table = tableTextField.text
            myGuest.section = sectionTextField.text
        
            try! realm.write {
                realm.add(myGuest)
            }
            SCLAlertView().showSuccess("Success", subTitle: "Your guest has been ADDED!")
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            guestsTextField.text = ""
            tableTextField.text = ""
            sectionTextField.text = ""
        }
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToCreateEventView", sender: self)
    }
}
