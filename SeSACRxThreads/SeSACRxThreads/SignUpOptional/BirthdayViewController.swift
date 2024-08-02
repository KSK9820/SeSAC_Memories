//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
//        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
//        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
//        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
    let signInValid =  BehaviorRelay(value: false)
    let ageValidText = BehaviorRelay(value: "만 17세 이상만 가입 가능합니다.")
    
    let year = PublishRelay<String>()
    let month = PublishRelay<String>()
    let day = PublishRelay<String>()
    let age = PublishRelay<Int>()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
    }
    

    private func bind() {
       
        ageValidText
            .bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        year
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        month
            .bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        day
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        signInValid
            .bind(with: self) { owner, value in
                owner.ageValidText.accept(value ? "가입 가능한 나이입니다" : "만 17세 이상만 가입 가능합니다")
                let buttonColor: UIColor = value ? .systemPink : .gray
                let labelColor: UIColor = value ? .gray : .systemPink
                owner.nextButton.backgroundColor = buttonColor
                owner.infoLabel.textColor = labelColor
                
                owner.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .bind(with: self) { owner, value in
                let component = Calendar.current.dateComponents([.day, .month, .year], from: value)
                let today = Calendar.current.dateComponents([.day, .month, .year], from: Date())
                let age = Calendar.current.dateComponents([.year], from: component, to: today)
                
                if age.year! >= 17 {
                    owner.signInValid.accept(true)
                } else {
                    owner.signInValid.accept(false)
                }
                
                owner.year.accept("\(component.year!)년")
                owner.month.accept("\(component.month!)월")
                owner.day.accept("\(component.day!)일")
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SearchViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    

    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
