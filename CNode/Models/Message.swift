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

class Message: Mappable {
    var id: String?             // Id
    var type: String?           // 类型
    var has_read: Bool?         // har_read
    var author: User?           // 作者
    var topic: Topic?           // 话题
    var reply: Reply?           // 回复

    init() { }

    required init?(_ map: Map){
    }

    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        has_read        <- map["has_read"]
        author          <- map["author"]
        topic           <- map["topic"]
        reply           <- map["reply"]
    }
}
