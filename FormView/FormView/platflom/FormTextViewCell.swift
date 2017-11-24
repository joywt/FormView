//
//  FormTextViewCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/13.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormTextViewCellId = "kFormTextViewCellId"
class FormTextViewCell: FormCell,UITextViewDelegate {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleView: FormLabel!
    @IBOutlet weak var remarkView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultBackViewLayer(backView)
        remarkView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        super.reloadCell(model, index: index)
        titleView.required = model.required
        titleView.textWithEdit(editing: false, model.name)
        remarkView.text = model.value
        remarkView.keyboardType = model.keyboardType ?? .default
        model.value.isEmpty ? titleView.identityView() : titleView.transformView()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        guard let m = cellModel else { return false}
        self.titleView.textWithEdit(editing: true, m.name)
        guard textView.text!.isEmpty else {return true}
        UIView.animate(withDuration: 0.2) {
            self.titleView.transformView()
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        guard let m = cellModel else { return false}
        if textView.text!.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.titleView.identityView()
            }
        }
        self.titleView.textWithEdit(editing: false, m.name)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        assert(index >= 0, "Form cell index not >= 0")
        guard let text = textView.text else { return}
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewDidEndEditingNotificationName), object: nil, userInfo: ["text":text,"index":index])
    }
}


