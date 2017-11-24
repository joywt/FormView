//
//  FormCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

protocol FormCellReload {
    func reloadCell(_ model:FormModel, index:Int)
}

enum FormCellType {
    /// 输入框输入类型
    case textFiledType
    /// 不可编辑类型
    case noEditType
    /// 文本输入类型
    case textViewType
    /// 弹框选择类型
    case popupSelectionType
    /// 弹出框选择时间类型
    case popupSelectTimeType
    /// 消息提醒类型
    case tipsViewType
    /// 多选框类型
    case checkBoxType
    /// 上传图片类型
    case uploadImageType
    /// 搜索填充类型
    case searchViewType
    /// 输入框 + 检索按钮
    case textFiledCheckButtonType
    
}



class FormCell: UITableViewCell,FormCellReload {
    var index = -1
    var cellModel:FormModel?
    
    /// 设置编辑框的圆角和 border 的样式
    public func defaultBackViewLayer(_ backView:UIView){
        backView.layer.cornerRadius = 2.0
        backView.layer.borderWidth = 1.0
        backView.layer.borderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0).cgColor
    }
    
    /// 记录当前 cell 的index
    /// 用于更新 cell 的值
    public func reloadCell(_ model:FormModel,index:Int){
        cellModel = model
        self.index = index
    }
}
