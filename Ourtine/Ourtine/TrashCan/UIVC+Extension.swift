//
//  TEST.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit

extension UIViewController {
    func addSearchBtn() {
        let rightButton = UIBarButtonItem(image:UIImage(systemName: "magnifyingglass"))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
}
