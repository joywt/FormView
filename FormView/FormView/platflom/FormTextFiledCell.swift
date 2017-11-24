//
//  FormTextFiledCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/13.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormTextFiledCellId = "kFormTextFiledCellId"
class FormTextFiledCell: FormCell,UITextFieldDelegate {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signView: UILabel!
    @IBOutlet weak var titleView: FormLabel!
    @IBOutlet weak var valueView: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 2.0
        backView.layer.borderWidth = 1.0
        backView.layer.borderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        valueView.delegate = self
    }
    
    public override func reloadCell(_ model:FormModel,index:Int){
        super.reloadCell(model, index: index)
        titleView.required = model.required
        titleView.textWithEdit(editing: false, model.name)
        valueView.text = model.value
        valueView.keyboardType = model.keyboardType ?? .default
        model.value.isEmpty ? titleView.identityView() : titleView.transformView()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let m = cellModel else { return false}
        self.titleView.textWithEdit(editing: true, m.name)
        guard textField.text!.isEmpty else {return true}
        UIView.animate(withDuration: 0.2) {
            self.titleView.transformView()
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let m = cellModel else { return false}
        if textField.text!.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.titleView.identityView()
            }
        }
        self.titleView.textWithEdit(editing: false, m.name)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        assert(index >= 0, "Form cell index not >= 0")
        guard let text = textField.text else { return}
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewDidEndEditingNotificationName), object: nil, userInfo: ["text":text,"index":index])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

