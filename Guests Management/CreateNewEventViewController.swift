//
//  CreateNewEventViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/7/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import UIKit
import IGColorPicker

class CreateEventViewController: UIViewController {
    var colorPickerView: ColorPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
