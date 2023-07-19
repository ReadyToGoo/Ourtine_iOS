//
//  HabitJoinVIewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit

/// 임시 습관 초기 뷰입니다
class HabitJoinViewController: UIViewController {
    
    lazy var orangeBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var TitleButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Tap to Search", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(orangeBox)
        self.view.addSubview(TitleButton)
        
        TitleButton.addTarget(self, action: #selector(gotoSearchView), for: .touchDown)
        
        orangeBox.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalToSuperview()
        }
        TitleButton.snp.makeConstraints { make in
            make.center.equalTo(orangeBox.snp.center)
        }
    }
    
    @objc func gotoSearchView() {
        
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}

import SwiftUI
struct HabitJoinViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitJoinViewController()
            return ViewController
        }
    }
}
