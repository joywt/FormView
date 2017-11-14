//
//  FromModel.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit



struct FiltItem {
    var name:String
    var fid:Int
}

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


/// 时间选择 model
class FormTimeModel: FormModel {
    var timeInterval:Int = 1
}

/// 弹出视图选择 model
class FormPopupSelectedModel: FormModel {
    var selectedId:Int?
    var source:[FiltItem]?
}

/// 上传图片 model
class FormUploadImageModel: FormModel {
    var images:[String]?
}


/// 多选框
class FormCheckBoxModel: FormModel {
    var checkedIds = [Int]()
    var source:[FiltItem]?
}

class FormSearchTextModel: FormModel {
    var resultId:Int?
}

