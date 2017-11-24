//
//  FormUploadImageCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/16.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit

let kFormUploadImageCellId = "kFormUploadImageCellId"
class FormUploadImageCell: FormCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var valueView: UICollectionView!
    var valueSource = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let width = UIScreen.main.bounds.size.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (width - 56.5)/4.0, height: (width - 56.5)/4.0)
        layout.minimumLineSpacing = 1.5
        layout.minimumInteritemSpacing = 1.5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        valueView.collectionViewLayout = layout
        valueView.backgroundColor = UIColor.white
        valueView.delegate = self
        valueView.dataSource = self
        valueView.register(UINib(nibName: "UploadImageCell", bundle: nil), forCellWithReuseIdentifier: kUploadImageCellId)
        defaultBackViewLayer(valueView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func reloadCell(_ model: FormModel, index: Int) {
        super.reloadCell(model, index: index)
        titleView.text = model.name
        if let m = model as? FormUploadImageModel {
            valueSource = m.images ?? []
        }
        valueView.reloadData()
    }
}

extension FormUploadImageCell:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == valueSource.count {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewUploadImageNotificationName), object: nil, userInfo: ["index":index])
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFormViewPreviewPhotosNotificationName), object: nil, userInfo: ["index":index,"showIndex":indexPath.row])
        }
    }
}

extension FormUploadImageCell:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return valueSource.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kUploadImageCellId, for: indexPath) as! UploadImageCell
        if indexPath.row == valueSource.count {
            cell.imageView.image = UIImage(named: "uploadAdd")
            cell.closeBtn.isHidden = true
        }else{
            cell.reloadImageView(valueSource[indexPath.row], isShowClose: true)
        }
        return cell
    }
}
