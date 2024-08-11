//
//  DetailViewController.swift
//  AppStoreProject
//
//  Created by 김수경 on 8/12/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let thumbnailImage = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
    }
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
    }
    private let companyLabel = UILabel().then {
        $0.textColor = .gray
    }  
    private let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 15
    }
    
    private let horStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    private let verStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .leading
    }
    private let newLabel = UILabel().then {
        $0.text = "새로운 소식"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    private let version = UILabel().then {
        $0.textColor = .lightGray
    }
    private let newContent = UILabel().then {
        $0.numberOfLines = 0
    }
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: screenshotCollectionView())
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
    }

    
    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [horStackView, newLabel, version, newContent, collectionView, descriptionLabel].forEach { view in
            contentView.addSubview(view)
        }
        [thumbnailImage, verStackView].forEach { view in
            horStackView.addArrangedSubview(view)
        }
        [titleLabel, companyLabel, downloadButton].forEach { view in
            verStackView.addArrangedSubview(view)
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(safeArea)
        }
        horStackView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
        thumbnailImage.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        downloadButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        newLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(8)
        }
        version.snp.makeConstraints { make in
            make.top.equalTo(newLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        newContent.snp.makeConstraints { make in
            make.top.equalTo(version.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().offset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(newContent.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().offset(8)
            make.height.equalTo(UIScreen.main.bounds.height * 0.6)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        thumbnailImage.kf.setImage(with: viewModel.thumbnailImageUrl)
        titleLabel.text = viewModel.appData.trackCensoredName
        companyLabel.text = viewModel.appData.artistName
        version.text = viewModel.version
        newContent.text = viewModel.appData.releaseNotes
        
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
    
        descriptionLabel.text = viewModel.appData.description
    }
    
    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.urlString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.reuseIdentifier, for: indexPath) as? ScreenshotCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setImage(viewModel.urlString[indexPath.row])
        
        return cell
    }
    
    
}
