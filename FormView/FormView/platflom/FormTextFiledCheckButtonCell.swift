//
//  FormTextFiledCheckButtonCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/24.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormTextFiledCheckButtonCellId = "kFormTextFiledCheckButtonCellId"

class FormTextFiledCheckButtonCell: FormCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleView: FormLabel!
    @IBOutlet weak var valueView: UITextField!
    @IBOutlet weak var checkButton: CRNetworkButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultBackViewLayer(backView)
        valueView.delegate = self
        checkButton.alpha = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        super.reloadCell(model, index: index)
        titleView.required = model.required
        titleView.textWithEdit(editing: false, model.name)
        valueView.text = model.value
        valueView.keyboardType = model.keyboardType ?? .default
        model.value.isEmpty ? titleView.identityView() : titleView.transformView()
    }
    
    @IBAction func selectCheckButton(_ sender: CRNetworkButton) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            sender.stopAnimate()
            sender.isUserInteractionEnabled = false
        }
    }
    
}
extension FormTextFiledCheckButtonCell:UITextFieldDelegate {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.location < 11 else {
            return false
        }
        checkButton.alpha = CGFloat( Double(range.location) / 10.0)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
