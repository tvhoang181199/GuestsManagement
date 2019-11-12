//
//  AdminViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 10/31/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class AdminViewController: UIViewController {

    @IBOutlet weak var createNewEventButton: UIButton!
    @IBOutlet weak var editCurrentEventButton: UIButton!
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewEventButton.layer.cornerRadius = 10
        editCurrentEventButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createEventButton(_ sender: Any) {
        let event = realm.objects(Event.self)
        if (event.count == 0){
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else {
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance)
            alert.addButton("OK") { () -> Void in
                try! self.realm.write {
                    self.realm.deleteAll()
                }
                let story = self.storyboard
                let vc = story?.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController

                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            alert.addButton("Cancel") { () -> Void in}
            alert.showWarning("Error", subTitle: "Creating new event will delete all the information from the previous or current event in the app")
        }
    }
    
    @IBAction func editEventButton(_ sender: Any) {
        let event = realm.objects(Event.self)
        if (event.count == 1){
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "CreateEventViewController") as! CreateEventViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else {
            SCLAlertView().showError("Error", subTitle: "You don't have any events to edit!!!")
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}
