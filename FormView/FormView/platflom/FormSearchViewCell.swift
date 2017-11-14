//
//  FormSearchViewCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/14.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

class FormSearchViewCell: FormCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var valueView: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultBackViewLayer(backView)
        valueView.addTarget(self, action: #selector(textChange(_ :)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        super.reloadCell(model, index: index)
        signView.text = model.required ? "＊" : ""
        titleView.text = model.name
        valueView.text = model.value
    }
    
    @objc func textChange(_ textField:UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewSearchNotificationName), object: nil, userInfo: ["index":index,"text":textField.text!])
    }
    
}


//// MARK: - UITextFieldDelegate
//extension FormSearchViewCell: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    }
//
//}

