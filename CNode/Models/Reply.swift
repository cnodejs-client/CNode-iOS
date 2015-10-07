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

class Reply: Mappable {
    var id: String?             // Id
    var content: String?        // 内容
    var ups: [String]?          // ups
    var create_at: String?      // 发表时间
    var author: User?           // 作者
    
    init() { }
    
    required init?(_ map: Map){
    }
    
    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        content         <- map["content"]
        ups             <- map["ups"]
        create_at       <- map["create_at"]
        author          <- map["author"]
    }
}
