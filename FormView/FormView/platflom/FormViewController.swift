//
//  FormViewController.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormViewDidEndEditingNotificationName = "kFormViewDidEndEditingNotificationName"
let kFormViewPopupSelectionNotificationName = "kFormViewPopupSelectionNotificationName"
class FormViewController: UIViewController {
    let formView = FormView()
    let dataSource = FormViewDataSource()
    lazy var datePickerView:SwiftDatePicker = {
        let view = SwiftDatePicker.init(frame: CGRect.init(x: 0, y: 0, width: CGRect.screenWidth, height: CGRect.screenHight))
        view.finishBlock = { (dateStr) in
            if let result = dateStr {
                let formate = DateFormatter()
                formate.dateFormat = "yyyy-MM-dd HH:mm"
                let newDate = formate.date(from: result)
                self.popupDateSelected(newDate)
            }
        }
        return view
    }()
    
    
    func setUp(){
        formView.frame = self.view.bounds
        formView.delegate = self
        formView.dataSource = dataSource
        formView.separatorStyle = .none
        formView.register(UINib(nibName: "FormTextFiledCell", bundle: nil), forCellReuseIdentifier: kFormTextFiledCellId)
        formView.register(UINib(nibName: "FormNoEditCell", bundle: nil), forCellReuseIdentifier: kFormNoEditCellId)
        formView.register(UINib(nibName: "FormTextViewCell", bundle: nil), forCellReuseIdentifier: kFormTextViewCellId)
        formView.register(UINib(nibName: "FormPopupSelectionCell", bundle: nil), forCellReuseIdentifier: kFormPopupSelectionCellId)
        self.view.addSubview(formView)
        registerFormViewNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUp()
        // Do any additional setup after loading the view.
    }

    
    public func reloadFormView(_ data:[FormModel]){
        dataSource.dataSource = data
        formView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func registerFormViewNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(formViewDidEndEditing(_:)), name: NSNotification.Name(rawValue: kFormViewDidEndEditingNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewPopupSelect(_:)), name: NSNotification.Name(rawValue: kFormViewPopupSelectionNotificationName), object: nil)
       
    }
    private func removeFormViewNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func formViewDidEndEditing(_ notification:Notification){
        guard let info = notification.userInfo else { return }
        print("didEndEditing \(String(describing: info["text"]))")
    }
    @objc func formViewPopupSelect(_ notification:Notification){
        guard let info = notification.userInfo,let index:Int = info["index"] as? Int else { return }
        
        print("select ...\(index)")
        let model = dataSource.dataSource[index]
        if model.cellType == .popupSelectionType { // 其他选择
            
        }else if model.cellType == .popupSelectTimeType { // 时间选择
        }
        
    }
    
    func popupDateSelected(_ date:Date) {
        
    }
    
    deinit {
        removeFormViewNotification()
    }
}

extension FormViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource.dataSource[indexPath.row]
        switch model.cellType {
        case .noEditType: return 45
        case .textViewType: return 180
        default: return 60.0
        }
        
    }
}
