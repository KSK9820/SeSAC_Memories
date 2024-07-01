//
//  NasaViewController.swift
//  0604
//
//  Created by 김수경 on 7/1/24.
//

import UIKit

final class NasaViewController: UIViewController {
    
    private lazy var networkManager: NasaNetworkManager! = {
            return NasaNetworkManager(delegate: self)
        }()
    
    private let nasaImageView = UIImageView()
    private let progressLabel: UILabel = {
        let view = UILabel()
        
        view.backgroundColor = .gray
        view.textColor = .white
        
        return view
    }()
    
    private let requestButton: UIButton = {
        let view = UIButton()
       
        view.backgroundColor = .black
        view.setTitle("나사 이미지 로드", for: .normal)
        view.setTitleColor(.white, for: .normal)
        
        return view
    }()
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            if let buffer {
                let result = String(format: "%.1f", Double(buffer.count) / total * 100)
                progressLabel.text = "\(result) / 100"
            } else {
                progressLabel.text = "\(0) / 100"
            }
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 1. 화면이 사라진다면 네트워크 통신도 바로 함께 중단
        // 다운로드 중인 리소스도 무시
        networkManager.invalidateAndCancel()
        
        // 2. 다운로드가 완료될 때까지 기다렸다가, 다운로드가 완료되면 리소스 정리
        networkManager.finishTasksAndInvalidate()
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.layoutMarginsGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    func configureUI() {
        requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func requestButtonTapped() {
        buffer = Data()
        networkManager.callRequest()
        requestButton.isUserInteractionEnabled = false
    }
    
}


extension NasaViewController: URLSessionDataDelegate {
    // response
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse,
           (200..<300).contains(response.statusCode) {
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length"),
                  let contentLengthValue = Double(contentLength) else {
                return .cancel
            }
            
            total = contentLengthValue
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    // data
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    
    // error
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if error != nil {
            progressLabel.text = "문제 발생"
            nasaImageView.image = UIImage(systemName: "star")
        } else {
            guard let buffer = buffer else { return }
            nasaImageView.image = UIImage(data: buffer)
            
        }
        requestButton.isUserInteractionEnabled = true
    }
        
}
