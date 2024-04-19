import Foundation
import UIKit

@available(iOS 13.0, *)
@objc(MemojiKeyboardViewManager)
class MemojiKeyboardViewManager: RCTViewManager {

  override func view() -> (MemojiKeyboardViewProxy) {
    return MemojiKeyboardViewProxy()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

