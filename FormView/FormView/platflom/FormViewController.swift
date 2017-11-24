//
//  FormViewController.swift
//  FormView
//
//  Created by wangtie on 2017/11/10.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit
import ZLPhotoBrowser
let kFormViewDidEndEditingNotificationName = "kFormViewDidEndEditingNotificationName"
let kFormViewPopupSelectionNotificationName = "kFormViewPopupSelectionNotificationName"
let kFormViewCheckBoxNotificationName = "kFormViewCheckBoxNotificationName"
let kFormViewSearchNotificationName = "kFormViewSearchNotificationName"
let kFormViewUploadImageNotificationName = "kFormViewUploadImageNotificationName"
let kFormViewPreviewPhotosNotificationName = "kFormViewPreviewPhotosNotificationName"
class FormViewController: UIViewController {
    let formView = FormView()
    let dataSource = FormViewDataSource()
    let searchDataSource = FormSearchViewDataSource()
    
    lazy var datePickerView:SwiftDatePicker = {
        let screenBounds = UIScreen.main.bounds
        let view = SwiftDatePicker.init(frame: CGRect.init(x: 0, y: 0, width:screenBounds.width , height: screenBounds.height))
        view.finishBlock = { (dateStr) in
            if let result = dateStr {
               self.popupDateSelected(result)
            }
        }
        return view
    }()
    lazy var searchResultView: UITableView = {
        let screenSize = UIScreen.main.bounds.size
        let listView = UITableView.init(frame: CGRect(x:screenSize.width - 120 , y: 0, width: 110, height: 160), style: .plain)
        listView.delegate = self
        listView.dataSource = searchDataSource
        listView.register(UITableViewCell.self, forCellReuseIdentifier: kFormSearchResultViewCellId)
        listView.rowHeight = 40
        listView.tableFooterView = UIView()
        listView.layer.cornerRadius = 2.0
        listView.layer.borderWidth = 1.0
        listView.layer.borderColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        return listView
    }()
    var editIndex = 0
    private var selectedAssets = [Int:NSMutableArray]()
    func setUp(){
        formView.frame = self.view.bounds
        formView.delegate = self
        formView.dataSource = dataSource
        formView.separatorStyle = .none
        formView.estimatedRowHeight = 0
        formView.register(UINib(nibName: "FormTextFiledCell", bundle: nil), forCellReuseIdentifier: kFormTextFiledCellId)
        formView.register(UINib(nibName: "FormNoEditCell", bundle: nil), forCellReuseIdentifier: kFormNoEditCellId)
        formView.register(UINib(nibName: "FormTextViewCell", bundle: nil), forCellReuseIdentifier: kFormTextViewCellId)
        formView.register(UINib(nibName: "FormPopupSelectionCell", bundle: nil), forCellReuseIdentifier: kFormPopupSelectionCellId)
        formView.register(UINib(nibName: "FormTipsViewCell", bundle: nil), forCellReuseIdentifier: kFormTipsViewCellId)
        formView.register(UINib(nibName: "FormCheckBoxCell", bundle: nil), forCellReuseIdentifier: kFormCheckBoxCellId)
        formView.register(UINib(nibName: "FormSearchViewCell", bundle: nil), forCellReuseIdentifier: kFormSearchResultViewCellId)
        formView.register(UINib(nibName: "FormUploadImageCell", bundle: nil), forCellReuseIdentifier: kFormUploadImageCellId)
        formView.register(UINib(nibName: "FormTextFiledCheckButtonCell", bundle: nil), forCellReuseIdentifier: kFormTextFiledCheckButtonCellId)
        self.view.addSubview(formView)
//        registerFormViewNotification()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerFormViewNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFormViewNotification()
    }
    private func registerFormViewNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(formViewDidEndEditing(_:)), name: NSNotification.Name(rawValue: kFormViewDidEndEditingNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewPopupSelect(_:)), name: NSNotification.Name(rawValue: kFormViewPopupSelectionNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewCheckBoxUpdate(_:)), name: NSNotification.Name(rawValue: kFormViewCheckBoxNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewSearchUpdate(_:)), name: NSNotification.Name(rawValue: kFormViewSearchNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewUploadImage(_:)), name: NSNotification.Name(rawValue: kFormViewUploadImageNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(formViewPreviewPhotos(_:)), name: NSNotification.Name(rawValue: kFormViewPreviewPhotosNotificationName), object: nil)
    }
    private func removeFormViewNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func formViewDidEndEditing(_ notification:Notification){
        guard let info = notification.userInfo,
            let index:Int = info["index"] as? Int,
            let model = info["model"] as? FormModel else { return }
        editIndex = index
        model.value = info["text"] as? String ?? ""
        dataSource.dataSource[index] = model
//        print("didEndEditing \(String(describing: info["text"]))")
    }
    @objc func formViewPopupSelect(_ notification:Notification){
        guard let info = notification.userInfo,let index:Int = info["index"] as? Int else { return }
        
        editIndex = index
        let model = dataSource.dataSource[index]
        if model.cellType == .popupSelectionType { // 其他选择
            showFiltItemsView()
        }else if model.cellType == .popupSelectTimeType { // 时间选择
            datePickerView.show()
        }
        
    }
    @objc func formViewCheckBoxUpdate(_ notification:Notification) {
        guard let info = notification.userInfo,
            let index:Int = info["index"] as? Int,
            let model = info["model"] as? FormCheckBoxModel else { return }
        editIndex = index
        dataSource.dataSource[index] = model
    }
   
    
    
    
    func showFiltItemsView() {
        guard let model = dataSource.dataSource[editIndex] as? FormPopupSelectedModel else { return }
        guard let source = model.source else { return }
        
        let alertController = UIAlertController(title: "请选择", message: model.name, preferredStyle: .actionSheet)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        for filt in source {
            let alert = UIAlertAction(title: filt.name, style: .default, handler: { (action) in
                model.value = filt.name
                model.selectedId = filt.fid
                self.dataSource.dataSource[self.editIndex] = model
                let index = IndexPath(row: self.editIndex, section: 0)
                self.formView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
            })
            alertController.addAction(alert)
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    func popupDateSelected(_ result:String) {
        if let model:FormTimeModel = dataSource.dataSource[editIndex] as? FormTimeModel {
            let formate = DateFormatter()
            formate.dateFormat = "yyyy-MM-dd HH:mm"
            let newDate = formate.date(from: result)
            let timer = (newDate?.timeIntervalSince1970)! * 1000
            model.timeInterval = Int(timer)
            model.value = result
            dataSource.dataSource[editIndex] = model
            let index = IndexPath(row: editIndex, section: 0)
            formView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
        }
        
    }
    
    
}


// MARK: - Search
extension FormViewController {
    @objc func formViewSearchUpdate(_ notification:Notification) {
        guard let info = notification.userInfo,
            let index:Int = info["index"] as? Int,
            let text = info["text"] as? String else { return }
        editIndex = index
        let rectInTableView = formView.rectForRow(at: IndexPath(row: index, section: 0))
        //        let rectInSuperView = formView.convert(rectInTableView, to: self.view)
        let screenSize = UIScreen.main.bounds.size
        searchResultView.frame = CGRect(x: screenSize.width - 120, y: rectInTableView.origin.y + rectInTableView.size.height, width: 110, height: 160)
        if searchResultView.superview == nil{
            formView.addSubview(searchResultView)
            searchResultView.alpha = 0.0
        }
        searchTextUpdate(text)
    }
    
    /// 子类需要根据自身需求实现此方法来覆盖父类方法
    ///
    /// - Parameter text: 输入的文本
    public func searchTextUpdate(_ text:String){
        let filt = FiltItem(name: text, fid: 1)
        let filts = [filt]
        reloadSearchResultView(filts)
    }
    
    /// 子类可以根据自身需求实现此方法开覆盖父类方法
    ///
    /// - Parameter item: 选择的结果项
    public func searchResultSelected(_ item:FiltItem){
        if let model = dataSource.dataSource[editIndex] as? FormSearchTextModel {
            model.resultId = item.fid
            model.value = item.name
            dataSource.dataSource[editIndex] = model
            let index = IndexPath(row: editIndex, section: 0)
            formView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
        }
    }
    
    public func reloadSearchResultView(_ source:[FiltItem]) {
        if source.count == 0{
            searchResultView.alpha = 0.0
            searchResultView.removeFromSuperview()
        }else{
            searchResultView.alpha = 1.0
            searchDataSource.searchResult = source
            searchResultView.reloadData()
        }
        
    }
}

// MARK: - Upload Image
extension FormViewController {
    @objc func formViewUploadImage(_ notification:Notification) {
        guard let info = notification.userInfo,
            let index:Int = info["index"] as? Int else { return }
        editIndex = index
        addImage()
    }
    
    @objc func formViewPreviewPhotos(_ notification:Notification) {
        guard let info = notification.userInfo,
            let index:Int = info["index"] as? Int,
            let showIndex:Int = info["showIndex"] as? Int else { return }
        editIndex = index
        guard let model:FormUploadImageModel = dataSource.dataSource[editIndex] as? FormUploadImageModel else {return}
        previewPhotos(model.images, index: showIndex)
    }
    public func addImage(){
        guard let model:FormUploadImageModel = dataSource.dataSource[editIndex] as? FormUploadImageModel else {return}
        let actionSheet = ZLPhotoActionSheet()
        actionSheet.maxSelectCount = model.max
        actionSheet.allowEditImage = false
        actionSheet.allowSelectVideo = false
//        actionSheet.useSystemCamera = true
        actionSheet.sender = self
        actionSheet.showCaptureImageOnTakePhotoBtn = false
        if let sa = selectedAssets[editIndex] {
            actionSheet.arrSelectedAssets = sa
        }
        actionSheet.selectImageBlock = { [weak self](images: [UIImage]?, assets:[PHAsset], isOriginal:Bool) -> Void in
            self?.selectedAssets[self?.editIndex ?? 0] = NSMutableArray(array: assets)
        }
        actionSheet.showPreview(animated: true)
    }
    public func previewPhotos(_ photos:[String]?,index:Int){
        guard let ps = photos else { return}
        var urls = [URL]()
        for str in ps {
            if let url = URL(string:str) {
                urls.append(url)
            }
        }
        let actionSheet = ZLPhotoActionSheet()
        actionSheet.sender = self;
//        actionSheet.navBarColor = UIColor.white
//        actionSheet.navTitleColor = UIColor.black
        actionSheet.previewPhotos(urls, index: index, hideToolBar: true) { _ in
            
        }
        
    }
    
}

extension FormViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard tableView == formView else {
            return 40
        }
        let model = dataSource.dataSource[indexPath.row]
        switch model.cellType {
        case .noEditType: return 45
        case .textViewType: return 180
        case .tipsViewType:
            let str = model.name
            let screenSize = UIScreen.main.bounds.size
            let size = str.textSize(str, inSize: CGSize(width: screenSize.width - 20, height: 1000), textFont: UIFont.systemFont(ofSize: 13))
            return size.height + 33
        case .uploadImageType:
            if let uimodel:FormUploadImageModel = model as? FormUploadImageModel {
                let width = UIScreen.main.bounds.size.width
                let height:CGFloat = (width - 56.5)/4
                if let images = uimodel.images {
                    let row:Int = (images.count)/4 + 1
                    let rowsHeight:CGFloat = CGFloat(row) * height
                    let sepHeight:CGFloat = CGFloat(row - 1) * 1.5 + 10
                    let totalHeight:CGFloat = rowsHeight + sepHeight + 54.5
                    return totalHeight
                }else{
                    return height + 47
                }
            }
            return 60.0
        default: return 68.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView != formView else {
            return
        }
        searchResultView.removeFromSuperview()
        
    }
}


