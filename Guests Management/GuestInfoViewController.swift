//
//  GuestInfoViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift

class GuestInfoViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    var name: String = ""
    var tableNumber: String = ""
    var guests: String = ""
    var section: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = realm.objects(Event.self)
        nameLabel.text = name
        nameLabel.font = UIFont(name: event[0].font!, size: CGFloat((event[0].fontSize! as NSString).integerValue))
        nameLabel.textColor = event[0].fontColor!.StringToUIColor()
        tableNumberLabel.text = tableNumber
        guestsLabel.text = guests
        sectionLabel.text = section
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
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMainView", sender: self)
    }
}
