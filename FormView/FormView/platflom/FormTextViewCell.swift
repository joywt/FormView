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
    @IBOutlet weak var signView: UILabel!
    @IBOutlet weak var titleView: UILabel!
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
        signView.text = model.required ? "＊" : ""
        titleView.text = model.name
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        assert(index >= 0, "Form cell index not >= 0")
        guard let text = textView.text else { return}
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewDidEndEditingNotificationName), object: nil, userInfo: ["text":text,"index":index])
    }
}
