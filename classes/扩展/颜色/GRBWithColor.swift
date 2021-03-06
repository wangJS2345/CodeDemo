
//
//  GRBWithColor.swift
//  CodeDemo
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

class GRBWithColor: UIColor {
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
