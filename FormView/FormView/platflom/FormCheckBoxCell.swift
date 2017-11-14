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

    @IBOutlet weak var sign: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var valueView: UIStackView!
    @IBOutlet weak var backView: UIView!
    
    var cbModel: FormCheckBoxModel?
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
        sign.text = model.required ? "＊" : ""
        title.text = model.name
        if let model = model as? FormCheckBoxModel {
            cbModel = model
            for view in valueView.arrangedSubviews{
                valueView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            guard let source = model.source  else { return}
            for item in source {
                let btn = CheckBoxButton(frame: CGRect(x: 0, y: 0, width: 88, height: 32))
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
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
        if let model = cbModel {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewCheckBoxNotificationName), object: nil, userInfo: ["model":model,"index":index])
        }
    }
    
}
