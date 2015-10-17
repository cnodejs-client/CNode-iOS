/**
 * Copyright (C) 2015 JianyingLi
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

enum ButtonStyle {
	case Default    // 默认
	case Primary    // 首选项
	case Success    // 成功
	case Info       // 一般信息
    case Warning    // 警告
	case Danger     // 危险
	case Link       // 链接
}

extension UIButton {

    convenience init(frame: CGRect, style: ButtonStyle) {
        self.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1
        
        var backgroundColor: UIColor?
        var borderColor: UIColor?
        
        switch (style) {
        case .Default:
            backgroundColor = UIColor(rgba: "#ffffff")
            borderColor = UIColor(rgba: "#cccccc")
            break
        case .Primary:
            backgroundColor = UIColor(rgba: "#337ab7")
            borderColor = UIColor(rgba: "#2e6da4")
            break
        case .Success:
            backgroundColor = UIColor(rgba: "#5cb85c")
            borderColor = UIColor(rgba: "#4cae4c")
            break
        case .Info:
            backgroundColor = UIColor(rgba: "#5bc0de")
            borderColor = UIColor(rgba: "#46b8da")
            break
        case .Warning:
            backgroundColor = UIColor(rgba: "#f0ad4e")
            borderColor = UIColor(rgba: "#eea236")
            break
        case .Danger:
            backgroundColor = UIColor(rgba: "#d9534f")
            borderColor = UIColor(rgba: "#d43f3a")
            break
        case .Link:
            backgroundColor = UIColor.clearColor()
            borderColor = UIColor.clearColor()
            break
        }
        if (backgroundColor != nil) {
            self.layer.backgroundColor = backgroundColor?.CGColor
        }
        if (borderColor != nil) {
            self.layer.borderColor = borderColor?.CGColor
        }
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
    }
}
