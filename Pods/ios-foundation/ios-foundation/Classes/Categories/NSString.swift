
import Foundation

public extension NSString {
    
    // FIXME: Debug only
   public func babylonBotErrorMsg(error: NSError) -> NSString {
        if error.localizedFailureReason?.characters.count > 0 {
            return error.localizedFailureReason!
        } else if error.localizedDescription.characters.count > 0 {
            return error.localizedDescription
        } else {
            if error.description.characters.count > 0 {
                return error.description
            } else {
                return "I don't get it. Sorry"
            }
        }
    }
    
    
//    public func babylonBadgeCounter(messages:NSArray) -> String {
//        var count = 0
//        for message: JSQMessages in messages {
//            if message.senderId == BBConstants.kBabylonDoctorId {
//                count++
//            }
//        }
//        return NSString.localizedStringWithFormat("%i", count)
//    }
//
//    + (NSString *)babylonBadgeCounter:(NSArray *)messages {
//    int count = 0;
//    for (JSQMessage *message in messages) {
//    if (message.senderId == kBabylonDoctorId) {
//    count++;
//    }
//    }
//    return [NSString stringWithFormat:@"%i", count];
//    }

    
}