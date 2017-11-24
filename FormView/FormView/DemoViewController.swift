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
        FormModel("合同号", "BT8923474475", isRequired: true, theCellType: .noEditType),
        FormModel("客户姓名", "", isRequired: true, theCellType: .textFiledType),
        
//        FormSearchTextModel("搜索框", "", isRequired: true, theCellType: .searchViewType),
//        FormModel("地址", "ffadseedgate", isRequired: true, theCellType: .textFiledType),
//        FormModel("详细地址", "", isRequired: true, theCellType: .textViewType),
//        FormPopupSelectedModel("客户", "", isRequired: true, theCellType: .popupSelectionType),
//        FormTimeModel("创建时间", "", isRequired: true, theCellType: .popupSelectTimeType),
//        FormModel("提醒消息：学习下发发发个去去去日期日期惹人聪明的烦恼发if奶奶覅按发覅按覅你发个","",isRequired: true, theCellType: .tipsViewType),
//        FormCheckBoxModel("通知", "", isRequired: true, theCellType: .checkBoxType),
//        FormUploadImageModel("添加图片", "", isRequired: true, theCellType: .uploadImageType),
//        FormUploadImageModel("肿瘤图片", "", isRequired: true, theCellType: .uploadImageType),
//        FormModel("test3", "hello", isRequired: true, theCellType: .textFiledType),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let f6 = FormModel("手机号", "", isRequired: true, theCellType: .textFiledCheckButtonType)
        f6.keyboardType = UIKeyboardType.numberPad
        source.append(f6)
        let f1 = FormModel("微信号", "", isRequired: false, theCellType: .textFiledType)
        f1.keyboardType = UIKeyboardType.asciiCapable
        source.append(f1)
        let f2 =  FormModel("QQ号", "", isRequired: false, theCellType: .textFiledType)
        f2.keyboardType = UIKeyboardType.numberPad
        source.append(f2)
        source.append(FormModel("提醒消息：港澳台地区需要另支付邮费","",isRequired: true, theCellType: .tipsViewType))
        source.append(FormModel("详细地址", "", isRequired: true, theCellType: .textViewType))
        let f3 = FormCheckBoxModel("通知", "", isRequired: true, theCellType: .checkBoxType)
        f3.source = [
            FiltItem(name: " 邮件", fid: 1),
            FiltItem(name: " 短信", fid: 2),
        ]
        source.append(f3)
        let f4 = FormPopupSelectedModel("客户来源", "", isRequired: true, theCellType: .popupSelectionType)
        f4.source = [
            FiltItem(name: "线上", fid: 0),
            FiltItem(name: "线下", fid: 1),
        ]
        source.append(f4)
        source.append(FormTimeModel("创建时间", "", isRequired: true, theCellType: .popupSelectTimeType))
        let f5 = FormUploadImageModel("添加图片", "", isRequired: true, theCellType: .uploadImageType)
        f5.images = [
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1510889880&di=a3b7608cba1d27bbc9e306b43d3043c0&src=http://img6.lady8844.com/forum/month_1406/1406031425452891ffb384e131.jpg",
            "http://pic.962.net/up/2013-11/20131111660842038745.jpg",
            "https://www.thesun.co.uk/wp-content/uploads/2017/05/nintchdbpict000327373302-e1495923278521.jpg",
            "http://pic.962.net/up/2013-11/20131111660842025734.jpg",
            "http://pic.962.net/up/2013-11/20131111660842029339.jpg",
            "http://pic.962.net/up/2013-11/20131111660842034354.jpg",
        ]
        source.append(f5)
        
//        if let model = source[11] as? FormUploadImageModel {
//            model.images = [
//                "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1510889880&di=a3b7608cba1d27bbc9e306b43d3043c0&src=http://img6.lady8844.com/forum/month_1406/1406031425452891ffb384e131.jpg",
//                "http://pic.962.net/up/2013-11/20131111660842038745.jpg",
//                "https://www.thesun.co.uk/wp-content/uploads/2017/05/nintchdbpict000327373302-e1495923278521.jpg",
//                "http://pic.962.net/up/2013-11/20131111660842025734.jpg",
//                "http://pic.962.net/up/2013-11/20131111660842029339.jpg",
//                "http://pic.962.net/up/2013-11/20131111660842034354.jpg",
//            ]
//            source[11] = model
//        }
        
        
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
