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

import Alamofire
import SwiftyJSON
import ObjectMapper
import Ono

class ApiClient {
    static let PAGE_SIZE: Int = 20
    
    static func isError(error: ErrorType?, failure: (code: Int, message: String) -> Void) -> Bool {
        if (error != nil) {
            failure(code: -1, message: "网络发生异常")
            return true
        }
        return false
    }

    static func _csrf(success: (data:String) -> Void, failure: (code:Int, message:String) -> Void) {
        Alamofire.request(.GET, URLs.LOGIN)
        .responseString {
            (request, response, result) -> Void in
            let html = result.value!
            let body: ONOXMLDocument = self.body(html, begin: "<form id='signin_form' class='form-horizontal' action='/signin' method='post'>", end: "</form>")
            // 在登录页面找到 name="_csrf" 的input标签（ONO好像不能像jQuery那样去快速查找）
            let _csrfElement = body.rootElement.firstChildWithTag("input")
            print(_csrfElement)
            let _csrf: String = _csrfElement.attributes["value"] as! String
            success(data: _csrf)
        }
    }

    // MAKE: 用户登录
    static func login(username: String, password: String, success: (data: User) -> Void, failure: (code: Int, message: String) -> Void) {
        let _csrf_success = {
            (data: String) -> Void in

            let parameters: [String:AnyObject] = [
                "name": username,
                "pass": password,
                "_csrf": data
            ]
            Alamofire.request(.POST, URLs.LOGIN, parameters: parameters)
                .responseString {
                    (request, response, result) -> Void in
                    // 请求是否发生错误
                    if (isError(result.error, failure: failure)) {
                        return
                    }
                    // 如果response.URL为 https://cnodejs.org/ 则代表登录成功
                    if (response?.URL?.URLString == URLs.baseURL + "/") {
                        // TODO: 获取Token及用户信息
                        myProfile(success, failure: failure)
                        return
                    }
                    failure(code: -1, message: "用户名或密码错误")
            }
        };
        _csrf(_csrf_success, failure: failure)
    }
    
    // 获取Token
    static func myProfile(success: (data: User) -> Void, failure: (code: Int, message: String) -> Void) {
        Alamofire.request(.GET, URLs.SETTING)
            .responseString {
                (request, response, result) -> Void in
                
                let html = result.value!
//                print(html)
                // 用户信息
                let _profileElement = self.body(html, begin: "<form id='setting_form' class='form-horizontal' action='/setting' method='post'>", end:"</form>")
//                print(_profileElement)
                // Token
                let _tokenElement = self.body(html, begin: "<div id='content'>", end: "</div>")
//                print(_tokenElement)
                let _tokenStr = _tokenElement.rootElement.children[2][1][0]
                let user: User = User()
                user.loginname = _profileElement.rootElement.children[0][1][0].attributes["value"] as? String
                user.email = _profileElement.rootElement.children[1][1][0].attributes["value"] as? String
                user.homepage = _profileElement.rootElement.children[2][1][0].attributes["value"] as? String
                user.githubUsername = _profileElement.rootElement.children[5][1][0].attributes["value"] as? String
                user.token = _tokenStr.stringValue
                user.token = user.token!.stringByReplacingOccurrencesOfString("字符串：", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                user.token = user.token!.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                user.token = user.token!.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                User.current(user)
                success(data: user)
        }
    }
    // MAKE: 主题列表
    static func topicList(page: Int, tab: String, success: (data:[Topic]) -> Void, failure: (code:Int, message:String) -> Void) {
        // 类别ID 1-问答 2-分享 3-IT杂烩(综合) 4-站务 100-职业生涯 0-所有
        let parameters: [String: AnyObject] = [
            "tab": tab,
            "page": page,
            "limit": PAGE_SIZE
        ]
        Alamofire.request(.GET, URLs.TOPIC_LIST, parameters: parameters)
            .responseJSON {
                (request, response, result) -> Void in
                // 请求是否发生错误
                if (isError(result.error, failure: failure)) {
                    return
                }
//                let json = JSON(result.value!)
//                print(json)

                let topics = Mapper<Topic>().mapArray(result.value!["data"])
                success(data: topics!)
        }
    }

    // MAKE: 获取html页面的body部分
    static func body(html: String, begin: String, end: String) -> ONOXMLDocument {
        let exp = try! NSRegularExpression(pattern: "\(begin)[\\s\\S]*\(end)", options: NSRegularExpressionOptions.CaseInsensitive)
        let matches = exp.firstMatchInString(html as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, html.characters.count))
        print(matches?.range)
        let _html: NSString = (html as NSString).substringWithRange(matches!.range)
//        print(html)
        return try! ONOXMLDocument(string: _html as String, encoding: NSUTF8StringEncoding)
    }
    
}