//
//  ShopCouponModel.m
//  OrderAssistant
//
//  Created by Gong Lingxiao on 13-6-8.
//
//

#import "ShopCouponModel.h"
#import "GDataXMLNode.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation ShopCouponModel

@synthesize wandaCode;
@synthesize imageUrl;
@synthesize viewCount;
@synthesize time;

+ (NSArray *) barcodeList {
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getWandaCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getWandaCode>\
                             </soap:Body>\
                             </soap:Envelope>"];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    //NSLog(@"%@", [doc rootElement]);
    NSArray *barcodeMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSMutableArray *barcodes = [[NSMutableArray alloc] init];
    
    for (GDataXMLElement *barcodeElement in barcodeMembers) {
        ShopCouponModel *model = [[ShopCouponModel alloc] init];
        //wandaCode
        NSArray *wandaCodes = [barcodeElement elementsForName:@"wandaCode"];
        if (wandaCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [wandaCodes objectAtIndex:0];
            model.wandaCode = firstId.stringValue;
        } else {
            
        }
        
        //imageUrl
        NSArray *imageUrls = [barcodeElement elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            if (firstId.stringValue) {
                model.imageUrl = [WEBSITE_URL stringByAppendingString:firstId.stringValue];
            }
        } else {
            
        }
        
        //viewCount
        NSArray *viewCounts = [barcodeElement elementsForName:@"views"];
        if (viewCounts.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [viewCounts objectAtIndex:0];
            model.viewCount = firstId.stringValue;
        } else {
            
        }
        [barcodes addObject:model];
    }
    NSArray *retData = [NSArray arrayWithArray:barcodes];
    return retData;
}

+ (NSArray *) scandList:(NSString *) code {
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getWandaCodesByCCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getWandaCodesByCCode>\
                             </soap:Body>\
                             </soap:Envelope>", code];
    NSLog(@"%@", code);
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
    NSLog(@"%@", [doc rootElement]);
    NSArray *barcodeMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSMutableArray *barcodes = [[NSMutableArray alloc] init];
    
    for (GDataXMLElement *barcodeElement in barcodeMembers) {
        ShopCouponModel *model = [[ShopCouponModel alloc] init];
        //wandaCode
        NSArray *wandaCodes = [barcodeElement elementsForName:@"wandaCode"];
        if (wandaCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [wandaCodes objectAtIndex:0];
            model.wandaCode = firstId.stringValue;
        } else {
            
        }
        
        //imageUrl
        NSArray *imageUrls = [barcodeElement elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            if (firstId.stringValue) {
                model.imageUrl = [WEBSITE_URL stringByAppendingString:firstId.stringValue];
            }
        } else {
            
        }
        
        //viewCount
        NSArray *viewCounts = [barcodeElement elementsForName:@"views"];
        if (viewCounts.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [viewCounts objectAtIndex:0];
            model.viewCount = firstId.stringValue;
        } else {
            
        }
        
        //time
        NSArray *times = [barcodeElement elementsForName:@"time"];
        if (times.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [times objectAtIndex:0];
            model.time = firstId.stringValue;
        } else {
            
        }
        [barcodes addObject:model];
    }
    NSArray *retData = [NSArray arrayWithArray:barcodes];
    return retData;
}

+ (NSString *) scandBarcode:(NSString *) cCode withWandaCode:(NSString *) wandaCode {
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <addCustomerWandaCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             </addCustomerWandaCode>\
                             </soap:Body>\
                             </soap:Envelope>", cCode, wandaCode];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"SOAPAction" value:@""];
    [request addRequestHeader:@"Content-Length" value:msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    //同步调用
    [request startSynchronous];
    NSData *responseData = [request responseData];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
   // NSLog(@"%@", [doc rootElement]);
    return [[doc rootElement] stringValue];
}

@end
