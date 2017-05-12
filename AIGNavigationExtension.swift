//  Created by Vivek Shinde on 13/02/17.


import UIKit
import Foundation

extension UINavigationController
{
    func makeAIGContainerNavigationBar () {
        self.navigationBar.barTintColor = AIGColorUtility.navigationBartintColor()
        self.navigationBar.tintColor = AIGColorUtility.navigationTintColor()
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: AIGColorUtility.navigationTintColor()]
    }
}
