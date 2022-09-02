//
//  ViewController.swift
//  PhotoBase
//
//  Created by Богдан Баринов on 02.09.2022.
//


import UIKit
import SnapKit

final class ImageViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let nextImageButton = UIButton()
    private let textBox = UITextField()
    private let dropDown = UIPickerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupSubviews()
        configureConstraints()
        activityIndicator.startAnimating()
        loadNewImage()
    }
 
}

extension ImageViewController {
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(nextImageButton)
        view.addSubview(activityIndicator)
    }
    
    private func setupSubviews() {
        imageView.contentMode = .scaleAspectFit
        
        nextImageButton.backgroundColor = .systemMint
        nextImageButton.layer.cornerRadius = 10
        nextImageButton.setTitle("Next", for: .normal)
        nextImageButton.addTarget(self, action: #selector(nextImageButtonDidTap), for: .touchUpInside)
        
        activityIndicator.color = .systemGroupedBackground
 
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(view.center.x)
            $0.top.equalToSuperview().offset(200)
        }
        nextImageButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(150)
            $0.centerX.equalTo(view.center.x)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(view.center.x)
            $0.centerY.equalTo(view.center.y)
        }
    }
    
    @objc private func nextImageButtonDidTap() {
        loadNewImage()
    }
    
    private func loadNewImage() {
        imageView.image = nil
        activityIndicator.startAnimating()
        networkManager.loadNewImage { data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            }
        } failure: { error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "ОШИБКА!", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    
    
    
    
//    private func loadNewImage() {
//        imageView.image = nil
//        activityIndicator.startAnimating()
//        DispatchQueue.global().async {
//            sleep(2)
//            let API = "https://picsum.photos@/200/300"
//            print("privet1")
//            guard let apiURL = URL(string:  API) else {
//                DispatchQueue.main.async {
//                    self.present(self.alert, animated: true)
//                    self.activityIndicator.stopAnimating()
//                }
//                print("privet2")
//                fatalError("Error")
//            }
//            let session = URLSession(configuration: .default)
//            print("privet3")
//            let task = session.dataTask(with: apiURL) { (data, response, error) in
//                print("privet4")
//                guard let data = data, error == nil else {
//                    DispatchQueue.main.async {
//                        self.present(self.alert, animated: true)
//                        self.activityIndicator.stopAnimating()
//                    }
//                    print("RETURN")
//                    return
//                }
//                DispatchQueue.main.async {
//                    self.imageView.image = UIImage(data: data)
//                    self.activityIndicator.stopAnimating()
//                }
//            }
//            task.resume()
//            print("privet7")
//        }
//    }
//
    
//    private func loadNewImage(success:@escaping (Data) -> Void, failure:@escaping (Error?) -> Void) {
//
//        DispatchQueue.global().async {
//            sleep(2)
//            let API = "https://picsum.photos@/200/300"
//            guard let apiURL = URL(string:  API) else {
//                failure(nil)
//                fatalError("Error")
//            }
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: apiURL) { (data, response, error) in
//                guard let data = data, error == nil else {
//                    failure(error)
//                    return
//                }
//                success(data)
//            }
//            task.resume()
//        }
//    }
}

//extension MainViewController: UIPickerViewDelegate, UIPickerViewDelegate, UITextFieldDelegate {
//
//
//
//}


