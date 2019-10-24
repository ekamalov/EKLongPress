//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

internal let screen = UIScreen.main.bounds

internal extension UIView {
    var circlerBorder: Bool {
        get { return  layer.cornerRadius == 0 ? false : true }
        set { layer.cornerRadius = newValue ? max(bounds.size.width, bounds.size.height) / 2 : 0 }
    }
    
    var borderWidth: CGFloat{
        get { return layer.borderWidth }
        set{
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func addSubviews(_ views:UIView...){
        views.forEach { addSubview($0) }
    }
}

internal extension Array {
    subscript(safety index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

internal extension CGFloat {
    var toRadians: CGFloat {
        return self * (.pi / 180.0)
    }
    var toDegrees: CGFloat {
        return self * CGFloat(180.0 / .pi)
    }
}

// MARK: - Builder, you can look documentation in GitHub(https://github.com/erikkamalov/EKBuilder.git)
internal protocol Builder {
    init()
}
extension Builder {
    public static func build(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = Self.self.init()
        try block(&copy)
        return copy
    }
}

extension NSObject: Builder {}

internal enum Haptic {
    case impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(style: UINotificationFeedbackGenerator.FeedbackType)
    case selection
    
    func impact(){
        switch self {
        case .impact(style: let style):
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        case .notification(style: let style):
            let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
            notificationFeedbackGenerator.notificationOccurred(style)
        default:
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
}
