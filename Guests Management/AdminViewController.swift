//
//  AdminViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 10/31/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet weak var createNewEventButton: UIButton!
    @IBOutlet weak var editCurrentEventButton: UIButton!
    
    
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

}
