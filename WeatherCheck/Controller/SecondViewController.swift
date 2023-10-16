//
//  SecondViewController.swift
//  WeatherCheck
//
//  Created by 박종화 on 2023/10/10.
//

import UIKit

final class SecondViewController: UIViewController {
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var tenDaysCollectionView: UICollectionView!
    @IBOutlet weak var moreInfoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTapBar()
        ininDelegateAndDataSource()
        registerNib()
        configureLayoutForTime()
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
    
    private func ininDelegateAndDataSource() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        tenDaysCollectionView.delegate = self
        tenDaysCollectionView.dataSource = self
        moreInfoCollectionView.delegate = self
        moreInfoCollectionView.dataSource = self
    }
    
    private func registerNib() {
        todayCollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "timeCell")
        tenDaysCollectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
        moreInfoCollectionView.register(UINib(nibName: "moreInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moreCell")
    }
    
    private func configureLayoutForTime() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        todayCollectionView.collectionViewLayout = layout
    }
    
    @objc func backButtonTapped() {
        // 뒤로 가기 버튼 동작을 정의
        self.dismiss(animated: true)
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todayCollectionView:
            return 10
        case tenDaysCollectionView:
            return 10
        case moreInfoCollectionView:
            return 4
        default:
            break
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case todayCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        case tenDaysCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        case moreInfoCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreCell", for: indexPath) as? moreInfoCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case todayCollectionView:
            return CGSize(width: 60, height: 100)
        case tenDaysCollectionView:
            return CGSize(width: self.view.bounds.width - 50, height: 40)
        case moreInfoCollectionView:
            return CGSize(width: 100, height: 100)
        default:
            break
        }
        
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case todayCollectionView:
            return 1
        case tenDaysCollectionView:
            return 10
        case moreInfoCollectionView:
            return 10
        default:
            break
        }
        
        return 0
    }
}
