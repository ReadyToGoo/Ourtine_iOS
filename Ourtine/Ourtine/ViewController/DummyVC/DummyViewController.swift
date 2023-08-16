//
//  MainViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit
import SnapKit

/// 임시 뷰입니다
class DummyViewController: UIViewController {
    
    lazy var cyanBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var TitleText = { () -> UILabel in
        let label = UILabel()
        label.text = "This is for Test"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    lazy var testBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .app_PrimaryColor
        btn.setTitle("TEST", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(cyanBox)
        self.view.addSubview(TitleText)
        self.view.addSubview(testBtn)
        
        cyanBox.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
        TitleText.snp.makeConstraints { make in
            make.center.equalTo(cyanBox.snp.center)
        }
        testBtn.snp.makeConstraints {
            $0.top.equalTo(cyanBox.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(cyanBox)
            $0.height.equalTo(50)
        }
        
        cyanBox.isUserInteractionEnabled = true
        cyanBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLoginVC)))
        
        testBtn.addTarget(self, action: #selector(testGo), for: .touchUpInside)
    }
    
    @objc func openLoginVC() {
        if let val = UserDefaults.standard.string(forKey: "myToken") {
            print(val)
        }
        
        let VC = KakaoLoginViewController()
        self.present(VC, animated: true)
    }
    
    @objc func testGo() {
        usingWrapper()
    }
    
}

import SwiftUI
struct DummyViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = DummyViewController()
            return ViewController
        }
    }
}
