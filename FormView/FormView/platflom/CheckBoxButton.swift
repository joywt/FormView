//
//  CheckBoxButton.swift
//  mgcrm
//
//  Created by wangtie on 2017/3/22.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {

    var isChecked: OnOffSwitch = .Off {
        didSet {
            if self.isChecked == .On {
                self.setImage(UIImage(named:"checkboxChecked"), for: .normal)
            }else {
                self.setImage(UIImage(named:"checkbox"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named:"checkbox"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
