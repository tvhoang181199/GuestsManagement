//
//  LoginViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/8/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

class LoginViewController: UIViewController {

    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let url = URL(string: "http://private-908781-loginapi63.apiary-mock.com/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let json: [String: Any] = ["login": "request"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictArray = responseJSON as? [String: Any] {
                for item in dictArray {
                    self.username = item.key
                    self.password = item.value as! String
                }
                DispatchQueue.main.async(execute: self.doLogin)
            }
        }

        task.resume()
    }
    
    func doLogin() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("OK") { () -> Void in
            let story = self.storyboard
            let vc = story?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        if (_username.text == username && _password.text == password) {
            alert.showSuccess("Success", subTitle: "Login successfully")
        }
        else {
            SCLAlertView().showError("Failed", subTitle: "Your username or password is invalid!!!")
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        _username.text = ""
        _password.text = ""
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
