import Foundation
import UIKit

@objc(MemojiKeyboardViewManager)
class MemojiKeyboardViewManager: RCTViewManager {

  override func view() -> (MemojiKeyboardViewProxy) {
    return MemojiKeyboardViewProxy()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

