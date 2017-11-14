//
//  SwiftDatePicker.swift
//  SwiftDatePicker
//
//  Created by wang tie on 2017/3/3.
//  Copyright © 2017年 360jk. All rights reserved.
//

import UIKit
import SwiftDate
class SwiftDatePicker: UIView,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate {

    static let MINYEAR = 1970
    static let MAXYEAR = 2050
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    enum  DateStyle {
        case styleYearMonthDayHourMinute
        case styleMonthDayHourMinute
        case styleYearMonthDay
        case styleMonthDay
        case styleHourMinute
    }
    
    var dateStyle: DateStyle = DateStyle.styleYearMonthDayHourMinute  {
        didSet{
            pickerView.reloadAllComponents()
        }
    }
    var themeColor = UIColor.init(red: 247/255, green: 137/255, blue: 51/255, alpha: 1.0)
    var yearSource = [String]()
    let monthSource = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var hourSource = [String]()
    var minuteSource = [String]()
    var yearIndex = 0 {
        didSet{
            yearLabel.text = yearSource[yearIndex]
        }
    }
    var monthIndex:Int = 0 {
        didSet{
            switch dateStyle {
            case .styleYearMonthDayHourMinute,.styleYearMonthDay: pickerView.reloadComponent(2)
            case .styleMonthDay: pickerView.reloadComponent(1)
            default: break
            }
            
        }
    }
    var dayIndex = 0
    var hourIndex = 0
    var minuteIndex = 0
    
    var swiftDatePicker:UIView!

    typealias FinishBlock = (_ date:String?) -> Void
    var finishBlock:FinishBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        swiftDatePicker = loadViewFromNib()
        swiftDatePicker.frame = CGRect.init(x: 10, y: frame.size.height, width: frame.size.width - 20, height: 325)
        swiftDatePicker.layer.cornerRadius = 5.0
        swiftDatePicker.layer.masksToBounds = true
        addSubview(swiftDatePicker)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        for i in 1970...2050{
            yearSource.append("\(i)")
        }
        
        for i in 0..<60{
            if i < 24 {
                hourSource.append("\(i)")
            }
            minuteSource.append("\(i)")
        }
        showCurrentTime()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3) { 
            self.remakeConstraints(bottom: -10)
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.layoutIfNeeded()
        }
    }
    
    @objc func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.remakeConstraints(bottom: 325)
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
            self.layoutIfNeeded()
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    @IBAction func save(_ sender: Any) {
        self.dismiss()
        var result = ""
        
        switch dateStyle {
        case .styleMonthDayHourMinute: result = "\(monthSource[monthIndex])-\(daySource[dayIndex]) \(hourSource[hourIndex]):\(minuteSource[minuteIndex])"
        case .styleYearMonthDayHourMinute: result = "\(yearSource[yearIndex])-\(monthSource[monthIndex])-\(daySource[dayIndex]) \(hourSource[hourIndex]):\(minuteSource[minuteIndex])"

        case .styleYearMonthDay:result = "\(yearSource[yearIndex])-\(monthSource[monthIndex])-\(daySource[dayIndex])"

        case .styleMonthDay:result = "\(monthSource[monthIndex])-\(daySource[dayIndex])"

        case .styleHourMinute:result = "\(hourSource[hourIndex]):\(minuteSource[minuteIndex])"
        }
        if let block = finishBlock {
            block(result)
        }
    }
    
    @IBAction func clear() {
        self.dismiss()
        if let block = finishBlock {
            block("")
        }
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if touchView.isDescendant(of: self.swiftDatePicker){
                return false
            }
        }
        return true
    }
    func loadViewFromNib()-> UIView {
        let className = type(of:self)
        let bundle = Bundle(for:className)
        let nib = UINib.init(nibName: "DatePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    func remakeConstraints(bottom:CGFloat) {
        swiftDatePicker.frame = CGRect(x: 10, y: frame.size.height + bottom - 325, width: frame.size.width - 20, height: 325)
    }

    func addLabelWithNames(nameArr:[String]) {
        print("self ...\(yearLabel)")
        for view in yearLabel.subviews {
            if view is UILabel{
                view.removeFromSuperview()
            }
        }
        
        var i = 0
        let pickWidth = self.pickerView.frame.size.width
        for name in nameArr {
            let cellWidth = pickWidth / CGFloat(nameArr.count)
            let x = cellWidth * CGFloat(i)
            let y = self.yearLabel.frame.size.height / 2 - 15
            let label = UILabel.init(frame: CGRect.init(x: x, y: y, width: cellWidth, height: 15))
            label.text =  name
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = self.themeColor
            self.yearLabel.addSubview(label)
            i = i + 1
        }
        
    }
    
    var dayNumber:Int {
        let month = monthSource[monthIndex]
        switch month {
        case "1","3","5","7","8","10","12": return 31
        case "4","6","9","11": return 30
        case "2": return runNian ? 29 : 28
        default:break
        }
        return 0
    }
    var daySource:[String] {
        var arr = [String]()
        for i in 1...dayNumber {
            arr.append("\(i)")
        }
        return arr
    }
    var runNian:Bool {
        if let year = Int(yearSource[yearIndex]){
            if year % 4 == 0 {
                if year % 100 == 0 {
                    if year % 400 == 0 {
                        return true
                    }else {
                        return false
                    }
                }else {
                    return false
                }
            }else {
                return false
            }
        }
        return false
    }
    
    
    func showCurrentTime() {
        let date = Date()
        yearIndex = date.year - SwiftDatePicker.MINYEAR
        monthIndex = date.month - 1
        dayIndex = date.day - 1
        hourIndex = date.hour
        minuteIndex = date.minute
        switch dateStyle {
        case .styleYearMonthDayHourMinute:
            pickerView.selectRow(yearIndex, inComponent: 0, animated: false)
            pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
            pickerView.selectRow(dayIndex, inComponent: 2, animated: false)
            pickerView.selectRow(hourIndex, inComponent: 3, animated: false)
            pickerView.selectRow(minuteIndex, inComponent: 4, animated: false)
            
        case .styleMonthDayHourMinute:
            pickerView.selectRow(monthIndex, inComponent: 0, animated: false)
            pickerView.selectRow(dayIndex, inComponent: 1, animated: false)
            pickerView.selectRow(hourIndex, inComponent: 2, animated: false)
            pickerView.selectRow(minuteIndex, inComponent: 3, animated: false)
        case .styleYearMonthDay:
            pickerView.selectRow(yearIndex, inComponent: 0, animated: false)
            pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
            pickerView.selectRow(dayIndex, inComponent: 2, animated: false)
        case .styleMonthDay:
            pickerView.selectRow(monthIndex, inComponent: 0, animated: false)
            pickerView.selectRow(dayIndex, inComponent: 1, animated: false)
        case .styleHourMinute:
            pickerView.selectRow(hourIndex, inComponent: 0, animated: false)
            pickerView.selectRow(minuteIndex, inComponent: 1, animated: false)
        }
        
        
    }
//#pragma mark - delegate & dataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch dateStyle {
        case .styleYearMonthDayHourMinute:
            self.addLabelWithNames(nameArr: ["年","月","日","时","分"])
            return 5
        case .styleMonthDayHourMinute:
            self.addLabelWithNames(nameArr: ["月","日","时","分"])
            return 4
        case .styleYearMonthDay:
            self.addLabelWithNames(nameArr: ["年","月","日"])
            return 3
        case .styleMonthDay:
            self.addLabelWithNames(nameArr: ["月","日"])
            return 2
        case .styleHourMinute:
            self.addLabelWithNames(nameArr: ["时","分"])
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numbersOfRows: [Int] {
            switch dateStyle {
            case .styleYearMonthDayHourMinute:return [yearSource.count,monthSource.count,dayNumber,hourSource.count,minuteSource.count]
            case .styleMonthDayHourMinute:return [monthSource.count,dayNumber,hourSource.count,minuteSource.count]
            case .styleYearMonthDay:return [yearSource.count,monthSource.count,dayNumber]
            case .styleMonthDay:return [monthSource.count,dayNumber]
            case .styleHourMinute:return [hourSource.count,minuteSource.count]
            }
        }
//        print("number \(numbersOfRows)")
        return numbersOfRows[component]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        var title:String {
            switch dateStyle {
            case .styleYearMonthDayHourMinute:
                switch component {
                case 0: return yearSource[row]
                case 1: return monthSource[row]
                case 2: return daySource[row]
                case 3: return hourSource[row]
                case 4: return minuteSource[row]
                default: break
                }
            case .styleMonthDayHourMinute:
                switch component {
                case 0: return monthSource[row]
                case 1: return daySource[row]
                case 2: return hourSource[row]
                case 3: return minuteSource[row]
                default: break
                }
            case .styleYearMonthDay:
                switch component {
                case 0: return yearSource[row]
                case 1: return monthSource[row]
                case 2: return daySource[row]
                default: break
                }
            case .styleMonthDay:
                switch component {
                case 0: return monthSource[row]
                case 1: return daySource[row]
                default: break
                }
            case .styleHourMinute:
                switch component {
                case 0: return hourSource[row]
                case 1: return minuteSource[row]
                default: break
                }
            }
            return ""

        }
//        print("title ...\(title)")
        label.text = title
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch dateStyle {
        case .styleYearMonthDayHourMinute:
            switch component {
            case 0: yearIndex = row
            case 1: monthIndex = row
            case 2: dayIndex = row
            case 3: hourIndex = row
            case 4: minuteIndex = row
            default: break
            }
            
        case .styleYearMonthDay:
            switch component {
            case 0: yearIndex = row
            case 1: monthIndex = row
            case 2: dayIndex = row
            default: break
            }

        case .styleMonthDay:
            switch component {
            case 0: monthIndex = row
            case 1: dayIndex = row
            default: break
            }
        case .styleMonthDayHourMinute:
            switch component {
            case 0: monthIndex = row
            case 1: dayIndex = row
            case 2: hourIndex = row
            case 3: minuteIndex = row
            default: break
            }
        case .styleHourMinute:
            switch component {
            case 0: hourIndex = row
            case 1: minuteIndex = row
            default: break
            }
        }
    }
    
}
