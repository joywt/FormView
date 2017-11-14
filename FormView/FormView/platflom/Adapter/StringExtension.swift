//
//  StringExtension.swift
//  mgcrm
//
//  Created by wangtie on 2017/11/6.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

extension String {
    
    func textSize(_ text:String, inSize size:CGSize, textFont font:UIFont) -> CGSize {
        return textSize(text, inSize: size, textFont: font, breakMode: .byWordWrapping)
    }
    func textSize(_ text:String, inSize size:CGSize, textFont font:UIFont, breakMode:NSLineBreakMode) -> CGSize {
        return textSize(text, inSize: size, textFont: font, breakMode: breakMode, alignment: .left)
    }
    func textSize(_ text:String, inSize size:CGSize, textFont font:UIFont, breakMode:NSLineBreakMode, alignment:NSTextAlignment) -> CGSize {
        let nt:NSString = text as NSString
        var contentSize = CGSize.zero
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = breakMode
        paragraphStyle.alignment = alignment
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle]
        contentSize = nt.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], attributes: attributes, context: nil).size
        return contentSize
    }
    
}
