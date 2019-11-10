//
//  CreateNewEventViewController.swift
//  Guests Management
//
//  Created by Vũ Hoàng Trịnh on 11/7/19.
//  Copyright © 2019 Vũ Hoàng Trịnh. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ColorPickTip
import SCLAlertView

class GuestCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    func setGuest(guest: Guest) {
        nameLabel.text = "\(guest.firstName ?? "") \(guest.lastName ?? "")"
        guestsLabel.text = guest.guests
        tableLabel.text = guest.table
        sectionLabel.text = guest.section
    }
}

class CreateEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontColorLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    let realm = try! Realm()
    let tempInput = UITextField(frame:CGRect.zero)
    var selectedFont: String? = "Helvetica"
    var fontSize: Int? = 35
    var fontColor: String? = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).UIColorToString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
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
    
    @IBAction func changeFontButton(_ sender: Any) {
        let fontPicker = UIPickerView()
        fontPicker.delegate = self
        
        let tempInput = UITextField(frame:CGRect.zero)
        tempInput.inputView = fontPicker
        createToolbar(tempInput)
        self.view.addSubview(tempInput)
        tempInput.becomeFirstResponder()
    }
    
    func createToolbar(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CreateEventViewController.dissmissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        fontSizeSlider.minimumValue = 20
        fontSizeSlider.maximumValue = 50
        fontSizeSlider.isContinuous = true
        let slider = sender as! UISlider
        fontSize = Int(slider.value)
        fontSizeLabel.text = "\(fontSize!)"
    }
    
    @IBAction func changeColorButton(_ sender: Any) {
        let palette = ColorPalletes.hue10
        let options = ColorPickTip.Options()
               
        let colorPickTipVC = ColorPickTipController(palette: palette, options: options)
        colorPickTipVC.popoverPresentationController?.delegate = colorPickTipVC
        colorPickTipVC.popoverPresentationController?.sourceView = sender as? UIView
        colorPickTipVC.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(colorPickTipVC, animated: true, completion: nil)
        
        colorPickTipVC.selected = {
        color, index in
        //print("picked color: \(String(describing: color)), index: \(String(describing: index))")
        guard color != nil else {return}
        self.fontColor = color!.UIColorToString()
        self.fontColorLabel.backgroundColor = self.fontColor!.StringToUIColor()
       }
    }
    
    //    @IBAction func createColorPicker(_ sender: Any) {
//        colorPickerView = ColorPickerView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 150))
//        view.addSubview(colorPickerView)
//    }
    
    @IBAction func unwindToGuestView(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButton(_ sender: Any) {
        let event = realm.objects(Event.self)
        if (event.count == 0) {
            if (eventNameTextField.text == ""){
                SCLAlertView().showError("Error", subTitle: "Please enter your event name!!!")
            }
            else {
                let myEvent = Event()
                myEvent.name = eventNameTextField.text
                myEvent.font = selectedFont
                myEvent.fontSize = fontSize
                myEvent.fontColor = fontColor
                try! realm.write {
                    realm.add(myEvent)
                }
                SCLAlertView().showInfo("Success", subTitle: "Your event has been ADDED!")
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            if (eventNameTextField.text == ""){
                SCLAlertView().showError("Error", subTitle: "Please enter your event name!!!")
            }
            else {
                try! realm.write {
                    event[0].name = eventNameTextField.text
                    event[0].font = selectedFont
                    event[0].fontSize = fontSize
                    event[0].fontColor = fontColor
                }
                SCLAlertView().showInfo("Success", subTitle: "Your event has been UPDATED!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backtoAdmin(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
}

extension CreateEventViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIFont.familyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFont = UIFont.familyNames[row]
        fontLabel.text = selectedFont
    }
}

extension UIColor {
    func UIColorToString() -> String {
        let components = self.cgColor.components
        return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
    }
    
}

extension String {
    func StringToUIColor() -> UIColor {
        let componentsString = self.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                     green: CGFloat((components[1] as NSString).floatValue),
                      blue: CGFloat((components[2] as NSString).floatValue),
                     alpha: CGFloat((components[3] as NSString).floatValue))
    }
}
