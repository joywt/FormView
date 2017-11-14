//
//  DemoViewController.swift
//  FormView
//
//  Created by wangtie on 2017/11/13.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

class DemoViewController: FormViewController {

    var source = [
        FormModel("test1", "hello", isRequired: true, theCellType: .textFiledType),
        FormModel("test2", "", isRequired: false, theCellType: .textFiledType),
        FormModel("哈哈哈发哈合法", "", isRequired: true, theCellType: .textFiledType),
        FormModel("合同号", "BT8923474475", isRequired: true, theCellType: .noEditType),
        FormSearchTextModel("搜索框", "", isRequired: true, theCellType: .searchViewType),
        FormModel("地址", "ffadseedgate", isRequired: true, theCellType: .textFiledType),
        FormModel("详细地址", "", isRequired: true, theCellType: .textViewType),
        FormPopupSelectedModel("客户", "", isRequired: true, theCellType: .popupSelectionType),
        FormTimeModel("创建时间", "", isRequired: true, theCellType: .popupSelectTimeType),
        FormModel("提醒消息：学习下发发发个去去去日期日期惹人聪明的烦恼发if奶奶覅按发覅按覅你发个","",isRequired: true, theCellType: .tipsViewType),
        FormCheckBoxModel("通知", "", isRequired: true, theCellType: .checkBoxType),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        if let model = source[7] as? FormPopupSelectedModel {
            model.source = [
                FiltItem(name: "客户1", fid: 0),
                FiltItem(name: "客户2", fid: 1),
                FiltItem(name: "客户3", fid: 2),
                FiltItem(name: "客户4", fid: 3)
            ]
            source[7] = model
        }
        
        if let model = source[10] as? FormCheckBoxModel {
            model.source = [
                FiltItem(name: "邮件", fid: 1),
                FiltItem(name: "短信", fid: 2),
            ]
            source[10] = model
        }
        
        reloadFormView(source)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addItem() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
