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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainTempView: UIView!
    @IBOutlet weak var summaryTemp: UILabel!
    let dateManager = DateManager()
    var weather: WeatherData?
    private var scrollMaxup: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTapBar()
        ininDelegateAndDataSource()
        registerNib()
        configureCollectionView()
        configureMainTempView()
        configureScrollView()
    }
    
    private func configureScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width-300, height: 1000)
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
    }
    
    private func configureNavigationItem() {
        let titleLabel = UILabel()
        titleLabel.text = "My Location"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.sizeToFit()
        
        let cityLabel = UILabel()
        cityLabel.text = "City Name"
        cityLabel.textColor = UIColor.white
        cityLabel.font = UIFont.systemFont(ofSize: 14)
        cityLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, cityLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6
        
        self.navigationItem.titleView = stackView
    }
    
    private func configureMainTempView() {
        mainTempView.backgroundColor = .clear
        
        let tempLabel = UILabel()
        tempLabel.text = "12º"
        tempLabel.textColor = UIColor.white
        tempLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tempLabel.font = UIFont.systemFont(ofSize: 100)
        tempLabel.textAlignment = .center
        //tempLabel.font = UIFont.systemFont(ofSize: 100)
        tempLabel.sizeToFit()
        
        let airStatus = UILabel()
        airStatus.text = "Mostly Clear"
        airStatus.textColor = UIColor.white
        airStatus.sizeToFit()
        
        let highAndLow = UILabel()
        highAndLow.text = "H:14º L:1º"
        highAndLow.textColor = UIColor.white
        highAndLow.sizeToFit()
        
        summaryTemp.text = "12º | Mostly Clear"
        summaryTemp.textColor = UIColor.white
        summaryTemp.sizeToFit()
        
        mainTempView.addSubview(tempLabel)
        mainTempView.addSubview(airStatus)
        mainTempView.addSubview(highAndLow)
        mainTempView.addSubview(summaryTemp)
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        airStatus.translatesAutoresizingMaskIntoConstraints = false
        highAndLow.translatesAutoresizingMaskIntoConstraints = false
        summaryTemp.translatesAutoresizingMaskIntoConstraints = false
        
        tempLabel.centerXAnchor.constraint(equalTo: mainTempView.centerXAnchor).isActive = true
        airStatus.centerXAnchor.constraint(equalTo: mainTempView.centerXAnchor).isActive = true
        highAndLow.centerXAnchor.constraint(equalTo: mainTempView.centerXAnchor).isActive = true
        summaryTemp.centerXAnchor.constraint(equalTo: mainTempView.centerXAnchor).isActive = true
        
        airStatus.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5).isActive = true
        highAndLow.topAnchor.constraint(equalTo: airStatus.bottomAnchor, constant: 5).isActive = true
        summaryTemp.topAnchor.constraint(equalTo: tempLabel.topAnchor, constant: 20).isActive = true
        
        mainTempView.translatesAutoresizingMaskIntoConstraints = false
        mainTempView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -60).isActive = true
        mainTempView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTempView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTempView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: mainTempView.frame.height).isActive = true
        
        if scrollMaxup {
            tempLabel.alpha = 1.0
            airStatus.alpha = 1.0
            highAndLow.alpha = 1.0
            summaryTemp.alpha = 0.0
        } else {
            tempLabel.alpha = 0.0
            airStatus.alpha = 0.0
            highAndLow.alpha = 0.0
            summaryTemp.alpha = 1.0
        }
    }
    
    private func configureTapBar() {
        let customBottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 60))
        customBottomView.backgroundColor = .darkGray
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: self.view.bounds.midX + 120, y: 0, width: 100, height: 40)
        backButton.setTitleColor(.white, for: .highlighted)
        backButton.setTitleColor(.gray, for: .highlighted)
        
        let mapButton = UIButton(type: .custom)
        mapButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        mapButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mapButton.frame = CGRect(x: self.view.bounds.midX - 220, y: 0, width: 100, height: 40)
        mapButton.setTitleColor(.white, for: .highlighted)
        mapButton.setTitleColor(.gray, for: .disabled)
        
        customBottomView.addSubview(backButton)
        customBottomView.addSubview(mapButton)
        customBottomView.alpha = 0.5
        customBottomView.layer.borderColor = UIColor.white.cgColor
        customBottomView.layer.borderWidth = 1
        
        view.addSubview(customBottomView)
    }
    
    private func ininDelegateAndDataSource() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        tenDaysCollectionView.delegate = self
        tenDaysCollectionView.dataSource = self
        moreInfoCollectionView.delegate = self
        moreInfoCollectionView.dataSource = self
        scrollView.delegate = self
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
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        
        let layoutVTC = UICollectionViewFlowLayout()
        layoutVTC.scrollDirection = .vertical
        layoutVTC.sectionHeadersPinToVisibleBounds = true
        
        todayCollectionView.collectionViewLayout = layout
        tenDaysCollectionView.collectionViewLayout = layoutVTC
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
    
    func setBackgroundImageOnTime(weather: WeatherData) {
//        let dateManager = DateManager()
//        let currentHour = Calendar.current.component(.hour, from: dateManager.current)
//        
//        var backgroundImageName = "Night"
//        
//        switch currentHour {
//        case 0..<6:
//            backgroundImageName = "Night"
//        case 6..<8:
//            backgroundImageName = "Sunset"
//        case 8..<12:
//            backgroundImageName = "Sunny"
//        case 12..<18:
//            backgroundImageName = "Sunny"
//        case 18..<20:
//            backgroundImageName = "Sunset"
//        case 20..<0:
//            backgroundImageName = "Night"
//        default:
//            backgroundImageName = "Sunny"
//        }
        let time = dateManager.calculateTime(weather: weather)
        let backgroundImageName: String
        let components = time.split(separator: ":")
        
        if components.count == 2,
            let hour = Int(components[0]),
            let minute = Int(components[1]) {
            let currentMinutes = hour * 60 + minute

            if currentMinutes >= (6 * 60) && currentMinutes < (18 * 60) {
                backgroundImageName = "Sunny"
            } else {
                backgroundImageName = "Night"
            }
        } else {
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
            return CGSize(width: self.view.bounds.width, height: 15)
        case tenDaysCollectionView:
            return CGSize(width: self.view.bounds.width / 2.3, height: 15)
        case moreInfoCollectionView:
            return CGSize(width: self.view.bounds.width / 2.3, height: 15)
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
            return CGSize(width: self.view.bounds.width/8, height: 100)
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
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
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
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "discriptionHeader", for: indexPath) as! CollectionReusableView
            
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
            headerView.discriptionLabel.sizeToFit()
            
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension SecondViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = self.scrollView.contentOffset.y
        
        if offset <= 0 {
            // 스크롤이 최상단에 위치할 때
            mainTempView.alpha = 1.0
            mainTempView.subviews.forEach { subview in
                if let label = subview as? UILabel {
                    if label != summaryTemp {
                        label.alpha = 1.0
                        summaryTemp.alpha = 0.0
                    }
                }
            }
        } else {
            // 스크롤이 내려갈 때 (내려 갈수록 offset 증가)
            let alpha = 1.0 - (offset / 100) // 조절 가능한 값
            summaryTemp.alpha = max(0.0, 1-alpha)
            
            // 레이블 투명도 조절
            let labelAlpha = max(0.0, alpha - 0.1) // 레이블이 더 빨리 사라지도록 조절
            mainTempView.subviews.forEach { subview in
                if let label = subview as? UILabel {
                    label.alpha = labelAlpha
                    summaryTemp.alpha = 1 - labelAlpha
                }
            }
        }
    }
}
