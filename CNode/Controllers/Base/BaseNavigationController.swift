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

public enum BackBarButtonStyle {
    case Close
    case Cancel
    case Back
    case None
}

class BaseNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers.append(rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.translucent = false
        self.navigationBar.barTintColor = Theme.barTintColor()
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
}
