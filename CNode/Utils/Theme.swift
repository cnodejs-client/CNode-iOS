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

struct Theme {

    static func barTintColor() -> UIColor {
        return UIColor(rgba: "#444")
    }

    struct color {
        
        
        
        
        
        
        // MAKE: Window背景色
        static func windowBackground() -> UIColor {
            return UIColor(rgba: "#ffffff")
        }
        // MAKE: NavigationBar背景色
        static func navigationBarBackground() -> UIColor {
            return UIColor(rgba: "#444")
        }
        // MAKE: TabBar背景色
        static func tabBarBackground() -> UIColor {
            return UIColor(rgba: "#ffffff")
        }
        
        static func separatorColor() -> UIColor {
            return UIColor(rgba: "#e6e7e8")
        }
        
        static func title() -> UIColor {
            return UIColor(rgba: "#494c53")
        }

        static func content() -> UIColor {
            return UIColor(rgba: "#7a7d83")
        }
    }
    
    struct font {
        static func input() -> UIFont {
            return UIFont.systemFontOfSize(15)
        }

        static func title() -> UIFont {
            return UIFont.boldSystemFontOfSize(16)
        }
        
        static func content() -> UIFont {
            return UIFont.systemFontOfSize(14)
        }
        
        static func placeholder() -> UIFont {
            return UIFont.systemFontOfSize(15)
        }
    }
}