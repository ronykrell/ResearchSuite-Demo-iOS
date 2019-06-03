//
//  RSLabel.swift
//  ResearchSuiteExtensions
//
//  Created by James Kizer on 1/15/18.
//

import UIKit
import ResearchKit

@objc
open class RSLabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.init_RSLabel()
    }

    public init() {
        super.init(frame: CGRect())
        self.init_RSLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.init_RSLabel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func init_RSLabel() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateAppearance),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
        
        self.updateAppearance()
        
    }
    
    open func shouldUpdateAppearance() -> Bool {
        return self.attributedText == nil
    }
    
    @objc open func updateAppearance() {
        if self.shouldUpdateAppearance() {
            self.font = self.defaultFont
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override open func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        self.updateAppearance()
    }
    
    open var defaultFont: UIFont {
        // regular, 14
        return RSFonts.computeFont(startingTextStyle: UIFont.TextStyle.caption1, defaultSize: 12.0, typeAdjustment: 14.0)
    }
    
}
