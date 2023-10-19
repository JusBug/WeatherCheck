//
//  SecondViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/10.
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
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.sizeToFit()
        
        let cityLabel = UILabel()
        cityLabel.text = "City Name"
        cityLabel.textColor = UIColor.white
        cityLabel.font = UIFont.systemFont(ofSize: 14)
        cityLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, cityLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        self.navigationItem.titleView = stackView
    }
    
    private func configureTapBar() {
        let customBottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 100))
        customBottomView.backgroundColor = .darkGray
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: self.view.bounds.midX + 100, y: 20, width: 100, height: 40)
        backButton.setTitleColor(.white, for: .highlighted)
        backButton.setTitleColor(.gray, for: .disabled)
        
        customBottomView.addSubview(backButton)
        
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
            return 24
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
            
            cell.splitTimeLine(indexPath: indexPath)
            
            return cell
        case tenDaysCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(indexPath: indexPath)
            
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
            return CGSize(width: self.view.bounds.width - 50, height: 50)
        case moreInfoCollectionView:
            return CGSize(width: self.view.bounds.width / 2.4, height: 100)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case todayCollectionView:
            return UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10)
        case tenDaysCollectionView:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        case moreInfoCollectionView:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        default:
            break
        }
        
        return UIEdgeInsets()
    }
}
