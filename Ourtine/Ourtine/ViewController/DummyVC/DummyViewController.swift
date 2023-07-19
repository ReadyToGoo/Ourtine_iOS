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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(cyanBox)
        self.view.addSubview(TitleText)
        
        cyanBox.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
        TitleText.snp.makeConstraints { make in
            make.center.equalTo(cyanBox.snp.center)
        }
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
