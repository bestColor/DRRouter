#import "DRRouter.h"
#import <objc/runtime.h>
#import "objc/message.h"

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
    if (self.routerMap == nil) {
        self.routerMap = hostKeyValue;
    } else {
        NSMutableDictionary *endRouterMap = self.routerMap.mutableCopy;
        [endRouterMap addEntriesFromDictionary:hostKeyValue];
        self.routerMap = endRouterMap;
    }
}

+ (instancetype)sharedInstance {
    static DRRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (UIViewController *)router:(NSString *)URL {
    return [[DRRouter sharedInstance] pathComponentsFromURL:URL];
}

+ (void)sendMessage:(id)target action:(NSString *)action param:(NSString * _Nullable)param {
    if (param.length) {
        NSString *newAction = action;
        if ([action hasSuffix:@":"] == false) {
            newAction = [NSString stringWithFormat:@"%@:",action];
        }
        ((void (*)(id, SEL, NSString *))objc_msgSend)(target, NSSelectorFromString(newAction), param);
    } else {
        ((void (*)(id, SEL))objc_msgSend)(target, NSSelectorFromString(action));
    }
}

- (UIViewController *)pathComponentsFromURL:(NSString *)URL {
    if (!URL) {
        NSAssert(0, @"URL协议为空，解析失败");
        return [UIViewController new];
    }
    
    NSArray *protocols = [self pathSehments:URL];
    NSString *protocol = [protocols objectAtIndex:0];
    
    NSLog(@"scheme协议 = %@ - %@", protocol, [protocol isEqualToString:@"ylh"] ? @"外部app唤醒" : @"组件间调用");
    
    NSString *host = [protocols objectAtIndex:1];
    
    UIViewController *toVC = [self getViewControllerFromHost:host];
    [self paramVC:toVC paramenters:[self queryItems:URL]];
    
    return toVC;
}

- (UIViewController *)getViewControllerFromHost:(NSString *)host {
    if (host.length <= 0) {
        NSAssert(0, @"host的key为空");
        return [UIViewController new];
    }
    
    Class aClass = NSClassFromString(self.routerMap[host]);
    if (aClass) {
        return [[aClass alloc] init];
    } else {
        NSAssert(0, @"该host的key未注册,请先调用注册函数并且设置keyValue");
    }
    
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

@end
