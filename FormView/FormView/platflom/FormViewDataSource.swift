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
//            let cell = tableView.dequeueReusableCell(withIdentifier:kFormTextFiledCellId , for: indexPath) as! FormTextFiledCell
//            cell.reloadCell(dataSource[indexPath.row],index: indexPath.row)
//            return cell
        case .noEditType:
            identifier = kFormNoEditCellId
//            let cell = tableView.dequeueReusableCell(withIdentifier:kFormNoEditCellId , for: indexPath) as! FormNoEditCell
//            cell.reloadCell(dataSource[indexPath.row],index: indexPath.row)
//            return cell
        case .textViewType:
            identifier = kFormTextViewCellId
//            let cell = tableView.dequeueReusableCell(withIdentifier:kFormTextViewCellId , for: indexPath) as! FormTextViewCell
//            cell.reloadCell(dataSource[indexPath.row],index: indexPath.row)
//            return cell
        case .popupSelectionType,.popupSelectTimeType:
            identifier = kFormPopupSelectionCellId
           
        default:
            fatalError("类型未定义")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier , for: indexPath) as! FormCell
        cell.reloadCell(dataSource[indexPath.row],index: indexPath.row)
        return cell
        
    }
}
