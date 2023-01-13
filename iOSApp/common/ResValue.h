//
//  ResValue.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#ifndef ResValue_h
#define ResValue_h


/*_____________________________________________________________*/
#pragma mark - 颜色资源

#define kColorMain           UIColorFromRGB(0xddc096) //主颜色
#define kColorLabelGray      UIColorFromRGB(0x557479)
#define kColorGreen          UIColorFromRGB(0x27e189) //绿色
#define kColorGreenWallet    UIColorFromRGB(0x00A366)
#define kColorDarkGreen      UIColorFromRGB(0x17bda7) //深绿色
#define kColorWhite          UIColorFromRGB(0xffffff) //白色
#define kColorWhite30        UIColorFromRGBWithAlpha(0xffffff,0.3f) //白色
#define kColorWhite50        UIColorFromRGBWithAlpha(0xffffff,0.5f) //白色
#define kColorTextMainBlue       UIColorFromRGB(0x557479) //文本主颜色-蓝色
#define kColorTextTagHightBlue        UIColorFromRGB(0x6b9399) //文本tag颜色-亮蓝色
#define kColorBgMainGreen         UIColorFromRGB(0x269766) //主要背景色-绿色
#define kColorTextHightGreen      UIColorFromRGB(0x00cc80) //文本亮绿
#define kColorBgDisable      UIColorFromRGB(0x557479) //背景色-可不用
#define kColorBgPage         UIColorFromRGB(0x001C29) //背景色-通用页面
#define kColorBgBlock         UIColorFromRGB(0x00434D) //背景色-item块
#define kColorSpliteLine     UIColorFromRGB(0x121E23)//分割线颜色
#define kColorDarkGrey     UIColorFromRGB(0x121212)//暗黑灰色
#define kColorDarkWhite     UIColorFromRGBWithAlpha(0xFFFFFF,0.87f)//暗黑白色
#define kColorGrey     UIColorFromRGBWithAlpha(0x838383,0.70f)//暗黑白色



#define UIColorFromRGBWithAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

#define UIColorFromRGB(rgbValue) UIColorFromRGBWithAlpha(rgbValue,1.0f)

/*_____________________________________________________________*/
#pragma mark -字体资源
#define kFontText7                  kFont(7)
#define kFontText8                  kFont(8)
#define kFontText9                  kFont(9)
#define kFontText10                 kFont(10)
#define kFontText11                 kFont(11)
#define kFontText12                 kFont(12)
#define kFontText13                 kFont(13)
#define kFontText14                 kFont(14)
#define kFontText15                 kFont(15)
#define kFontText16                 kFont(16)
#define kFontText17                 kFont(17)
#define kFontText18                 kFont(18)
#define kFontText19                 kFont(19)
#define kFontText20                 kFont(20)
#define kFontText22                 kFont(22)
#define kFontText25                 kFont(25)
#define kFontText28                 kFont(28)
#define kFontText30                 kFont(30)
#define kFontText34                 kFont(34)
#define kFontText35                 kFont(35)
#define kFontText38                 kFont(38)
#define kFontText45                 kFont(45)

#define kFont(fontSize)             [UIFont systemFontOfSize:fontSize];

/*_____________________________________________________________*/
#pragma mark - 屏幕参数
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


/*_____________________________________________________________*/
#pragma mark - 国际化

#define L(key) key.I18N


#endif /* ResValue_h */
