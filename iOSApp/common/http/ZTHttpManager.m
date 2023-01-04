//
//  ZTHttpManager.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "ZTHttpManager.h"
#import "ParseHelper.h"
#import "HttpConfig.h"

@implementation ZTHttpManager


static id _instance;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((self == [super init])) {
            //加载所需资源
       }
    });
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (void)get:(NSString *)URLString parseClass:(Class)clazz success:(void (^)(id response))successBlock error:(void (^)(NSNumber *code,NSString *msg))errorBlock{
    
    [self get:URLString parameters:@{} parseClass:clazz success:successBlock error:errorBlock];
}

- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters parseClass:(Class)clazz success:(void (^)(id response))successBlock error:(void (^)(NSNumber *code,NSString *msg))errorBlock{
    
    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:0];
    NSString *parametersString = [[NSString alloc] initWithData:parametersData encoding:NSUTF8StringEncoding];
    
    URLString = [[HttpConfig sharedHttpConfig].baseUrl stringByAppendingString:URLString];

    NSLog(@"Request-get:%@",parametersString);
    
    ///底层使用 AFNetworking
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"Respone-success:%@",(NSString *)responseObject);
        
        ZTResponse *ztResponse= [ParseHelper parseResponse:responseObject class:clazz];
        if([ztResponse.code isEqual:@0]){//成功
            successBlock(ztResponse.data);//调用block
        }else{//失败
            errorBlock(ztResponse.code,ztResponse.msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSNumber *code = [NSNumber numberWithInteger:error.code];
        NSString *msg = error.userInfo[@"NSLocalizedDescription"];
        
        NSLog(@"Respone-error>>>code:%@",code);
        NSLog(@"Respone-error>>>msg:%@",msg);

        errorBlock(code,msg);
    }];
    
}

- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters parseClass:(Class)clazz success:(void (^)(id response))successBlock error:(void (^)(NSNumber *code,NSString *msg))errorBlock{
    
    
    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:0];
    NSString *parametersString = [[NSString alloc] initWithData:parametersData encoding:NSUTF8StringEncoding];
    
    URLString = [[HttpConfig sharedHttpConfig].baseUrl stringByAppendingString:URLString];
    
    NSLog(@"Request-post:%@",parametersString);
    
    ///底层使用 AFNetworking
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"Respone-success:%@",(NSString *)responseObject);
        
        ZTResponse *ztResponse= [ParseHelper parseResponse:responseObject class:clazz];
        if([ztResponse.code isEqual:@1]){//成功
            successBlock(ztResponse.data);//调用block
        }else{//失败
            errorBlock(ztResponse.code,ztResponse.msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSNumber *code = [NSNumber numberWithInteger:error.code];
        NSString *msg = error.userInfo[@"NSLocalizedDescription"];
        
        NSLog(@"Respone-error>>>code:%@",code);
        NSLog(@"Respone-error>>>msg:%@",msg);

        errorBlock(code,msg);
    }];
    
}

@end
