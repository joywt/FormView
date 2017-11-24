//
//  UploadImageCell.swift
//  FormView
//
//  Created by wangtie on 2017/11/16.
//  Copyright © 2017年 360haoyao. All rights reserved.
//

import UIKit
let kUploadImageCellId = "kUploadImageCellId"
class UploadImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reloadImageView(_ imageUrl: String, isShowClose: Bool) {
        closeBtn.isHidden = !isShowClose
        if let url = URL(string: imageUrl){
            imageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    @IBAction func removeCurrentImage(_ sender: Any) {
        
    }
    
}
