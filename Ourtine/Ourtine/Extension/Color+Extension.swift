//
//  Color_Extension.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit


/// 컬러 팔레트입니다. 피그마 참고
extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
            var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
            if hexFormatted.hasPrefix("#") {
                hexFormatted = String(hexFormatted.dropFirst())
            }
            
            assert(hexFormatted.count == 6, "Invalid hex code used.")
            
            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: alpha)
    }
    
    /// UIColor : OrangeRed : 오렌지색
    static var app_PrimaryColor = UIColor(hexCode: "#FF4F17")
    
    /// UIColor: Pomegranate : 김치찜색
    static var app_PrimaryColor2 = UIColor(hexCode: "#E44615")
    
    /// UIColor : salmon : 스킨(살)색
    static var app_SecondaryColor = UIColor(hexCode: "#FFDECC")
    
    /// UIColor : Atomic tangerine : 연주황(귤)색
    static var app_SecondaryColor2 = UIColor(hexCode: "#FF9D66")
    
    /// UIColor : cloud : 구름(회)색
    static var app_TertiaryColor = UIColor(hexCode: "#F0F0F0")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor0 = UIColor(hexCode: "#FFFFFF")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor10 = UIColor(hexCode: "#E5E5E5")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor20 = UIColor(hexCode: "#CCCCCC")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor40 = UIColor(hexCode: "#999999")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor60 = UIColor(hexCode: "#666666")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor80 = UIColor(hexCode: "#333333")
    
    /// UIColor : Brightness : 명도(역순)
    static var app_BrightnessColor100 = UIColor(hexCode: "#000000")
    
    
    
    /// UI First Color : White
    static var app_UIColor1: UIColor {
        let color = UIColor.white
        return color
    }
    
    /// UI Second Color? : Black
    static var app_UIColor2: UIColor {
        let color = UIColor.black
        return color
    }
    
    /// Button First Color : gray
    static var app_ButtonColor1: UIColor {
        let color = UIColor.gray
        return color
    }
    
    static var app_TestColor1: UIColor {
        let color = UIColor.blue
        return color
    }
    
    static var app_TestColor2: UIColor {
        let color = UIColor.yellow
        return color
    }
    
}
