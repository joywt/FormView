//
//  FormPopupSelectionCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/13.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormPopupSelectionCellId = "kFormPopupSelectionCellId"
class FormPopupSelectionCell: FormCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var valueView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultBackViewLayer(backView)
        // Initialization code
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
    
    @IBAction func selectCell(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewPopupSelectionNotificationName), object: nil, userInfo: ["index":index])
    }
}
