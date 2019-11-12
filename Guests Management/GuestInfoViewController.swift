//
//  GuestInfoViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift

class GuestsSameTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    
    func setGuest(guest: Guest) {
        nameLabel.text = "\(guest.lastName ?? "") \(guest.firstName ?? "")"
        guestsLabel.text = guest.guests
    }
}

class GuestInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let guestSameTableList = realm.objects(Guest.self).filter("table = '\(tableNumber)'")
        return guestSameTableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guestSameTableList = realm.objects(Guest.self).filter("table = '\(tableNumber)'")
        let guest = guestSameTableList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestsSameTableCell", for: indexPath) as! GuestsSameTableCell
        cell.setGuest(guest: guest)
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    var firstName: String = ""
    var lastName: String = ""
    var tableNumber: String = ""
    var guests: String = ""
    var guestSection: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = realm.objects(Event.self)
        nameLabel.text = "\(lastName) \(firstName)"
        nameLabel.font = UIFont(name: event[0].font!, size: CGFloat((event[0].fontSize! as NSString).integerValue))
        nameLabel.textColor = event[0].fontColor!.StringToUIColor()
        tableNumberLabel.text = tableNumber
        guestsLabel.text = guests
        sectionLabel.text = guestSection
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
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
