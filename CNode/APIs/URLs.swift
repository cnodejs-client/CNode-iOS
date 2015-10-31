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

struct URLs {
    static let baseURL: String = "https://cnodejs.org"
    static let apiVersion: String = "/api/v1"
    static let apiURL = baseURL + apiVersion
    // user
    static let LOGIN: String = baseURL + "/signin"
    static let LOGIN_WITH_GITHUB: String = baseURL + "/auth/github"
    static let FORGOT_PASSWORD: String = baseURL + "/search_pass"
    static let SETTING: String = baseURL + "/setting"
    static let PROFILE: String = apiURL + "/user/"
    // topics
    static let TOPIC_LIST: String = apiURL + "/topics"
    static let TOPIC_DETAIL: String = apiURL + "/topic/"
    // messages
    static let MESSAGE_COUNT: String = apiURL + "/message/count"
    static let MESSAGE_LIST: String = apiURL + "/messages"
    static let MESSAGE_MARK_ALL_AS_READ: String = apiURL + "/messages/mark_all"
}