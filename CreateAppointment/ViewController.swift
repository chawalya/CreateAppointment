//
//  ViewController.swift
//  CreateAppointment
//
//  Created by Chawalya Tantisevi on 19/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
  
    @IBOutlet var allDayView: UIView!
    @IBOutlet var event: UIView!
    @IBOutlet var eventTap: UIView!
    @IBOutlet var invite: UIView!
    @IBOutlet var location: UIView!
    @IBOutlet var des: UIView!

    @IBOutlet var saveBtn: UIButton!

    @IBOutlet var switchBtn: UISwitch!

    @IBOutlet var locationLabel: UILabel!

    @IBOutlet var fromTime: UITextField!
    @IBOutlet var toDate: UITextField!
    @IBOutlet var fromDate: UITextField!
    @IBOutlet var toTime: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var allDayDate: UITextField!

    let datePickerFrom = UIDatePicker()
    let datePickerTo = UIDatePicker()
    let datePickerAllDay = UIDatePicker()
    var border: CALayer!
    var passedValue = "SCB Head Office"
    var switchOpen = true
    let date = Date()
    let dateFormat = DateFormatter()
    let timeFormat = DateFormatter()
    
    var currentDate = ""
    
    @IBAction func switchAction(_ sender: Any) {
        if switchBtn.isOn {
            allDayView.isHidden = false
            switchOpen = true
        } else {
            allDayView.isHidden = true
            switchOpen = false
        }
    }

    @IBAction func saveAction(_ sender: Any) {
        showNormalAlert(message: "Success")
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stlye()
        showDatePicker()
        locationLabel.text = passedValue
        setValue()
       
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let value = UserDefaults.standard.object(forKey: "ti")
//    }
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(titleField.text, forKey: "title")
        UserDefaults.standard.set(descriptionTextField.text, forKey: "description")
        UserDefaults.standard.set(fromDate.text, forKey: "fromDate")
        UserDefaults.standard.set(toDate.text, forKey: "toDate")
        UserDefaults.standard.set(allDayDate.text, forKey: "allDay")
        UserDefaults.standard.set(toTime.text, forKey: "toTime")
        UserDefaults.standard.set(fromTime.text, forKey: "fromTime")
        UserDefaults.standard.set(switchOpen, forKey: "switch")

    }
    
    func setValue(){
        titleField.text = UserDefaults.standard.object(forKey: "title") as? String
        descriptionTextField.text = UserDefaults.standard.object(forKey: "description") as? String
        fromDate.text = UserDefaults.standard.object(forKey: "fromDate") as? String
        toDate.text = UserDefaults.standard.object(forKey: "toDate") as? String
        allDayDate.text = UserDefaults.standard.object(forKey: "allDay") as? String
        toTime.text = UserDefaults.standard.object(forKey: "toTime") as? String
        fromTime.text = UserDefaults.standard.object(forKey: "fromTime") as? String
//        switchOpen = (UserDefaults.standard.object(forKey: "switch") as? Bool)!
//        if switchOpen == false{
//            allDayView.isHidden = true
//            switchOpen = true
//        }
        
    }
    
   
    func stlye() {
        dateFormat.dateFormat = "MMM d, yyyy"
        timeFormat.timeStyle = DateFormatter.Style.short
        let day = dateFormat.string(from: date)
        let time = timeFormat.string(from: date)
        event.makeCircle(10)
        eventTap.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        invite.makeCircle(10)
        location.makeCircle(10)
        des.makeCircle(10)
        saveBtn.makeCircle(10)
        allDayView.makeCircle(10)
        bottomBorderTextField(textField: titleField)
        descriptionTextField.borderStyle = UITextField.BorderStyle.none
        allDayDate.attributedPlaceholder = NSAttributedString(string: day,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        fromDate.attributedPlaceholder = NSAttributedString(string: day,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        toDate.attributedPlaceholder = NSAttributedString(string: day,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        fromTime.attributedPlaceholder = NSAttributedString(string: time,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        toTime.attributedPlaceholder = NSAttributedString(string: time,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
    }

    func bottomBorderTextField(textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: titleField.frame.height - 1, width: titleField.frame.width - 1, height: 3.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        titleField.borderStyle = UITextField.BorderStyle.none
        titleField.layer.addSublayer(bottomLine)
    }

    func showDatePicker() {
        // Formate Date
        datePickerFrom.datePickerMode = .dateAndTime
        datePickerTo.datePickerMode = .dateAndTime
        datePickerAllDay.datePickerMode = .date

        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        allDayDate.inputAccessoryView = toolbar
        allDayDate.inputView = datePickerAllDay
        fromDate.inputAccessoryView = toolbar
        fromDate.inputView = datePickerFrom
        toDate.inputAccessoryView = toolbar
        toDate.inputView = datePickerTo
        fromTime.inputAccessoryView = toolbar
        fromTime.inputView = datePickerFrom
        toTime.inputAccessoryView = toolbar
        toTime.inputView = datePickerTo
        descriptionTextField.inputAccessoryView = toolbar
        titleField.inputAccessoryView = toolbar
    }

    func showNormalAlert(message: String) {
        let alertVc = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        present(alertVc, animated: true, completion: nil)
        alertVc.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    }

    @objc func donedatePicker() {
        dateFormat.dateFormat = "MMM d, yyyy"
        timeFormat.timeStyle = DateFormatter.Style.short
        fromDate.text = dateFormat.string(from: datePickerFrom.date)
        fromTime.text = timeFormat.string(from: datePickerFrom.date)
        toDate.text = dateFormat.string(from: datePickerTo.date)
        toTime.text = timeFormat.string(from: datePickerTo.date)
        allDayDate.text = dateFormat.string(from: datePickerAllDay.date)
        view.endEditing(true)
    }

    @objc func cancel() {
        view.endEditing(true)
    }
}

extension UIView {
    func makeCircle(_ radius: CGFloat? = nil) {
        if let r = radius {
            layer.cornerRadius = r
        } else {
            layer.cornerRadius = frame.width / 2
        }
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
