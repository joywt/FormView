//
//  FromModel.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit



class FormModel {
    let name:String
    var value:String
    let required:Bool
    let cellType:FormCellType
    init(_ theName:String,_ theValue:String?,isRequired:Bool,theCellType:FormCellType) {
        name = theName
        if let v = theValue { value = v } else { value = "" }
        required = isRequired
        cellType = theCellType
    }
}

class FormUploadImageModel: FormModel {
    var images:[String]?
}




