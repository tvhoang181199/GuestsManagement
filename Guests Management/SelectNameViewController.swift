//
//  SelectNameViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift

class SelectNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let realm = try! Realm()
    var selectedLetter: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let event = realm.objects(Event.self)
//        titleLabel.font = UIFont(name: event[0].font!, size: 30)
//        titleLabel.textColor = event[0].fontColor!.StringToUIColor()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredGuestList = realm.objects(Guest.self).filter("lastName BEGINSWITH '\(selectedLetter)'")
        return filteredGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = realm.objects(Event.self)
        let filteredGuestList = realm.objects(Guest.self).filter("lastName BEGINSWITH '\(selectedLetter)'")
        let guest = filteredGuestList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "filteredGuestCell", for: indexPath)
        cell.textLabel?.text = "\(guest.lastName ?? "") \(guest.firstName ?? "")"
        cell.textLabel?.font = UIFont(name: event[0].font!, size: CGFloat((event[0].fontSize! as NSString).integerValue))
        cell.textLabel?.textColor = event[0].fontColor!.StringToUIColor()
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GuestInfoSegue" {
            guard let vc = segue.destination as? GuestInfoViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let filteredGuestList = realm.objects(Guest.self).filter("lastName BEGINSWITH '\(selectedLetter)'")
            let guest = filteredGuestList[indexPath.row]
            vc.lastName = "\(guest.lastName ?? "")"
            vc.firstName = "\(guest.firstName ?? "")"
            vc.tableNumber = guest.table!
            vc.guests = guest.guests!
            vc.guestSection = guest.section!
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMainView", sender: self)
    }
}
