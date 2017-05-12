
//  Created by Vivek Shinde on 13/02/17.
//  Copyright © 2016 aig. All rights reserved.
//

import UIKit

class AIGColorUtility: UIColor {
    
    // This Class will be used to make all UIColors Functions Uniq In Comlete Applications
    
    class func navigationBartintColor() -> UIColor {
//        return UIColor(red: 43.0/255.0, green: 152.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        return UIColor(red: 47.0/255.0, green: 170.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    }
    
    class func navigationTintColor() -> UIColor {
        return UIColor.white
    }
    
    class func viewBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    class func viewSlidergray() -> UIColor {
        return UIColor.init(colorLiteralRed: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    }
    
    class func viewSliderOrange() -> UIColor {
        return UIColor.init(colorLiteralRed: 255.0/255.0, green: 82.0/255.0, blue: 82.0/255.0, alpha: 1.0)
    }
}
