//
//  ZTNSProxy.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/11.
//

#import "ZTNSProxy.h"

@interface ZTNSProxy()

@property (nonatomic, weak) id object;

@end

@implementation ZTNSProxy

- (instancetype)initWithObjec:(id)object{
    self.object = object;
    return self;
}

+ (instancetype)proxyWithObject:(id)object{
    return [[self alloc] initWithObjec:object];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    if ([self.object respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.object];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.object methodSignatureForSelector:sel];
}

@end
