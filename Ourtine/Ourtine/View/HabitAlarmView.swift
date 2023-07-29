//
//  HabitAlarmView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/29.
//

import UIKit
import SnapKit

/// 알람 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : HabitAlarmViewController
class HabitAlarmView: UIView {
    
    // 상단 커스텀 네비게이션바
    lazy var navigationBar: Custom_NavigationBar = {
        let navBar = Custom_NavigationBar()
        return navBar
    }()
    
    //임시 네비게이션 타이틀 뷰용 라벨 (수정 가능성 큼)
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "알림"
        title.textColor = .black
        title.font = .systemFont(ofSize: 20)
        return title
    }()
    
    //  알람 내용 테이블 뷰
    lazy var alarmTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        self.addSubview(navigationBar)
        navigationBar.addSubview(titleLabel)
        self.addSubview(alarmTableView)
    }
        
    // 컴포넌트들 Constraints 설정
    func setConstraint() {
        
        //MARK: - 임시용 라벨
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        //MARK: - NavigationBar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - SearchResultTableView
        alarmTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    
    }
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraint()
        self.backgroundColor = .white // 안해주면 배경이 투명색!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// Preview 코드 -> ViewController
import SwiftUI
struct HabitAlarmView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitAlarmViewController()
            let navigationController = UINavigationController(rootViewController: ViewController)
            return navigationController
        }
    }
}


