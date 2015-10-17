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

import SVProgressHUD

class HUD {

    // MAKE: 显示处理中HUD消息
    static func showProcessing(string: String) {
        SVProgressHUD.showWithStatus(string)
    }

    // MAKE: 显示成功HUD消息
    static func showSuccess(string: String) {
        SVProgressHUD.showSuccessWithStatus(string)
    }
    
    // MAKE: 显示失败HUD消息
    static func showError(string: String) {
        SVProgressHUD.showErrorWithStatus(string)
    }
    
    // MAKE: 显示信息HUD消息
    static func showInfo(string: String) {
        SVProgressHUD.showInfoWithStatus(string)
    }
}
