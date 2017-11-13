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
        FormModel("地址", "ffadseedgate", isRequired: true, theCellType: .textFiledType),
        FormModel("详细地址", "", isRequired: true, theCellType: .textViewType),
        FormModel("客户", "", isRequired: true, theCellType: .popupSelectionType),
        FormModel("创建时间", "", isRequired: true, theCellType: .popupSelectTimeType),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
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
