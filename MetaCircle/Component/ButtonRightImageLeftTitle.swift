//
//  ButtonRightImageLeftTitle.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/18.
//

import Foundation
import UIKit

class ButtonRightImageLeftTitle: UIButton {

  override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
          var imageFrame = super.imageRect(forContentRect: contentRect)
          imageFrame.origin.x = super.titleRect(forContentRect: contentRect).maxX - imageFrame.width + 6
          return imageFrame
      }

      override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
          var titleFrame = super.titleRect(forContentRect: contentRect)
          if (self.currentImage != nil) {
              titleFrame.origin.x = super.imageRect(forContentRect: contentRect).minX
          }
          return titleFrame
      }
}
