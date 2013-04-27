//
//  NSAttributedString+MyString.m
//  CoreText-Example
//
//  Created by Thibaut Jarosz on 08/09/11.
//  Copyright 2011 Octiplex. All rights reserved.
//

#import "NSAttributedString+MyString.h"
#import "CoreTextView.h"


@implementation NSAttributedString (MyString)

+ (NSAttributedString*)attributedStringWithString:(NSString*)string
                                             font:(UIFont*)font
                                            color:(UIColor*)color
                                             link:(NSURL*)link
                                       underlined:(BOOL)underlined
{
    // Creating attributes dictionary
    NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
    
    if (font) {
        // Transforming UIFont to CGFont
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
        [attributes setValue:(id)fontRef forKey:(NSString*)kCTFontAttributeName];
        CFRelease(fontRef);
    }
    
    if (color)
        // Transforming UIColor to CGColor
        [attributes setValue:(id)color.CGColor forKey:(NSString*)kCTForegroundColorAttributeName];
    
    if (link)
        // Adding link using the key from CoreTextView
        [attributes setValue:link forKey:(NSString*)kCoreTextViewLinkAttributeName];
    
    if (underlined)
        // Setting the text underline
        [attributes setValue:[NSNumber numberWithInteger:kCTUnderlineStyleSingle] forKey:(NSString*)kCTUnderlineStyleAttributeName];
    
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] autorelease];
}


+ (NSAttributedString*)myString:(NSString *)str
{
    // Creating fonts, color and URL that will be used in this exemple
    UIFont *normalFont = [UIFont fontWithName:@"AmericanTypewriter" size:16];
    UIFont *boldFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
    UIFont *bigFont = [UIFont fontWithName:@"AmericanTypewriter" size:32];
    
    UIColor *normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // normal text color will be green
    
    NSURL *url = [NSURL URLWithString:@"http://www.bbc.co.uk/doctorwho/dw"];
    
    
    // Creating a Mutable attributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    // Creating first part of the text with no link, normal font and normal color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@"　　烧焦的木头倾倒在地，残存的砖墙被熏得乌黑，阵阵浓烟从焦土中升起……莫斯科州拉缅斯基村特大火灾发生后约７小时，新华国际记者赶到这里，看到的是如战后废墟般的火灾情景。　　现场周围拉起了警戒线，数十辆消防车、救护车、警车往来疾驶。救援人员动用铁锨、斧头等各种工具清理现场，寻找遇难者遗体。尽管明火已被扑灭，但消防人员仍不断向废墟上喷水。奋战数小时后，不少救援人员的脸被熏得漆黑，他们的鞋上也沾满黑土。　　当地时间２６日凌晨２时许，位于拉缅斯基村的莫斯科州第十四精神病院突然起火，目前已导致至少３８人死亡。　　住在医院对面的原医院职工亚历山大·契克马索尔亲眼目睹了这起悲剧的发生。“夜里两点多的时候，我突然被女儿叫醒，她说对面的医院着火了，”年逾花甲的契克马索尔回忆起当时的情景，唏嘘不已。“我透过窗户往对面一看，那里已经火光一片，火势蔓延得很快，一会儿工夫就吞噬了整栋建筑。”　　着火的建筑是砖木混合结构，顶棚是木制的。参与现场救援的莫斯科州紧急情况部官员瓦季姆·别洛沃申说，从现场情况看，起火建筑内堆积了大量塑料制件等物品，不少人是因这些物品燃烧后产生的一氧化碳中毒身亡的。　　在现场指挥救援的莫斯科州副州长佩斯托夫对记者说，火灾发生时正值深夜，人们都在熟睡，这是过火面积仅４２０平方米但导致大量人员伤亡的重要原因。此外，不少病人在睡前服用了精神病治疗药物，这可能也是导致他们不能及时逃生的原因之一。　　拉缅斯基村是人口仅约百人的小村，村庄被白桦林环抱。当地之所以选择在此设立医院，正是看中了这里静谧而优美的环境。但这场无情的大火，彻底打破了小村的宁静。　　曾在医院工作４０余年的契克马索尔说，拉缅斯基村地处偏远，第一批消防车赶到现场时，大火已经肆虐了近一个小时。“前些年村里还有专门的消防车，但这几年不知道什么原因被撤销了，”老人连连摇头说，“现在村里只有老幼妇孺，在无情的水火灾难面前无力自救，更别提救人了。”　　关于起火原因，莫斯科州侦查委员会发言人伊林娜·古缅娜娅说，调查部门正通过现场取样、收集文件、询问当事人等方式展开调查，起火原因目前尚无定论，存在电线短路、用火不慎、人为纵火等各种可能性。　　佩斯托夫说，当地政府目前正积极展开对伤员的救助，遇难者和受伤者家庭将分别得到５０万卢布（约合１０万元人民币）和１５万卢布（约合３万元人民币）的赔偿金。莫斯科州政府已决定将４月２７日设为“哀悼日”。　　\345\234\250拉缅斯基村口，道路两旁的白桦树下和树杈上，堆放或挂着一簇簇鲜花，那是村民和过路者在向遇难者表达哀思。　　图为４月２６日，俄罗斯救援人员在发生火灾的精神病院灭火。　新华社发　俄罗斯独立电视台网站"
                                                                                       font:normalFont
                                                                                      color:normalColor
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating second part of the text with no link, bold font and grey color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@"dark"
                                                                                       font:boldFont
                                                                                      color:[UIColor colorWithWhite:0.314 alpha:1]
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating third part of the text with no link, normal font and normal color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@" or "
                                                                                       font:normalFont
                                                                                      color:normalColor
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating fourth part of the text with no link, bold font and black color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@"black"
                                                                                       font:boldFont
                                                                                      color:[UIColor blackColor]
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating fifth part of the text with no link, normal font and normal color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@" and without character. The "
                                                                                       font:normalFont
                                                                                      color:normalColor
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating sixth part of the text with no link, bold font and black color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@"black"
                                                                                       font:boldFont
                                                                                      color:[UIColor blackColor]
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating seventh part of the text with no link, normal font and normal color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@" is in fact\n"
                                                                                       font:normalFont
                                                                                      color:normalColor
                                                                                       link:nil
                                                                                 underlined:NO]];
    
    // Creating heighth part of the text with link, big font and blue color.
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithString:@"deep blue"
                                                                                       font:bigFont
                                                                                      color:[UIColor blueColor]
                                                                                       link:url
                                                                                 underlined:YES]];
    
    return [attributedString autorelease];
}


@end
