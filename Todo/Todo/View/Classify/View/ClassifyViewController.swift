//
//  ClassifyViewController.swift
//  Todo
//
//  Created by 김수경 on 7/7/24.
//

import UIKit

final class ClassifyViewController: UIViewController {
    
    private let viewModel = ClassifyViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var addNewTodoButton = {
        let view = UIButton()
        
        view.setTitle("새로운 할일", for: .normal)
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        return view
    }()
    
    private var addNewClassifyType = {
        let view = UIButton()
        
        view.setTitle("목록 추가", for: .normal)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoDataRepository().printURLPath()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureAction()
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(addNewTodoButton)
        view.addSubview(addNewClassifyType)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        addNewTodoButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(safeArea).inset(8)
        }
        
        addNewClassifyType.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeArea).inset(8)
        }

        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeArea).inset(8)
            make.bottom.equalTo(addNewTodoButton.snp.top).offset(-8)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        configureCollectionView()
        configureNavigation()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(ClassifyCollectionViewCell.self, forCellWithReuseIdentifier: ClassifyCollectionViewCell.reuseIdentifier)
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white

        navigationItem.title = "전체"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func configureAction() {
        addNewTodoButton.addTarget(self, action: #selector(addNewTodoButtonTapped), for: .touchUpInside)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (width - 30) / 2, height: (width - 30) / 4)
        
        return layout
    }
    
    @objc
    private func addNewTodoButtonTapped() {
        let vc = AddNewTodoViewController()
        vc.dismissAction = {
            let listVM = TodoListViewModel(.all)
            let listVC = TodoListViewController(listVM)
            
            self.navigationController?.pushViewController(listVC, animated: false)
        }
        
        let navController = UINavigationController(rootViewController: vc)
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc
    private func calendarButtonTapped() {
        let vc = CalendarViewController()
        
        navigationController?.pushViewController(vc, animated: false)
    }
}


extension ClassifyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifyCollectionViewCell.reuseIdentifier, for: indexPath) as? ClassifyCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setContents(ClassifyTodo.allCases[indexPath.row], itemCount: viewModel.todoCount?[indexPath.row] ?? 0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = TodoListViewModel(ClassifyTodo.allCases[indexPath.row])
        let vc = TodoListViewController(vm)
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
