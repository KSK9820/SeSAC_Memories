//
//  LottoLabel.swift
//  0604
//
//  Created by 김수경 on 6/5/24.
//

import UIKit 

final class InsetLabel: UILabel {
    
    struct PaddingLabel {
        var topInset: CGFloat
        var bottomInset: CGFloat
        var leadingInset: CGFloat
        var trailingInset: CGFloat
    }
    
    private var labelPadding: PaddingLabel
    
    
    // MARK: - Initialize

    convenience init(topInset: CGFloat = 8.0, bottomInset: CGFloat = 8.0, leadingInset: CGFloat = 8.0, trailingInset: CGFloat = 8.0) {
        let padding = PaddingLabel(topInset: topInset, bottomInset: bottomInset, leadingInset: leadingInset, trailingInset: trailingInset)
        self.init(labelPadding: padding)
        self.textColor = .white
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.textAlignment = .center
        self.clipsToBounds = true
    }
    
    init(labelPadding: PaddingLabel) {
        self.labelPadding = labelPadding
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - override method

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: labelPadding.topInset,
                                       left: labelPadding.leadingInset,
                                       bottom: labelPadding.bottomInset,
                                       right: labelPadding.trailingInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        return CGSize(width: size.width + labelPadding.leadingInset + labelPadding.trailingInset,
                      height: size.height + labelPadding.topInset + labelPadding.bottomInset)
    }
    
}
