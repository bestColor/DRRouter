#import "DRRouter.h"
#import <objc/runtime.h>

@interface DRRouter()

@property (nonatomic, strong) NSArray *pathComponents;

@property (nonatomic, strong) NSDictionary *routerMap;

@end

@implementation DRRouter
/** 注册组件之间跳转 Map */
+ (void)registerHost:(NSDictionary *)hostKeyValue {
    [[self sharedInstance] registerHostKeyValue:hostKeyValue];
}

- (void)registerHostKeyValue:(NSDictionary *)hostKeyValue {
    self.routerMap = hostKeyValue;
}

+ (instancetype)sharedInstance
{
    static DRRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)router:(NSString *)URL {
    [[DRRouter sharedInstance] pathComponentsFromURL:URL];

}

- (void)pathComponentsFromURL:(NSString *)URL {
    if (!URL) {
        NSAssert(1, @"URL协议为空，解析失败");
        return;
    }
    
    NSArray *protocols = [self pathSehments:URL];
    NSString *protocol = [protocols objectAtIndex:0];
    NSString *host = [protocols objectAtIndex:1];
    
    UIViewController *toVC = [self getViewControllerFromHost:host];
    [self paramVC:toVC paramenters:[self queryItems:URL]];
        
    if ([protocol isEqualToString:@"push"]) {
        [self pushViewController:toVC];
    } else if ([protocol isEqualToString:@"present"]) {
        [self presentViewController:toVC];
    } else {
        NSAssert(1, @"URL协议错误，暂只支持push和present协议");
    }
}

- (UIViewController *)getViewControllerFromHost:(NSString *)host {
    if (host.length <= 0) {
        return [UIViewController new];
    }
    
    Class aClass = NSClassFromString(self.routerMap[host]);
    if (aClass) return [[aClass alloc] init];
    
    aClass = NSClassFromString(host);
    if (aClass) return [[aClass alloc] init];
    
    return [UIViewController new];
}

// 参数解析 -- 非纯数字可以解析
- (NSMutableDictionary *)queryItems:(NSString *)URL {
    
    NSURL *paramURL = [NSURL URLWithString:URL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:paramURL resolvingAgainstBaseURL:NO];
    
    // url中参数的key value
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in urlComponents.queryItems) {
        [parameter setValue:item.value forKey:item.name];
    }
    return parameter;
}

- (NSArray *)pathSehments:(NSString *)url {
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([url rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [url componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        // 如果只有协议，那么放一个占位符
        url = pathSegments.lastObject;
        if (!url.length) {
            [pathComponents addObject:@"push"]; // 如果协议为空 则赋值为占位符
        }
    }
    
    for (NSString *pathComponent in [[NSURL URLWithString:url] pathComponents]) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}

#pragma mark - 通过runtime给目标类的属性赋值
- (void)paramVC:(UIViewController *)vc paramenters:(NSDictionary * _Nullable)paramenters {
    // runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(vc.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = paramenters[key];
        if (param != nil) {
            [vc setValue:param forKey:key];
        }
    }
}

#pragma - 跳转方法
- (void)pushViewController:(UIViewController *)viewController  {
    [[self getCurrentVC].navigationController pushViewController:viewController animated:YES];
}

- (void)presentViewController:(UIViewController *)viewController {
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self getCurrentVC] presentViewController:viewController animated:YES completion:^{
        
    }];
}

- (UIViewController *)getCurrentVC {
    //1. 先找到KeyWindow
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //2. 正常情况下KeyWindow应该是在UIWindowLevelNormal,有Alert的时候KeyWindow就是Alert框
    if (window.windowLevel != UIWindowLevelNormal)
    {
        //3. 如果不是UIWindowLevelNormal,那么找到UIWindowLevelNormal级别的Window
        // 这里有个缺陷,因为UIWindowLevelNormal的不一定只有一个,虽然正常情况下只有一个
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                //找到了UIWindowLevelNormal的Window
                window = tmpWin;
                break;
            }
        }
    }
    //4. 判断RootViewController不是TabBarVC和NaviVC,且是ViewController
    id result = window.rootViewController;
    BOOL isViewController = ![result isKindOfClass:[UITabBarController class]] && ![result isKindOfClass:[UINavigationController class]] && [result isKindOfClass:[UIViewController class]];
    //5. 进入递归循环,排除TabBarVC和NaviVC,以及进入PresentedVC继续递归
    while (!isViewController) {
        while ([result isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tempVC = result;
            result = [tempVC selectedViewController];
        }
        while ([result isKindOfClass:[UINavigationController class]]) {
            UINavigationController *tempVC = result;
            result = [tempVC.viewControllers lastObject];
        }
        id presentedVC = [result presentedViewController];
        if (presentedVC) {
            result = presentedVC;
        }
        isViewController = ![result isKindOfClass:[UITabBarController class]] && ![result isKindOfClass:[UINavigationController class]] && [result isKindOfClass:[UIViewController class]];
    }

    return result;
}

@end
