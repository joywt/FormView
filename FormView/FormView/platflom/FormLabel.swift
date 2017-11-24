//
//  FormLabel.swift
//  FormView
//
//  Created by wangtie on 2017/11/24.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit
protocol FormLabelAnimate {
    func transformView()
    func identityView()
}

class FormLabel: UILabel,FormLabelAnimate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var required:Bool = false
    func textWithEdit(editing:Bool, _ str:@autoclosure ()->(String)){
        let lstr = str()
        let require = required ? "* " : ""
        let mutAttStr = NSMutableAttributedString()
        let blue = UIColor(red: 0.0/255, green: 183.0/255, blue: 241.0/255, alpha: 1.0)
        let gray = UIColor(red: 146.0/255, green: 146.0/255, blue: 146.0/255, alpha: 1.0)
        let color = editing ? blue : gray
        let font = UIFont.systemFont(ofSize: 16)
        let rattStr = NSAttributedString(string: require, attributes: [NSAttributedStringKey.foregroundColor:UIColor.red,
                                                                       NSAttributedStringKey.font:font])
        let attStr =  NSAttributedString(string: lstr, attributes: [NSAttributedStringKey.foregroundColor:color,
                                                                    NSAttributedStringKey.font:font])
        mutAttStr.append(rattStr)
        mutAttStr.append(attStr)
        self.attributedText = mutAttStr
    }
    func transformView() {
        let t1 = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let width = self.frame.size.width * 0.1
        let y = self.frame.origin.y - 5
        let t2 =  CGAffineTransform(translationX: -width, y: -y)
        let t = t1.concatenating(t2)
        self.transform = t
    }
    func identityView() {
        self.transform = CGAffineTransform.identity
    }
}

