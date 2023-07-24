//
//  SearchView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit
import SnapKit

/// 검색 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : SearchViewController   
class SearchView: UIView {
    
    // 상단 커스텀 네비게이션바
    //lazy var navigationBar = Custom_NavigationBar()
    lazy var navigationBar: Custom_NavigationBar = {
        let navBar = Custom_NavigationBar()
        navBar.addCancelBtn_at_Right()
        navBar.addSearchBar_at_Center()
        return navBar
    }()
    
    // 네비게이션 바 아래 세그먼트 컨트롤
    lazy var segmentControl = CustomSegmentControl(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
    
    // 세그먼트컨트롤 아래 검색 결과 테이블 뷰
    lazy var recentSearchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    //테이블 뷰 위 최근 검색어 라벨
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = .black
        return label
    }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        self.addSubview(navigationBar)
        self.addSubview(segmentControl)
        self.addSubview(headerLabel)
        self.addSubview(recentSearchTableView)
    }
        
    // 컴포넌트들 Constraints 설정
    func setConstraint() {
        
        //MARK: - NavigationBar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - segmentControl
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            //make.height.equalTo(CustomSegmentControl.selfHeight)
            make.height.equalTo(0)
        }
        
        //MARK: - SearchResultTableView
        recentSearchTableView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom)
        }
        
        //MARK: - headerLabel
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
    
    }
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraint()
        backgroundColor = .white // 안해주면 배경이 투명색!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// Preview 코드 -> ViewController
import SwiftUI
struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = SearchViewController()
            let navigationController = UINavigationController(rootViewController: ViewController)
            return navigationController
        }
    }
}


