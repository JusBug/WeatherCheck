//
//  SecondViewController.swift
//  WeatherCheck
//
//  Created by 박종화 on 2023/10/10.
//

import UIKit

final class SecondViewController: UIViewController {
    @IBOutlet weak var inforCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTapBar()
    }
    
    private func configureNavigationItem() {
        let titleLabel = UILabel()
        titleLabel.text = "My Location"
        titleLabel.textColor = UIColor.white // 타이틀 텍스트 색상 설정
        titleLabel.font = UIFont.systemFont(ofSize: 17) // 폰트 설정 (원하는 폰트로 변경 가능)
        titleLabel.sizeToFit() // 레이블 크기를 내용에 맞게 조정
        
        let cityLabel = UILabel()
        cityLabel.text = "City Name" // 원하는 도시 이름으로 설정
        cityLabel.textColor = UIColor.white // 도시 이름 텍스트 색상 설정
        cityLabel.font = UIFont.systemFont(ofSize: 14) // 폰트 설정
        cityLabel.sizeToFit() // 레이블 크기를 내용에 맞게 조정
        
        // 타이틀 및 도시 이름을 담는 스택 뷰 생성
        let stackView = UIStackView(arrangedSubviews: [titleLabel, cityLabel])
        stackView.axis = .vertical // 수직 스택 뷰
        stackView.alignment = .center // 가운데 정렬
        stackView.spacing = 4 // 타이틀과 도시 이름 사이의 간격 설정
        
        // 타이틀 뷰 설정
        self.navigationItem.titleView = stackView
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
