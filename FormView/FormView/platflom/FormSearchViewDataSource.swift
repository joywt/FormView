//
//  FormSearchViewDataSource.swift
//  FormView
//
//  Created by wangtie on 2017/11/14.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormSearchResultViewCellId = "kFormSearchResultViewCellId"
class FormSearchViewDataSource: NSObject, UITableViewDataSource {
    var searchResult = [FiltItem]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kFormSearchResultViewCellId, for: indexPath)
        let item = searchResult[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}
