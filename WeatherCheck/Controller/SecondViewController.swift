//
//  SecondViewController.swift
//  WeatherCheck
//
//  Created by 박종화 on 2023/10/10.
//

import UIKit

final class SecondViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureTapBar()
    }
    
    private func configureTitle() {
        self.navigationItem.title = "city"
        self.navigationItem.titleView?.tintColor = .white
    }
    
    private func configureTapBar() {
        // 커스텀 하단 뷰 생성
        let customBottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        customBottomView.backgroundColor = .darkGray
        
        // 뒤로가기 버튼 생성
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: self.view.bounds.midX + 100, y: 20, width: 100, height: 40)
        backButton.setTitleColor(.white, for: .highlighted)
        backButton.setTitleColor(.gray, for: .disabled)
            
        // 커스텀 뷰에 뒤로가기 버튼 추가
        customBottomView.addSubview(backButton)
        
        // 화면에 커스텀 하단 뷰 추가
        view.addSubview(customBottomView)
    }
    
    @objc func backButtonTapped() {
        // 뒤로 가기 버튼 동작을 정의
        self.dismiss(animated: true)
    }
}
