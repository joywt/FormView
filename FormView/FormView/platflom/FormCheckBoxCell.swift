//
//  FormCheckBoxCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/14.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormCheckBoxCellId = "kFormCheckBoxCellId"

class FormCheckBoxCell: FormCell {

    @IBOutlet weak var title: FormLabel!
    @IBOutlet weak var valueView: UIStackView!
    @IBOutlet weak var backView: UIView!
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultBackViewLayer(backView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        super.reloadCell(model, index: index)
        title.required = model.required
        title.textWithEdit(editing: false, model.name)
        if let model = model as? FormCheckBoxModel {
            for view in valueView.arrangedSubviews{
                valueView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            guard let source = model.source  else { return}
            for item in source {
                let btn = CheckBoxButton(frame: CGRect(x: 0, y: 0, width: 88, height: 32))
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.setTitle(item.name, for: .normal)
                btn.tag = index + 1
                btn.isChecked = model.checkedIds.filter{$0 == item.fid}.count > 0 ? .On : .Off
                btn.addTarget(self, action: #selector(btnSelected(_ :)), for: .touchUpInside)
                valueView.addArrangedSubview(btn)
            }
        }
    }
    
    @objc func btnSelected(_ sender:CheckBoxButton) {
        sender.isChecked.toggle()
        if let model = cellModel {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewCheckBoxNotificationName), object: nil, userInfo: ["model":model,"index":index])
        }
    }
    
}
