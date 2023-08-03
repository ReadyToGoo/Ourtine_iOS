//
//  SearchResultView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/14.
//

import UIKit
import SnapKit

/// 검색 결과 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : SearchViewResultController
class SearchResultView: UIView {
    
    // 세그먼트에 표시될 선택한 아이템 강조선 너비입니다.
    let selectedLinewidth = screenWidth / 3
    
    // 상단 커스텀 네비게이션 바 : 검색 결과 뷰 전용
    //lazy var navigationBar = Custom_NavigationBar()
    lazy var navigationBar: Custom_NavigationBar = {
        let navBar = Custom_NavigationBar()
        navBar.addCancelBtn_at_Right()
        navBar.addSearchBar_at_Center()
        return navBar
    }()
    
    // 네비게이션 바 아래 세그먼트 컨트롤
    lazy var segmentControl = CustomSegmentControl(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CustomSegmentControl.selfHeight))
    
    // 세그먼트 컨트로 밑선
    lazy var underLine:UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 3))
        line.backgroundColor = UIColor.app_SecondaryColor
        return line
    }()
    
    // 세그먼트 컨트롤 강조선
    lazy var selectedLine: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 3))
        line.backgroundColor = UIColor.app_PrimaryColor
        //line.layer.cornerRadius = 15.0
        return line
    }()
    
    // 세그먼트컨트롤 아래 습관 찾기 콜렉션 뷰
    lazy var searchResultCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width * 2), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // 세그먼트컨트롤 아래 유저 닉네임 테이블 뷰
    lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        return tableView
    }()
    
    // "습관 찾기" 세그먼트 눌렀을 때 테이블 뷰 위에 표시되는 필터링 버튼
    lazy var filterBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .app_SecondaryColor2
        config.imagePadding = 10
        config.cornerStyle = .capsule
        
        let btn = UIButton(configuration: config)
        btn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        btn.setTitle("습관 개설 순", for: .normal)
        btn.setBackgroundColor(.app_SecondaryColor2, for: .normal)
        return btn
    }()
    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        addSubview(navigationBar)
        segmentControl.addItems(["습관 찾기", "유저 닉네임"])
        addSubview(segmentControl)
        addSubview(searchResultCollectionView)
        addSubview(searchResultTableView)
        addSubview(filterBtn)
        addSubview(underLine)
        addSubview(selectedLine)
    }
    
    // 컴포넌트들 Constraints 설정
    func setConstraint() {
        
        //MARK: - NavigationBar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - sementControl
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(CustomSegmentControl.selfHeight)
        }
        
        //MARK: - underLine
        underLine.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(3)
            $0.top.equalTo(segmentControl.snp.bottom)
        }
        
        //MARK: - selectedLine
        selectedLine.snp.makeConstraints {
            $0.width.equalTo(self.selectedLinewidth)
            $0.height.equalTo(3)
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.equalToSuperview().offset(self.selectedLinewidth / 4)
        }
        
        // MARK: - SearchResultCollectionView
        searchResultCollectionView.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(segmentControl.snp.bottom)
        }
        
        //MARK: - SearchResultTableView
        searchResultTableView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(filterBtn.snp.bottom)
            
        }
        
        //MARK: - SearchResultTableView
        filterBtn.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(40)
        }
        
        
        
    }
    
    // View를 처음 가져올 때 초기화 코드
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraint()
        self.backgroundColor = .white
        
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
