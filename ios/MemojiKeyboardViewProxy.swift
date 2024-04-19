import Foundation
import SwiftUI
import UIKit

@available(iOS 13.0, *)
class MemojiKeyboardViewProxy: UIView {
  var returningView: UIView?

  @objc var onChosen: RCTBubblingEventBlock = {_ in}

  override init(frame: CGRect) {
    super.init(frame: frame)
    let vc = UIHostingController(rootView: MemojiKeyboardView(onChosen: { [weak self] data in self?.onChosen(data)}))
    vc.view.frame = bounds
    self.addSubview(vc.view)
    self.returningView = vc.view
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.returningView?.frame = bounds
  }
}
