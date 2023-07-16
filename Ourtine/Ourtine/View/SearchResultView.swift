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
    
    // 네비게이션 바 아래 세그먼트 컨트롤 (프로토타입)
    lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        segment.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        //segment.backgroundColor = .systemGray6
    
        // Segment 구분 라인 제거
        //segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: "유저 프로필", at: 0, animated: true)
        
        segment.insertSegment(withTitle: "습관 검색 결과", at: 1, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        
        // 선택 안했을 때 배경색
        segment.setBackgroundColor(.white, for: .normal)
        
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        // 선택 했을 때 배경색
        segment.setBackgroundColor(.systemGray, for: .selected)
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
        }()
                
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
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(searchResultTableView.snp.top)
        }
        
        //MARK: - SearchResultTableView
        searchResultTableView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom).offset(80)
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
