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
        configureCollectionView()
        setBackgroundImageOnTime()
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
        
        let mapButton = UIButton(type: .custom)
        mapButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        mapButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mapButton.frame = CGRect(x: self.view.bounds.midX + 20, y: 20, width: 100, height: 40)
        mapButton.setTitleColor(.white, for: .highlighted)
        mapButton.setTitleColor(.gray, for: .disabled)
        
        customBottomView.addSubview(backButton)
        customBottomView.addSubview(mapButton)
        customBottomView.alpha = 0.8
        
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
        todayCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "discriptionHeader")
        tenDaysCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "discriptionHeader")
        moreInfoCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "discriptionHeader")
        
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true

        todayCollectionView.collectionViewLayout = layout
        todayCollectionView.showsHorizontalScrollIndicator = false
        tenDaysCollectionView.showsVerticalScrollIndicator = false
        moreInfoCollectionView.showsVerticalScrollIndicator = false
        todayCollectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        tenDaysCollectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        moreInfoCollectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        todayCollectionView.layer.cornerRadius = 10
        tenDaysCollectionView.layer.cornerRadius = 10
        moreInfoCollectionView.layer.cornerRadius = 10
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setBackgroundImageOnTime() {
        let dateManager = DateManager()
        let currentHour = Calendar.current.component(.hour, from: dateManager.current)
        
        var backgroundImageName = "Night"
        
        switch currentHour {
        case 0..<6:
            backgroundImageName = "Night"
        case 6..<8:
            backgroundImageName = "Sunset"
        case 8..<12:
            backgroundImageName = "Sunny"
        case 12..<18:
            backgroundImageName = "Sunny"
        case 18..<20:
            backgroundImageName = "Sunset"
        case 20..<0:
            backgroundImageName = "Night"
        default:
            backgroundImageName = "Sunny"
        }
        
        let backgroundImageView = UIImageView(image: UIImage(named: backgroundImageName))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
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
            cell.configureLables()
            cell.backgroundColor = .clear
            
            return cell
        case tenDaysCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(indexPath: indexPath)
            cell.configureLables()
            cell.backgroundColor = .clear
            
            return cell
        case moreInfoCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreCell", for: indexPath) as? moreInfoCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch collectionView {
        case todayCollectionView:
            return CGSize(width: 100, height: 10)
        case tenDaysCollectionView:
            return CGSize(width: self.view.bounds.width - 50, height: 25)
        case moreInfoCollectionView:
            return CGSize(width: self.view.bounds.width / 2.3, height: 25)
        default:
            break
        }
        return CGSize()
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
            return CGSize(width: self.view.bounds.width / 2.3, height: 100)
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
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case tenDaysCollectionView:
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        case moreInfoCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            break
        }
        
        return UIEdgeInsets()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension SecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // 헤더 뷰를 가져오거나 생성합니다.
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "discriptionHeader", for: indexPath) as! CollectionReusableView
            
            // 헤더 뷰의 타이틀 레이블에 원하는 타이틀을 설정합니다.
            switch collectionView {
            case todayCollectionView:
                headerView.discriptionLabel.text = "☀️ Today conditions"
            case tenDaysCollectionView:
                headerView.discriptionLabel.text = "🗓️ 10-DAY FORECAST"
            case moreInfoCollectionView:
                headerView.discriptionLabel.text = "❄️ AIR QUALITY"
            default:
                headerView.discriptionLabel.text = "No Information"
            }
            
            headerView.discriptionLabel.font = UIFont.systemFont(ofSize: 10)
            headerView.discriptionLabel.alpha = 0.5
            
            return headerView
        }
        return UICollectionReusableView()
    }
}
