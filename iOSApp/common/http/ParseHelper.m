//
//  ParseHelper.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "ParseHelper.h"

@implementation ParseHelper

+ (ZTResponse<Class> *)parseResponse:(id)responseObject class:(Class)clazz{
        
    ZTResponse *result = [[ZTResponse alloc] init];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*)responseObject;
        
        result.code = [dict objectForKey:@"errorCode"];//code
        result.msg = [dict objectForKey:@"errorMsg"];//msg

        id data = [dict objectForKey:@"data"];//目标数据
        
        if(clazz == [NSDictionary class]||clazz == [NSArray class]){
            result.data = data;
        }else if ([data isKindOfClass:[NSArray class]]) {
            result.data = [clazz mj_objectArrayWithKeyValuesArray:data];
        }else if ([data isKindOfClass:[NSDictionary class]]){
            result.data = [clazz mj_objectWithKeyValues:data];
        }else if([data isKindOfClass:[NSString class]]){
            result.data = (NSString*)data;
        }
    } else if ([responseObject isKindOfClass:[NSString class]]){
        result.code = @1;//code
        result.data = responseObject;
    }
    
    return result;
}


@end
