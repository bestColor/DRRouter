#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 e.g.
 - (void)testEg {
     [DRRouter registerHost:@{@"two":@"TwoViewController"}];
     UIViewController *vc = [DRRouter router:@"path://two?text=abc&textId=13"];
     [vc setValue:[UIImage imageNamed:@"LanchImagebg01"] forKey:@"aa"];
     [self presentViewController:vc animated:YES completion:nil];
     
     [DRRouter sendMessage:vc action:@"abc" param:nil];
     [DRRouter sendMessage:vc action:@"abc:" param:@"哈哈"];
     [DRRouter sendMessage:vc action:@"abc" param:@"嘿嘿"];
 }
 */

NS_ASSUME_NONNULL_BEGIN

@interface DRRouter : NSObject
/**
    注册组件之间跳转 Map
    @param hostKeyValue e.g. @{@"login":@"LoginViewController"}
 */
+ (void)registerHost:(NSDictionary *)hostKeyValue;


/**
    本类只用于组件之间的跳转（跳转之前请先注册)
 
    外部app唤醒。URL协议 ylh-scheme(后续根据需要实现）
    e.g. ylh://viewControllerKey?key1=valu1&key2=valu2
 
    组件间调用。URL协议 path-scheme
    e.g. path://viewControllerKey?key1=valu1&key2=valu2
*/
+ (UIViewController *)router:(NSString *)URL;


/**
    通过runtime发送方法执行(可以用于正向调用和反向调用)
 */
+ (void)sendMessage:(id)target action:(NSString *)action param:(NSString * _Nullable)param;

@end

NS_ASSUME_NONNULL_END
