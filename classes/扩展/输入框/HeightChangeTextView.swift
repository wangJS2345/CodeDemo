//
//  HeightChangeTextView.swift
//  CodeDemo
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 LYP. All rights reserved.
//

//输入框 ，高度根据输入内容自动计算变更
import UIKit

class HeightChangeTextView: UITextView,UITextViewDelegate {
    var maxHeight:CGFloat = 130 //定义最大高度
    
    override init(frame:CGRect, textContainer:NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        //textview的一些设置
        self.delegate = self
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth=0.5
        self.layer.cornerRadius=5
        self.layer.masksToBounds=true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
    }
    func textViewDidChange(_ textView: UITextView) {
        let frame = textView.frame    //定义一个constrainSize值用于计算textview的高度
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        //获取textview的真实高度
        var size = textView.sizeThatFits(constrainSize)
        //如果textview的高度大于最大高度高度就为最大高度并可以滚动，否则不能滚动
        if size.height>=maxHeight{
            size.height=maxHeight
            textView.isScrollEnabled=true
        }else{
            textView.isScrollEnabled=false
        }
        //重新设置textview的高度
        textView.frame.size.height=size.height
    }

}
