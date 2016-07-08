
import UIKit

public extension UIApplication {
    
    public func registerBabylonForNotifications() -> Void {

        // TODO: Add custom sound
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        self.registerUserNotificationSettings(pushNotificationSettings)
        self.registerForRemoteNotifications()

    }
    
}