//
//  SearchResultView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit

/// 검색 결과 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : SearchViewResultController
class SearchResultView: UIView {
    
    // 상단 커스텀 네비게이션 바 : 검색 결과 뷰 전용
    lazy var navigationBar = Search_NavigationBar()
    
    // 네비게이션 바 아래 세그먼트 컨트롤
    lazy var segmentControl = CustomSegmentControl(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
                
    // 세그먼트컨트롤 아래 검색 결과 테이블 뷰
    lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .app_ButtonColor1
        //let tableHeader = TableHeaderView()
        //tableHeader.titleLabel.text = "유저 프로필 검색 결과"
        //tableView.tableHeaderView = tableHeader
        return tableView
    }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        addSubview(navigationBar)
        addSubview(segmentControl)
        self.segmentControl.setBackgroundColor(.gray, for: .normal)
        addSubview(searchResultTableView)
    }
    
    // 컴포넌트들 Constraints 설정
    func setConstraint() {
        
        //MARK: - NavigationBar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(searchResultTableView.snp.top)
        }
        
        //MARK: - SearchResultTableView
        searchResultTableView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom).offset(50)
        }
        
        
    }
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraint()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Preview 코드 -> ViewController
import SwiftUI
struct SearchResultView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = SearchResultViewController()
            let navigationController = UINavigationController(rootViewController: ViewController)
            return navigationController
        }
    }
}
