//
//  MainVC.swift
//  Weatherful
//
//  Created by Antony Bluemel on 4/19/23.
//

import UIKit
import CoreLocation
import AudioToolbox

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
    private var shouldSearch = false
    
    var dataArray = ["Sunday", "sun", "72°F", "40F°"]
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var forecastArray = [DailyForecastModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        //        setUpPlaceHolders()
        weatherManager.delegate = self
        searchTextField.delegate = self
        dailyWeatherCollectionView.dataSource = self
        dailyWeatherCollectionView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        //        hideKeyboardWhenTappedAround()
        
        view.showBlurLoader()
    }
    
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        //        tap.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        self.view.endEditing(true)
//    }
    
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
        searchButtonView.roundCorners(cornerRadius: 27)
        searchButtonView.applyDarkShadow()
        searchButton.tintColor = .customBlack
        
        searchTextField.backgroundColor = UIColor.clear
        searchTextField.borderStyle = .none
        searchTextField.tintColor = .placeholderGrey
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
        dailyWeatherBackgroundView.roundCorners(cornerRadius: 20.0)
        dailyWeatherCollectionView.backgroundColor = .clear
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "calendar")?.withTintColor(.customBlack)
        
        dailyWeatherHeaderLabel.configure(font: CustomFonts.captionMedium!)
        let headerTitle = NSMutableAttributedString(string: " 5-DAY FORECAST")
        headerTitle.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        dailyWeatherHeaderLabel.attributedText = headerTitle
        
        dailyWeatherHeaaderDivider.backgroundColor = .customBlack
        dailyWeatherHeaaderDivider.roundCorners(cornerRadius: 1)
        
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
    
    //
    //    private func setUpPlaceHolders() {
    //        cityLabel.text = "San Francisco, CA"
    //        currentTempLabel.text = "72°F"
    //        conditionLabel.text = "Mostly Clear"
    //        maxMinTempLabel.text = "H: 75°F L: 56°F"
    //    }
    
    @IBAction func resetLocationButtonPressed(_ sender: UIButton) {
        // Method 1: we could possibly call "locationManager.requestLocation()" again as it automatically triggers didUpdateLocations().
        // but if we already called this and there's no change in GPS location, there will be no updates, so didUpdateLocations() will not get called.
        
        // Method 2: call locationManager.stopUpdatingLocation()
        locationManager.requestLocation()
    }
}

// MARK: - UITextField Delegate
extension MainVC: UITextFieldDelegate {
    @IBAction func SearchLocationButtonPressed(_ sender: Any) {
        

        print("Input by Press: " + searchTextField.text!)
        
        if searchTextField.text == "" {
            shouldSearch = false
        } else {
            shouldSearch = true
        }
        animateSearchFieldView()
//        searchTextField.resignFirstResponder()
    }
    
    private func animateSearchFieldView() {
        if shouldCollapse {
            collapseSearchBar()
        } else {
            expandSearchBar()
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
        
        shouldCollapse = !shouldCollapse
        
    }
    
    private func collapseSearchBar() {
        self.searchButtonViewWidth.constant = CGFloat(52)
        self.searchTextFieldWidth.constant = CGFloat(0)
        
//        self.searchTextField.resignFirstResponder()
        self.searchTextField.isHidden = true
        //        self.searchTextField.resignFirstResponder()
        self.searchTextField.placeholder = ""
//        print(self.searchTextField.resignFirstResponder())
        self.view.endEditing(true) // BLAKE
        print(self.view.endEditing(true))
    }
    
    private func expandSearchBar() {
        let safeAreaMargin: CGFloat = 32
        let newSearchButtonViewWidth = view.layer.frame.width - (resetButtonView.frame.maxX + safeAreaMargin)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { Timer in
            self.searchTextField.isHidden = false
        }
        let newSearchFieldWidth = view.layer.frame.width - (resetButtonView.frame.width + 72 + 12 + safeAreaMargin)
        
        self.searchButtonViewWidth.constant = CGFloat(newSearchButtonViewWidth)
        self.searchTextFieldWidth.constant = CGFloat(newSearchFieldWidth)
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { Timer in
            //            self.searchTextField.placeholder = " Look up weather by city name"
            self.searchTextField.attributedPlaceholder = NSAttributedString(string: " Look up weather by city name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderGrey, NSAttributedString.Key.font : CustomFonts.captionMedium!])
        }
        self.searchTextField.becomeFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Input by Return Key: " + searchTextField.text!)
        if searchTextField.text == "" {
            shouldSearch = false
        } else {
            shouldSearch = true
        }
        self.view.endEditing(true)
        //        searchTextField.resignFirstResponder()
        return true // does it make a difference?
        
    }
    
    
    // good for validation
    // why did I use "textField"?
    // similar to having multiple UIButton outlets connected to the same action IBMethod, using the parameter name supports multiple.
    // If we know for certain we are using the specific one (i.e. searchTextField), we can specifically call it instead.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
//            self.view.endEditing(true)
//            self.searchTextField.resignFirstResponder()
            return true
        } else {
            textField.placeholder = "Make sure to enter a city name!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // get weather data using the input search text
        // optionally bind the cityName
        print("Did end editing!")
        print(shouldSearch)
        print(shouldSearch)
        print(shouldSearch)
        print(shouldSearch)
//        if shouldSearch {
            if let cityName = searchTextField.text {
                let formattedCityName = String((cityName as NSString).replacingOccurrences(of: " ", with: "+"))
                //            containsPlacemark.locality?.replacingOccurrences(of: " ", with: "_")
                //            cityName.locality?.replacingOccurrences(of: " ", with: "_")
                weatherManager.fetchWeather(from: formattedCityName)
                weatherManager.fetchForecast(from: formattedCityName)
//            }
        }
        
        // reset search field
        searchTextField.text = ""
        //        searchTextField.resignFirstResponder()
        
    }
}

// MARK: - UICollectionView DataSource

extension MainVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! DailyWeatherCell
        //        print(dateString)
        //        print(dayString)
        
        if indexPath.row % 2 == 0 {
            cell.overlayView.isHidden = true
        } else {
            cell.overlayView.isHidden = false
        }
        
        let forecast = forecastArray[indexPath.row]
        cell.dateLabel.text = forecast.day + " " + forecast.date
        cell.timeLabel.text = forecast.time
        cell.conditionImageView.image = UIImage(systemName: forecast.conditionName)
        cell.maxTempLabel.text = "\(forecast.max_temp)°F"
        cell.minTempLabel.text = "\(forecast.min_temp)°F"
        return cell
    }
    
}

// MARK: - UICollectionView Delegate FlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: dailyWeatherBackgroundView.frame.height - 52)
    }
}

// MARK: - UICollectionView Delegate
extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - WeatherManagerDelegate

extension MainVC: WeatherManagerDelegate {
    // the first parameter of delegate function convention: identify of the object: _ weatherManager: WeatherManager
    //    func didUpdateWeather(weather: WeatherModel) {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //        print(weather.temperature)
        DispatchQueue.main.async {
            if weather.conditionName == "cloud_bolt" {
                self.cityLabel.textColor = .customWhite
                self.cityLabel.applyLabelShadow(isDarkText: false)
                self.conditionLabel.textColor = .customWhite
                self.conditionLabel.applyLabelShadow(isDarkText: false)
                self.currentTempLabel.textColor = .customWhite
                self.currentTempLabel.applyLabelShadow(isDarkText: false)
                self.maxMinTempLabel.textColor = .customWhite
                self.maxMinTempLabel.applyLabelShadow(isDarkText: false)
            } else {
                self.cityLabel.textColor = .customBlack
                self.cityLabel.applyLabelShadow(isDarkText: true)
                self.conditionLabel.textColor = .customBlack
                self.conditionLabel.applyLabelShadow(isDarkText: true)
                self.currentTempLabel.textColor = .customBlack
                self.currentTempLabel.applyLabelShadow(isDarkText: true)
                self.maxMinTempLabel.textColor = .customBlack
                self.maxMinTempLabel.applyLabelShadow(isDarkText: true)
            }
            
            self.cityLabel.text = weather.cityName
            self.conditionLabel.text = weather.conditionDescription
            self.currentTempLabel.text = weather.tempString
            self.maxMinTempLabel.text = "H: \(weather.temp_max)°F  L: \(weather.temp_min)°F"
            //            self.backgroundImageView.image = UIImage(named: weather.conditionName)
            print(weather.conditionName)
            
            if weather.conditionName == "sun_max" || weather.conditionName == "cloud_bolt" {
                self.backgroundImageView.image = UIImage.animatedGif(named: weather.conditionName)
            } else {
                self.backgroundImageView.image = UIImage(named: weather.conditionName)
            }
            self.collapseSearchBar()
            self.view.removeBluerLoader()
        }
    }
    
    private func updateLabelColors(isDarkScreen: Bool) {
        
    }
    
    func didUpdateForecast(_ weatherManager: WeatherManager, forecastArray: [DailyForecastModel]) {
        DispatchQueue.main.async {
            self.forecastArray = forecastArray
            self.dailyWeatherCollectionView.reloadData()
            self.collapseSearchBar()
        }
    }
    
    
    func didFailWithError(error: Error) {
        // In this case, the error is most likely going to be internal --> just print it for debugging purpose.
        // Soemtimes, you might need to display the error message to the user for troubleshooting.
        print(error)
        DispatchQueue.main.async {
            self.searchTextField.attributedPlaceholder = NSAttributedString(string: " Please enter a valid city name!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            self.animateWarningShake()
            self.searchTextField.becomeFirstResponder()
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { Timer in
                self.searchTextField.attributedPlaceholder = NSAttributedString(string: " Look up weather by city name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderGrey, NSAttributedString.Key.font : CustomFonts.captionMedium!])
            }
        }
    }
    
    private func animateWarningShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.searchButtonView.center.x - 5, y: self.searchButtonView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.searchButtonView.center.x + 5, y: self.searchButtonView.center.y))
        
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
        self.searchButtonView.layer.add(animation, forKey: "position")
    }
}

// MARK: - CLLocationManagerDelegate

extension MainVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        print("Location detected!")
        
        if let latestLocation = locations.last {
            
            locationManager.stopUpdatingLocation()
            
            let latitude = latestLocation.coordinate.latitude
            let longitude = latestLocation.coordinate.longitude
            //            print(latitude)
            //            print(longitude)
            weatherManager.fetchWeather(latitude: latitude, Longitude: longitude)
            weatherManager.fetchForecast(latitude: latitude, Longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
