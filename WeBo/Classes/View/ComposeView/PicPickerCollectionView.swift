//
//  PicPickerCollectionView.swift
//  WeBo
//
//  Created by Apple on 16/11/14.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

private let picPickerCell = "picPickerCell"
private let edgeMargin: CGFloat = 15
class PicPickerCollectionView: UICollectionView {

    
  
   override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    
    //设置 layout
    let itemWH = (UIScreen.main.bounds.width - 4 * edgeMargin) / 3
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: itemWH, height: itemWH)
    layout.minimumLineSpacing = edgeMargin
    layout.minimumInteritemSpacing = edgeMargin
    
    //设置 collectionView 的属性
    register(UINib.init(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerCell)
    dataSource = self
    contentInset = UIEdgeInsetsMake(edgeMargin, edgeMargin, 0, edgeMargin)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PicPickerCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCell, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
}
