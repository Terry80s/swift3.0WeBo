//
//  PicCollectionView.swift
//  WeBo
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SDWebImage
let cellID = "cell"

class PicCollectionView: UICollectionView {

    //MARK:- 定义属性
    var picURL: [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    

    //MARK:- 系统的回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
       
        self.register(UINib.init(nibName: "PicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

//MARK:- collectionView的数据源方法
extension PicCollectionView: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.创建 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PicCollectionViewCell
     
        cell.picURL = picURL[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        DLog("Item 被点击了\(indexPath.item)")
        
        // 1.获取通知需要传递的参数
        let userInfo = [ShowPhotoBrowserIndexKey : indexPath, ShowPhotoBrowserUrlsKey : picURL] as [String : Any]
        
        // 2.发出通知
        NotificationCenter.default.post(name: Notification.Name(rawValue: ShowPhotoBrowserNote), object: self, userInfo: userInfo)
    }
    
}

extension PicCollectionView : AnimatorPresentedDelegate {
    func startRect(_ indexPath: IndexPath) -> CGRect {
        // 1.获取cell
        let cell = self.cellForItem(at: indexPath)!
        
        // 2.获取cell的frame
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow!)
        
        return startFrame
    }
    
    func endRect(_ indexPath: IndexPath) -> CGRect {
        // 1.获取该位置的image对象
        let picURL = self.picURL[indexPath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picURL.absoluteString)
        
        // 2.计算结束后的frame
        let w = UIScreen.main.bounds.width
        let h = w / (image?.size.width)! * (image?.size.height)!
        var y : CGFloat = 0
        if h > UIScreen.main.bounds.height {
            y = 0
        } else {
            y = (UIScreen.main.bounds.height - h) * 0.5
        }
        
        return CGRect(x: 0, y: y, width: w, height: h)
    }
    
    func imageView(_ indexPath: IndexPath) -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.获取该位置的image对象
        let picURL = self.picURL[indexPath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picURL.absoluteString)
        
        // 3.设置imageView的属性
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}
