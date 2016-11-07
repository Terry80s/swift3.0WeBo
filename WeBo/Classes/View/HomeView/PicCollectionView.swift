//
//  PicCollectionView.swift
//  WeBo
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
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
     
        cell.picURL = picURL[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        DLog("Item 被点击了\(indexPath.item)")
    }
    
}
