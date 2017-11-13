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
    @IBOutlet weak var titleView: UILabel!
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
        signView.text = model.required ? "＊" : ""
        titleView.text = model.name
        valueView.text = model.value
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
