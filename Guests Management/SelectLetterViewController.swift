//
//  SelectLetterViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit

class SelectLetterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func backToGuest(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
