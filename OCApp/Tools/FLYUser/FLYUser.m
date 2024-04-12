//
//  FLYUser.m
//  ProvideAged
//
//  Created by fly on 2021/9/15.
//


/**
 登录之后的用户信息，不使用解归档的方式保存的原因是：
 归档保存的路径是沙盒的文件夹，还要专门维护文件夹，如果清空缓存的功能，没有排除这个文件夹，或者被误删了，
 用户信息就会丢失，此时请求接口要用到用户信息，就取不到了。
 所以我们用了用户偏好来保存了用户信息。
 
 （虽然清空缓存一般只清空Cache文件夹，我们可以把文件保存在Documents目录下，但如果Documents里面东西放的多了，也是想清理一下的，这时候归档的文件还是有误删的风险）
 */


#import "FLYUser.h"
#import <objc/runtime.h>

@implementation FLYUser

#pragma mark - 单利 

static FLYUser * _sharedUser;

+ (instancetype)sharedUser
{
    if ( _sharedUser == nil )
    {
        _sharedUser = [[self alloc] init];
        
        
        /**
         遍历所有成员变量，取出NSUserDefaults的值赋值给成员变量。
         */
        
        //通过runtime遍历所有成员变量名
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);

        for (int i = 0; i < count; i++ )
        {
            Ivar ivar = ivars[i];

            //获取成员变量的名字
            const char * c_name = ivar_getName(ivar);
            NSString * name = [NSString stringWithUTF8String:c_name];
            
            //获取成员变量的类型
            const char * c_type = ivar_getTypeEncoding(ivar);
            NSString * type = [NSString stringWithUTF8String:c_type];
            
            
            //根据不同的类型，给成员变量赋值
            
            //q代表long、longlong、NSInteger，Q代表无符号的long、longlong、NSInteger，i代表int，s代表short
            if ( [type isEqualToString:@"q"] || [type isEqualToString:@"Q"] || [type isEqualToString:@"i"] || [type isEqualToString:@"s"] )
            {
                NSInteger integer = [[NSUserDefaults standardUserDefaults] integerForKey:name];
                [[self sharedUser] setValue:@(integer) forKey:name];
            }
            else if ( [type isEqualToString:@"f"] )
            {
                float f = [[NSUserDefaults standardUserDefaults] floatForKey:name];
                [[self sharedUser] setValue:@(f) forKey:name];
            }
            else if ( [type isEqualToString:@"d"] )
            {
                double d = [[NSUserDefaults standardUserDefaults] doubleForKey:name];
                [[self sharedUser] setValue:@(d) forKey:name];
            }
            else if ( [type isEqualToString:@"B"] )
            {
                BOOL b = [[NSUserDefaults standardUserDefaults] boolForKey:name];
                [[self sharedUser] setValue:@(b) forKey:name];
            }
            else
            {
                id object = [[NSUserDefaults standardUserDefaults] objectForKey:name];
                [[self sharedUser] setValue:object forKey:name];
            }

        }
        free(ivars);
    }
    
    return _sharedUser;
}

//分配内存地址的时候调用 (当执行alloc的时候，系统会自动调用分配内存地址的方法)
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if ( !_sharedUser )
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedUser = [super allocWithZone:zone];
        });
    }
    return _sharedUser;
}

//保证copy这个对象的时候，返回的还是这个单利，不会生成新的 (这个方法需要在头部声明代理)
-(id)copyWithZone:(NSZone *)zone
{
    return _sharedUser;
}

//保证copy这个对象的时候，返回的还是这个单利，不会生成新的 (这个方法需要在头部声明代理)
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _sharedUser;
}



#pragma mark - public methods

//判断是否自动登录
+ (BOOL)isAutoLogin
{
    if ( [FLYUser sharedUser].token.length == 0 )
    {
        return NO;
    }
    return YES;
}

//保存用户信息
+ (void)saveUser
{
    /**
     遍历所有成员变量，把成员变量的值保存到NSUserDefaults。
     */
    
    
    //通过runtime遍历所有成员变量名
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++ )
    {
        Ivar ivar = ivars[i];
        
        //获取成员变量的名字
        const char * c_name = ivar_getName(ivar);
        NSString * name = [NSString stringWithUTF8String:c_name];
        
        //获取成员变量的类型
        const char * c_type = ivar_getTypeEncoding(ivar);
        NSString * type = [NSString stringWithUTF8String:c_type];

        //取出成员变量的值，根据不同的类型，给NSUserDefaults取值
        id object = [[FLYUser sharedUser] valueForKey:name];

        //q代表long、longlong、NSInteger，Q代表无符号的long、longlong、NSInteger，i代表int，s代表short
        if ( [type isEqualToString:@"q"] || [type isEqualToString:@"Q"] || [type isEqualToString:@"i"] || [type isEqualToString:@"s"] )
        {
            [[NSUserDefaults standardUserDefaults] setInteger:[object integerValue] forKey:name];
        }
        else if ( [type isEqualToString:@"f"] )
        {
            [[NSUserDefaults standardUserDefaults] setFloat:[object floatValue] forKey:name];
        }
        else if ( [type isEqualToString:@"d"] )
        {
            [[NSUserDefaults standardUserDefaults] setDouble:[object doubleValue] forKey:name];
        }
        else if ( [type isEqualToString:@"B"] )
        {
            [[NSUserDefaults standardUserDefaults] setBool:[object boolValue] forKey:name];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:object forKey:name];
        }
        
    }
    free(ivars);
    
    
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//清除用户信息
+ (void)clearUser
{
    /**
     遍历所有成员变量，给成员变量和NSUserDefaults赋初始值。
     */
    
    
    //通过runtime遍历所有成员变量名
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++ )
    {
        Ivar ivar = ivars[i];
        
        //获取成员变量的名字
        const char * c_name = ivar_getName(ivar);
        NSString * name = [NSString stringWithUTF8String:c_name];
        
        //获取成员变量的类型
        const char * c_type = ivar_getTypeEncoding(ivar);
        NSString * type = [NSString stringWithUTF8String:c_type];

        //根据不同的类型，给成员变量赋初始值
        
        //q代表long、longlong、NSInteger，Q代表无符号的long、longlong、NSInteger，i代表int，s代表short
        if ( [type isEqualToString:@"q"] || [type isEqualToString:@"Q"] || [type isEqualToString:@"i"] || [type isEqualToString:@"s"] )
        {
            [[self sharedUser] setValue:@(0) forKey:name];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:name];
        }
        else if ( [type isEqualToString:@"f"] )
        {
            [[self sharedUser] setValue:@(0.0) forKey:name];
            [[NSUserDefaults standardUserDefaults] setFloat:0.0 forKey:name];
        }
        else if ( [type isEqualToString:@"d"] )
        {
            [[self sharedUser] setValue:@(0.0) forKey:name];
            [[NSUserDefaults standardUserDefaults] setDouble:0.0 forKey:name];
        }
        else if ( [type isEqualToString:@"B"] )
        {
            [[self sharedUser] setValue:@(NO) forKey:name];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:name];
        }
        else
        {            
            [[self sharedUser] setValue:nil forKey:name];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:name];
        }
        
    }
    free(ivars);
    
    
    
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
