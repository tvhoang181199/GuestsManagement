//
//  SelectLetterViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import RealmSwift

class SelectLetterViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedLetter: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let event = realm.objects(Event.self)
//        titleLabel.font = UIFont(name: event[0].font!, size: 30)
//        titleLabel.textColor = event[0].fontColor!.StringToUIColor()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedLetter = "A"
        case 1:
            selectedLetter = "B"
        case 2:
            selectedLetter = "C"
        case 3:
            selectedLetter = "D"
        case 4:
            selectedLetter = "E"
        case 5:
            selectedLetter = "F"
        case 6:
            selectedLetter = "G"
        case 7:
            selectedLetter = "H"
        case 8:
            selectedLetter = "I"
        case 9:
            selectedLetter = "J"
        case 10:
            selectedLetter = "K"
        case 11:
            selectedLetter = "L"
        case 12:
            selectedLetter = "M"
        case 13:
            selectedLetter = "N"
        case 14:
            selectedLetter = "O"
        case 15:
            selectedLetter = "P"
        case 16:
            selectedLetter = "Q"
        case 17:
            selectedLetter = "R"
        case 18:
            selectedLetter = "S"
        case 19:
            selectedLetter = "T"
        case 20:
            selectedLetter = "U"
        case 21:
            selectedLetter = "V"
        case 22:
            selectedLetter = "W"
        case 23:
            selectedLetter = "X"
        case 24:
            selectedLetter = "Y"
        case 25:
            selectedLetter = "Z"
        default:
            selectedLetter = ""
        }
        
        let story = self.storyboard
        let nextVC = story?.instantiateViewController(withIdentifier: "SelectNameViewController") as! SelectNameViewController
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.selectedLetter = selectedLetter
        self.present(nextVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func homeButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMainView", sender: self)
    }
    
}
