//
//  ZTMVVM.m
//  mvvm
//
//  Created by 钟达烽 on 2022/11/4.
//

#import "ZTMVVM.h"
#import "ZTKVO.h"

@implementation ZTMVVM

static NSKeyValueObservingOptions normalOptions = NSKeyValueObservingOptionNew;

#pragma mark - keyPaths 属性

+ (void)observe:(id)observable on:(UIResponder*)responder notify:(void (^)(id observable,NSString *keyPath)) notify{
    
    [[ZTMVVM GetZTKVO:responder] observe:observable options:normalOptions notify:notify];
}

+ (void)observe:(id)observable on:(UIResponder*)responder keyPaths:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[ZTMVVM GetZTKVO:responder] observe:observable keyPaths:keyPathArray options:normalOptions notify:notify];
}

+ (void)observe:(id)observable on:(UIResponder*)responder keyPathsNot:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[ZTMVVM GetZTKVO:responder] observe:observable keyPathsNot:keyPathArray options:normalOptions notify:notify];
}

#pragma mark - options 属性

+ (void)observe:(id)observable on:(UIResponder*)responder options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[ZTMVVM GetZTKVO:responder] observe:observable options:options notify:notify];
}

#pragma mark - keyPaths 属性 && options 属性

+ (void)observe:(id)observable on:(UIResponder*)responder keyPaths:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[ZTMVVM GetZTKVO:responder] observe:observable keyPaths:keyPathArray options:options notify:notify];
}

+ (void)observe:(id)observable on:(UIResponder*)responder keyPathsNot:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[ZTMVVM GetZTKVO:responder] observe:observable keyPathsNot:keyPathArray options:normalOptions notify:notify];
}

#pragma mark - GetZTKVO
+ (ZTKVO*) GetZTKVO:(UIResponder*)responder{
    
    ZTKVO *ztKVO = [[ZTKVO alloc]init];
    
    if([responder isKindOfClass:[UIViewController class]]){
        
        [ztKVO withController:(UIViewController*)responder];
    }else if([responder isKindOfClass:[UIView class]]){
        
        [ztKVO withView:(UIView*)responder];
    }else{
        NSLog(@"UIResponder does not belong to UIView or UIViewController,ZTMVVM will leak memory!!!");
    }
    return ztKVO;
}

@end
