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

import ObjectMapper
import Ono
import SwiftyJSON

class User: Mappable {
    var loginname: String?      // 用户名
    var email: String?          // 邮箱
    var homepage: String?       // 个人主页
    var avatar_url: String?     // 头像
    var githubUsername: String? // 绑定的GitHub账号
    var create_at: String?      // 注册日期
    var score: Int = 0          // 积分
    var token: String?          // Token
    
    init() { }

    required init?(_ map: Map){
    }

    // Mappable
    func mapping(map: Map) {
        loginname       <- map["loginname"]
        email           <- map["email"]
        homepage        <- map["homepage"]
        avatar_url      <- map["avatar_url"]
        githubUsername  <- map["githubUsername"]
        create_at       <- map["create_at"]
        score           <- map["score"]
        token           <- map["token"]
        
        if (avatar_url!.hasPrefix("//gravatar.com")) {
            avatar_url = "http:\(avatar_url!)"
        }
    }
    
    static func current() -> User? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let jsonString = userDefaults.stringForKey("__current_user")
        if (jsonString != nil && jsonString != "") {
            let user: User? = Mapper<User>().map(jsonString!)
            return user
        }
        return nil
    }
    
    static func current(user: User?) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let jsonString = user == nil ? "" : Mapper<User>().toJSONString(user!, prettyPrint: false)
        userDefaults.setValue(jsonString, forKey: "__current_user")
    }
    
    static func isLogged() -> Bool {
        let user: User? = current()
        if (user != nil) {
            return true
        }
        return false;
    }
}
