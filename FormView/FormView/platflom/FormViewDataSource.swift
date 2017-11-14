//
//  FormViewDataSource.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

class FormViewDataSource: NSObject,UITableViewDataSource{
    
//    enum Section: Int{
//        case max = 1
//    }
    var dataSource = [FormModel]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        var identifier = ""
        switch model.cellType {
        case .textFiledType:
            identifier = kFormTextFiledCellId
        case .noEditType:
            identifier = kFormNoEditCellId
        case .textViewType:
            identifier = kFormTextViewCellId
        case .popupSelectionType,.popupSelectTimeType:
            identifier = kFormPopupSelectionCellId
        case .tipsViewType:
            identifier = kFormTipsViewCellId
        case .checkBoxType:
            identifier = kFormCheckBoxCellId
        case .searchViewType:
            identifier = kFormSearchResultViewCellId
        default:
            fatalError("类型未定义")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier , for: indexPath) as! FormCell
        cell.reloadCell(dataSource[indexPath.row],index: indexPath.row)
        cell.selectionStyle = .none
        return cell
        
    }
}
