//
//  MainVC.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/19/23.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    
    @IBOutlet weak var resetButtonView: UIView!
    @IBOutlet weak var resetLocationButton: UIButton!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchButtonViewWidth: NSLayoutConstraint!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTextFieldWidth: NSLayoutConstraint!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    
    @IBOutlet weak var dailyWeatherBackgroundView: UIView!
    @IBOutlet weak var dailyWeatherHeaderLabel: UILabel!
    @IBOutlet weak var dailyWeatherHeaaderDivider: UIView!
    @IBOutlet weak var dailyWeatherCollectionView: UICollectionView!
    
    private var shouldCollapse = false

    var dataArray = ["Sunday", "sun", "72°F", "40F°"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpPlaceHolders()
    }

    private func setUpUI() {
        backgroundImageView.image = UIImage(named: "cloud.rain")
        backgroundImageView.contentMode = .scaleAspectFill
//        backgroundImageView.applyBlurEffect()
        overlayView.backgroundColor = .clear

        setUpHeaderSection()
        setUpConditionSection()
        setUpDailyWeatherSection()
    }
    
    private func setUpHeaderSection() {
        resetButtonView.backgroundColor = .customWhite.withAlphaComponent(0.5)
        resetButtonView.circularize()
        resetButtonView.applyDarkShadow()
        resetLocationButton.tintColor = .customBlack
        
        searchButtonView.backgroundColor = .customWhite.withAlphaComponent(0.5)
        searchButtonView.roundCorners(cornerRadius: 20)
        searchButtonView.applyDarkShadow()
        searchButton.tintColor = .customBlack
        
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.borderStyle = .none
        searchTextField.tintColor = .customDarkGrey
        searchTextField.font = CustomFonts.captionMedium
        searchTextField.textColor = .customBlack
    }
    
    private func setUpConditionSection() {
        cityLabel.configure(font: CustomFonts.captionLarge!, color: .customBlack)
        
        
        currentTempLabel.configure(font: CustomFonts.titleXL!)
        conditionLabel.configure(font: CustomFonts.captionLarge!)
        maxMinTempLabel.configure(font: CustomFonts.captionLarge!)
    }
    
    private func setUpDailyWeatherSection() {
        dailyWeatherBackgroundView.backgroundColor = .customWhite.withAlphaComponent(0.5)
        dailyWeatherBackgroundView.applyDarkShadow()
        dailyWeatherBackgroundView.roundCorners(cornerRadius: 25.0)
        dailyWeatherCollectionView.backgroundColor = .clear
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "calendar")?.withTintColor(.customBlack)

        dailyWeatherHeaderLabel.configure(font: CustomFonts.captionMedium!)
        let headerTitle = NSMutableAttributedString(string: " Weekly Forecast")
        headerTitle.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        dailyWeatherHeaderLabel.attributedText = headerTitle
        
        dailyWeatherHeaaderDivider.backgroundColor = .customBlack
        dailyWeatherHeaaderDivider.roundCorners(cornerRadius: 1)
        
        dailyWeatherCollectionView.dataSource = self
        dailyWeatherCollectionView.delegate = self
        dailyWeatherCollectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellIdentifier)
       
        dailyWeatherCollectionView.showsHorizontalScrollIndicator = false
        dailyWeatherCollectionView.isScrollEnabled = true
//        dailyWeatherCollectionView.delaysContentTouches = false
        dailyWeatherCollectionView.collectionViewLayout = setFlowLayout()
        
        
        
    }
    
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 160
//        flowLayout.footerReferenceSize = CGSize(width: view.bounds.width, height: 0)
        return flowLayout
    }
    
    
    
    private func setUpPlaceHolders() {
        cityLabel.text = "San Francisco, CA"
        currentTempLabel.text = "72°F"
        conditionLabel.text = "Mostly Clear"
        maxMinTempLabel.text = "H: 75°F L: 56°F"
    }
    
    // MARK: - UIActions
    @IBAction func SearchLocationButtonPressed(_ sender: Any) {
        animateSearchFieldView()
        
    }
    
    private func animateSearchFieldView() {
        let safeAreaMargin: CGFloat = 32
        
        if shouldCollapse {
            self.searchButtonViewWidth.constant = CGFloat(40)
            self.searchTextFieldWidth.constant = CGFloat(0)
            self.searchTextField.isHidden = true
                self.searchTextField.placeholder = ""
            
        } else {
            let newSearchButtonViewWidth = view.layer.frame.width - (resetButtonView.frame.maxX + safeAreaMargin)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { Timer in
                self.searchTextField.isHidden = false
            }
            let newSearchFieldWidth = view.layer.frame.width - (resetButtonView.frame.width + 72 + safeAreaMargin)
            
            self.searchButtonViewWidth.constant = CGFloat(newSearchButtonViewWidth)
            self.searchTextFieldWidth.constant = CGFloat(newSearchFieldWidth)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { Timer in
                    self.searchTextField.placeholder = " Look up weather by city name"
            }
        }
        
        shouldCollapse = !shouldCollapse
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
       }
    }
 }

// MARK: - UITextField Delegate
extension MainVC: UITextFieldDelegate {
    
}

// MARK: - UICollectionView DataSource

extension MainVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! DailyWeatherCell

        return cell
    }
    
}

// MARK: - UICollectionView Delegate FlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: dailyWeatherBackgroundView.frame.height - 38)
    }
}

// MARK: - UICollectionView Delegate
extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
