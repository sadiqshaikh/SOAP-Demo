//
//  TEst.m
//  SOApLib
//
//  Created by Sadiq on 16/03/16.
//  Copyright © 2016 Demo. All rights reserved.
//

#import "TEst.h"
#import <libxml/tree.h>

@implementation NSData (AES256)



@end
@implementation TEst
+ (NSString *)prettyPrintXML:(NSString *)rawXML {
    const char *utf8Str = [rawXML UTF8String];
    xmlDocPtr doc = xmlReadMemory(utf8Str, (int)strlen(utf8Str), NULL, NULL, XML_PARSE_NOCDATA | XML_PARSE_NOBLANKS);
    xmlNodePtr root = xmlDocGetRootElement(doc);
    xmlNodePtr xmlNode = xmlCopyNode(root, 1);
    xmlFreeDoc(doc);
    
    NSString *str = nil;
    
    xmlBufferPtr buff = xmlBufferCreate();
    doc = NULL;
    int level = 0;
    int format = 1;
    
    int result = xmlNodeDump(buff, doc, xmlNode, level, format);
    
    if (result > -1) {
        str = [[NSString alloc] initWithBytes:(xmlBufferContent(buff))
                                       length:(NSUInteger)(xmlBufferLength(buff))
                                     encoding:NSUTF8StringEncoding];
    }
    xmlBufferFree(buff);
    
    NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:ws];
    return trimmed;
}


@end
