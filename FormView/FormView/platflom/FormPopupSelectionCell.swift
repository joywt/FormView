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
    @IBOutlet weak var titleView: FormLabel!
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
        titleView.required = model.required
        titleView.textWithEdit(editing: false, model.name)
        valueView.text = model.value
//        model.value.isEmpty ? titleView.identityView() : titleView.transformView()
        
    }
    
    @IBAction func selectCell(_ sender: UIButton) {
        guard let m = cellModel else { return}
        self.titleView.textWithEdit(editing: true, m.name)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewPopupSelectionNotificationName), object: nil, userInfo: ["index":index])
//        guard m.value.isEmpty else {return}
//        UIView.animate(withDuration: 0.2) {
//            self.titleView.transformView()
//        }
        
    }
}
