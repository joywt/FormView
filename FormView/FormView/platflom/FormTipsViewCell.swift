//
//  FormTipsViewCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/14.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormTipsViewCellId = "kFormTipsViewCellId"
class FormTipsViewCell: FormCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tipsView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        tipsView.text = model.name
    }
}
