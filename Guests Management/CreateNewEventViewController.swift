//
//  CreateNewEventViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/7/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift
import IGColorPicker

class GuestCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    func setGuest(guest: Guest) {
        nameLabel.text = guest.firstName
        guestsLabel.text = guest.guests
        tableLabel.text = guest.table
        sectionLabel.text = guest.section
    }
}

class CreateEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = realm.objects(Guest.self)
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guestList = realm.objects(Guest.self)
        let guest = guestList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCell", for: indexPath) as! GuestCell
        
        cell.setGuest(guest: guest)
        return cell
    }
    
    var colorPickerView: ColorPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createColorPicker(_ sender: Any) {
        colorPickerView = ColorPickerView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 150))
        view.addSubview(colorPickerView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backtoAdmin(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
}
