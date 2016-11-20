//
//  EmotionCollectionViewCell.swift
//  
//
//  Created by 叶炯 on 2016/11/19.
//
//

import UIKit

class EmotionCollectionViewCell: UICollectionViewCell {
    
    fileprivate lazy var emotionBtn: UIButton = UIButton()
    
    //MARK: - 定义属性
    var emoticon: Emoticon? {
    
        didSet {
            guard emoticon != nil else {
                return
            }
            // 1.设置emoticonBtn的内容
            emotionBtn.setImage(UIImage.init(contentsOfFile: emoticon?.pngPath ?? ""), for: UIControlState())
            emotionBtn.setTitle(emoticon?.emojiCode, for: UIControlState())
       
            // 2.设置删除按钮
            if (emoticon?.isRemove)! {
                emotionBtn.setImage(UIImage(named: "compose_emotion_delete"), for: UIControlState())
            }

        }
    }
    
    
    //MARK: - 重写构造函数
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}

//MARK: - 设置 UI界面内容
extension EmotionCollectionViewCell {

    fileprivate func setupUI() {
    
        contentView.addSubview(emotionBtn)
        emotionBtn.frame = contentView.bounds
        
        emotionBtn.isUserInteractionEnabled = false
        emotionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
