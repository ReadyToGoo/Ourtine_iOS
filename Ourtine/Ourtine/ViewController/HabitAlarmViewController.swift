//
//  HabitAlarmViewController.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/29.
//

import UIKit

class HabitAlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // habitProfileView 등록
    lazy var habitAlarmView = HabitAlarmView()
    
    // view 로드할 때 habitProfileView로 가져오기
    override func loadView() {
        super.loadView()
        view = habitAlarmView
        //view.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - SearchResultTableView 연결
        self.habitAlarmView.alarmTableView.delegate = self
        self.habitAlarmView.alarmTableView.dataSource = self
        
        //MARK: - tableViewCell 파일 register
        self.habitAlarmView.alarmTableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        
        //MARK: - backBTN
        self.habitAlarmView.navigationBar.leftButton.action = #selector(popVC)
        self.habitAlarmView.navigationBar.leftButton.target = self
        
        
        
    }
    
    /// Navigation Controller 스택에서 pop하기 -> 뒤로 돌아가기
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HabitAlarmViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy_alarmModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier, for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
        
        // 넘기기 전에 cell에 데이터 넘겨줍니다
        cell.getCellData(data: Dummy_alarmModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("알람\(indexPath.row) 탭")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AlarmTableViewCell.cellHeight
    }
    
}

import SwiftUI
struct HabitAlarmViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = HabitAlarmViewController()
            return ViewController
        }
    }
}
