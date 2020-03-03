#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRRouter : NSObject
/** 本类只用于组件之间的跳转。       -   组件回调机制暂时用通知来处理。（例如登录成功后的回调给调用他的界面）
   URL协议
   e.g. push://viewControllerKey?key1=valu1&key2=valu2
   e.g. present://viewControllerKey?key1=valu1&key2=valu2
*/
+ (void)router:(NSString *)URL;

@end

NS_ASSUME_NONNULL_END
