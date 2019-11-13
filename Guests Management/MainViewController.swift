//
//  ViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 10/31/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class MainViewController: UIViewController {
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guestButton(_ sender: Any) {
        let event = realm.objects(Event.self)
        let guests = realm.objects(Guest.self)
        if (guests.count == 0 || event.count == 0){
            SCLAlertView().showError("Error", subTitle: "You don't have any information about guests!!!")
        }
        else {
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "GuestViewController") as! GuestViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    
    
    @IBAction func unwindToMainView(segue:UIStoryboardSegue) {
    }
}

