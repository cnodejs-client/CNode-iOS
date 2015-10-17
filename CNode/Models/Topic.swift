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

class Topic: Mappable {
    var id: String?             // Id
    var author_id: String?      // 作者Id
    var tab: String?            // 标签
    var content: String?        // 内容
    var title: String?          // 标题
    var last_reply_at: String?  // 最后回复时间
    var good: Bool = false      // 精华
    var top: Bool = false       // 置顶
    var reply_count: Int = 0    // 回复数
    var visit_count: Int = 0    // 阅读数
    var create_at: String?      // 发表时间
    var author: User?           // 作者
    var replies: [Reply]?       // 评论列表

    init() { }

    required init?(_ map: Map){
    }

    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        author_id       <- map["author_id"]
        tab             <- map["tab"]
        content         <- map["content"]
        title           <- map["title"]
        last_reply_at   <- map["last_reply_at"]
        good            <- map["good"]
        top             <- map["top"]
        reply_count     <- map["reply_count"]
        visit_count     <- map["visit_count"]
        create_at       <- map["create_at"]
        author          <- map["author"]
        replies         <- map["replies"]
    }
}
