//
//  HabitDiscoverView.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/25.
//

import UIKit
import SnapKit

/// 탐색 메인 뷰
/// ! MVC 구현은 Model / View / ViewController로 분리해서 구현했습니다.
/// ! 해당 뷰는 View에 해당하며 레이아웃에 해당하는 것들만 설정했습니다.
/// ! ViewController : HabitDiscoverViewController
/// ! CollectionView가 여러개 겹쳐있습니다.
class HabitDiscoverScrollView: UIScrollView {
    
    lazy var habitProfileView = HabitDiscoverView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(habitProfileView)
        
        habitProfileView.snp.makeConstraints {
            $0.edges.equalTo(self.contentLayoutGuide)
            $0.width.equalTo(self.frameLayoutGuide)
            $0.height.equalTo(1200) // 나중에 스크롤 뷰 높이 동적 높이 or 고정값 확정내기
        }
        
        // 얘 넣으면 sticky header가 안됨
        habitProfileView.scrollResetBtn.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.equalTo(40)
            $0.center.equalToSuperview()
        }
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
}

class HabitDiscoverView: UIView {
    
    // 상단 바
    lazy var topBar: Custom_NavigationBar = {
        let bar = Custom_NavigationBar()
        bar.hideBackBtn_at_Left()
        bar.addSearchBar_at_Center()
        bar.addAlarmBtn_at_Right()
        return bar
    }()
    
    // "친구들은요" 라벨
    lazy var memberCVHeader: UILabel = {
        let label = UILabel()
        label.text = "친구들은요,"
        label.textColor = .black
        return label
    }()
    
    // 멤버 콜렉션 뷰
    lazy var memberCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5 // cell사이의 간격 설정
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        return view
    }()
    
    // 습관 카테고리 Collection View (세그먼트 컨트롤처럼 보이는)
    lazy var habitSegmentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
    
        collectionView.backgroundColor = .white.withAlphaComponent(0.8)
        return collectionView
    }()
    
    // 습관 카테고리 CollectionView 밑선
    lazy var line_UnderSegmentCollectionView: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    // 습관 카드 Collection View
    lazy var habitCardCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width * 2), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var scrollResetBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .app_SecondaryColor2.withAlphaComponent(0.9)
        btn.setTitle("위로 가기", for: .normal)
        btn.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        btn.tintColor = .white
        return btn
    }()

    
    // 컴포넌트들 View에 등록
    func inputSubview() {
        //self.addSubview(memberCVHeader)
        self.addSubview(memberCollectionView)
        self.addSubview(habitCardCollectionView)
        self.addSubview(line_UnderSegmentCollectionView)
        self.addSubview(habitSegmentCollectionView)
        self.addSubview(topBar)
        self.addSubview(scrollResetBtn)
    }
    
    func setConstraints() {
        
        //MARK: - TopBar
        topBar.snp.makeConstraints {
            $0.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: - memberCollectionView HeaderLabel
//        memberCVHeader.snp.makeConstraints {
//            $0.top.equalTo(topBar.snp.bottom).offset(15)
//            $0.leading.equalToSuperview().offset(15)
//            $0.height.equalTo(0)
//        }
        
        //MARK: - memberCollectionView
        memberCollectionView.snp.makeConstraints {
            //$0.top.equalTo(memberCVHeader.snp.bottom).offset(15)
            $0.top.equalTo(topBar.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        //MARK: - habitSegmentCollectionView
        habitSegmentCollectionView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        //MARK: - underline
//        line_UnderSegmentCollectionView.snp.makeConstraints {
//            $0.top.equalTo(habitSegmentCollectionView.snp.bottom).offset(-2)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(1)
//        }
        
        //MARK: - habitCardCollectionView
        habitCardCollectionView.snp.makeConstraints {
            $0.height.equalTo(1000)
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(CustomSegmentControl.selfHeight + 10)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputSubview()
        setConstraints()
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

/// Preview 코드 -> ViewController
import SwiftUI
struct HabitDiscoverView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let ViewController = HabitDiscoverViewController()
            let navigationController = UINavigationController(rootViewController: ViewController)
            return navigationController
        }
        .previewLayout(.fixed(width: 400, height: 1200))
        .preferredColorScheme(.dark)
    }
}

