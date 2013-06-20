//
//  WebServices.m
//  OrderAssistant
//
//  Created by 潘 群 on 12-11-12.
//
//

#import "WebServices.h"
#import "GDataXMLNode.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation WebServices


@synthesize resEntity;
@synthesize restaurants;
@synthesize userEntity;
@synthesize registList;
@synthesize appointmentModel;
@synthesize dishEntity;
@synthesize couponEntity;


//获取版本号
+ (NSString *) getIOSUpdateVersion{
    //download
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"download"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getIOSUpdateVersion xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getIOSUpdateVersion>\
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
    //NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    GDataXMLElement *root = [doc rootElement];
    NSString *newVer = root.stringValue;

    return newVer;
}

//商圈搜索，首页  万达、常发  search  getShopsByArea(String type)
+ (NSMutableArray *) getShopsByArea:(NSString *)type{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopsByArea xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getShopsByArea>\
                             </soap:Body>\
                             </soap:Envelope>",type];
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
    NSArray *shopMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
   // NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *shopMember in shopMembers) {
        ResEntity *resEntity=[[ResEntity alloc] init];
        
        //addTime
        NSArray *addTimes = [shopMember elementsForName:@"addTime"];
        if (addTimes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
            
        } else {
            
        }
        
        // address
        NSArray *addresses = [shopMember elementsForName:@"address"];
        if (addresses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
            resEntity.ResAddressTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // appTotalPercen
        NSArray *appTotalPercens = [shopMember elementsForName:@"appTotalPercen"];
        if (appTotalPercens.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];
            
        } else {
            
        }
        
        // applicationId
        NSArray *applicationIds = [shopMember elementsForName:@"applicationId"];
        if (applicationIds.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];
            
        } else {
            
        }
        
        // avgCon
        NSArray *avgCons = [shopMember elementsForName:@"avgCon"];
        if (avgCons.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
            resEntity.resPriceTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // bus
        NSArray *buses = [shopMember elementsForName:@"bus"];
        if (buses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];
            
        } else {
            
        }
        
        // certificate
        NSArray *certificates = [shopMember elementsForName:@"certificate"];
        if (certificates.count > 0) {
            // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];
            
        } else {
            
        }
        
        // code
        NSArray *codes = [shopMember elementsForName:@"code"];
        if (codes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
            resEntity.resCode=firstId.stringValue;
        } else {
            
        }
        
        // contacter
        NSArray *contacters = [shopMember elementsForName:@"contacter"];
        if (contacters.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];
            
        } else {
            
        }
        
        // grade
        NSArray *grades = [shopMember elementsForName:@"grade"];
        if (grades.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
            resEntity.ResStarGradeTxt=firstId.stringValue;
            
        } else {
            
        }
        // distance
        NSArray *distances = [shopMember elementsForName:@"distance"];
        if (distances.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
            resEntity.resDistanceTxt=firstId.stringValue;
            
        } else {
            
        }
        
        
        // ico
        NSArray *icos = [shopMember elementsForName:@"ico"];
        if (icos.count > 0) {
            // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
            
        } else {
            
        }
        
        // imageUrl
        NSArray *imageUrls = [shopMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            resEntity.resImg=firstId.stringValue;
            
        } else {
            
        }
        
        // intro
        NSArray *intros = [shopMember elementsForName:@"intro"];
        if (intros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
            resEntity.resIntro=firstId.stringValue;
            // NSLog(@"%@",firstId.stringValue);
            
        } else {
            
        }
        
        // isAllowApp
        NSArray *isAllowApps = [shopMember elementsForName:@"isAllowApp"];
        if (isAllowApps.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
            
        } else {
            
        }
        
        // isAudit
        NSArray *isAudits = [shopMember elementsForName:@"isAudit"];
        if (isAudits.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
            
        } else {
            
        }
        
        // isDoubleScore
        NSArray *isDoubleScores = [shopMember elementsForName:@"isDoubleScore"];
        if (isDoubleScores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
            
        } else {
            
        }
        
        // isRecommed
        NSArray *isRecommeds = [shopMember elementsForName:@"isRecommed"];
        if (isRecommeds.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
            
        } else {
            
        }
        
        // lastSMS
        NSArray *lastSMSes = [shopMember elementsForName:@"lastSMS"];
        if (lastSMSes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
            
        } else {
            
        }
        
        // latitude
        NSArray *latitudes = [shopMember elementsForName:@"latitude"];
        if (latitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
            resEntity.latitude=firstId.stringValue;
            
        } else {
            
        }
        
        // license
        NSArray *licenses = [shopMember elementsForName:@"license"];
        if (licenses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
            
        } else {
            
        }
        
        // longitude
        NSArray *longitudes = [shopMember elementsForName:@"longitude"];
        if (longitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
            resEntity.longitude=firstId.stringValue;
            
        } else {
            
        }
        
        // name
        NSArray *names = [shopMember elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            resEntity.resNameTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // payment
        NSArray *payments = [shopMember elementsForName:@"payment"];
        if (payments.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
            
        } else {
            
        }
        
        // phone
        NSArray *phones = [shopMember elementsForName:@"phone"];
        if (phones.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
            resEntity.ResTelTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // score
        NSArray *scores = [shopMember elementsForName:@"score"];
        if (scores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
            
        } else {
            
        }
        
        // sdArea
        NSArray *sdAreas = [shopMember elementsForName:@"sdArea"];
        if (sdAreas.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
            resEntity.resSdArea=firstId.stringValue;
            
        } else {
            
        }
        
        // sdAreaCode
        NSArray *sdAreaCodes = [shopMember elementsForName:@"sdAreaCode"];
        if (sdAreaCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdDeposit
        NSArray *sdDeposits = [shopMember elementsForName:@"sdDeposit"];
        if (sdDeposits.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
            
        } else {
            
        }
        
        // sdMessageCode
        NSArray *sdMessageCodes = [shopMember elementsForName:@"sdMessageCode"];
        if (sdMessageCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdRegion
        NSArray *sdRegions = [shopMember elementsForName:@"sdRegion"];
        if (sdRegions.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
            
        } else {
            
        }
        
        // sdRegionCode
        NSArray *sdRegionCodes = [shopMember elementsForName:@"sdRegionCode"];
        if (sdRegionCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // status
        NSArray *statuses = [shopMember elementsForName:@"status"];
        if (statuses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
            
        } else {
            
        }
        
        // totalSMS
        NSArray *totalSMSes = [shopMember elementsForName:@"totalSMS"];
        if (totalSMSes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
            
        } else {
            
        }
        
        // workTime
        NSArray *workTimes = [shopMember elementsForName:@"workTime"];
        if (workTimes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
            resEntity.workTime = firstId.stringValue;
        } else {
            
        }
        
        // mPhone
        NSArray *mPhones = [shopMember elementsForName:@"mPhone"];
        if (mPhones.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
            
        } else {
            
        }
        
        [restaurants addObject:resEntity];

    }
    return restaurants;
}

//根据聚会类型搜索商家，大型宴请、小型聚会、自助餐
+ (NSMutableArray *) getShopDetailsByEtCode:(NSString *)type{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopDetailsByEtCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getShopDetailsByEtCode>\
                             </soap:Body>\
                             </soap:Envelope>",type];
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
    NSArray *shopMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    // NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *shopMember in shopMembers) {
        ResEntity *resEntity=[[ResEntity alloc] init];
        
        //addTime
        NSArray *addTimes = [shopMember elementsForName:@"addTime"];
        if (addTimes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
            
        } else {
            
        }
        
        // address
        NSArray *addresses = [shopMember elementsForName:@"address"];
        if (addresses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
            resEntity.ResAddressTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // appTotalPercen
        NSArray *appTotalPercens = [shopMember elementsForName:@"appTotalPercen"];
        if (appTotalPercens.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];
            
        } else {
            
        }
        
        // applicationId
        NSArray *applicationIds = [shopMember elementsForName:@"applicationId"];
        if (applicationIds.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];
            
        } else {
            
        }
        
        // avgCon
        NSArray *avgCons = [shopMember elementsForName:@"avgCon"];
        if (avgCons.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
            resEntity.resPriceTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // bus
        NSArray *buses = [shopMember elementsForName:@"bus"];
        if (buses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];
            
        } else {
            
        }
        
        // certificate
        NSArray *certificates = [shopMember elementsForName:@"certificate"];
        if (certificates.count > 0) {
            // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];
            
        } else {
            
        }
        
        // code
        NSArray *codes = [shopMember elementsForName:@"code"];
        if (codes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
            resEntity.resCode=firstId.stringValue;
        } else {
            
        }
        
        // contacter
        NSArray *contacters = [shopMember elementsForName:@"contacter"];
        if (contacters.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];
            
        } else {
            
        }
        
        // grade
        NSArray *grades = [shopMember elementsForName:@"grade"];
        if (grades.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
            resEntity.ResStarGradeTxt=firstId.stringValue;
            
        } else {
            
        }
        // distance
        NSArray *distances = [shopMember elementsForName:@"distance"];
        if (distances.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
            resEntity.resDistanceTxt=firstId.stringValue;
            
        } else {
            
        }
        
        
        // ico
        NSArray *icos = [shopMember elementsForName:@"ico"];
        if (icos.count > 0) {
            // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
            
        } else {
            
        }
        
        // imageUrl
        NSArray *imageUrls = [shopMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            resEntity.resImg=firstId.stringValue;
            
        } else {
            
        }
        
        // intro
        NSArray *intros = [shopMember elementsForName:@"intro"];
        if (intros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
            resEntity.resIntro=firstId.stringValue;
            // NSLog(@"%@",firstId.stringValue);
            
        } else {
            
        }
        
        // isAllowApp
        NSArray *isAllowApps = [shopMember elementsForName:@"isAllowApp"];
        if (isAllowApps.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
            
        } else {
            
        }
        
        // isAudit
        NSArray *isAudits = [shopMember elementsForName:@"isAudit"];
        if (isAudits.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
            
        } else {
            
        }
        
        // isDoubleScore
        NSArray *isDoubleScores = [shopMember elementsForName:@"isDoubleScore"];
        if (isDoubleScores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
            
        } else {
            
        }
        
        // isRecommed
        NSArray *isRecommeds = [shopMember elementsForName:@"isRecommed"];
        if (isRecommeds.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
            
        } else {
            
        }
        
        // lastSMS
        NSArray *lastSMSes = [shopMember elementsForName:@"lastSMS"];
        if (lastSMSes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
            
        } else {
            
        }
        
        // latitude
        NSArray *latitudes = [shopMember elementsForName:@"latitude"];
        if (latitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
            resEntity.latitude=firstId.stringValue;
            
        } else {
            
        }
        
        // license
        NSArray *licenses = [shopMember elementsForName:@"license"];
        if (licenses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
            
        } else {
            
        }
        
        // longitude
        NSArray *longitudes = [shopMember elementsForName:@"longitude"];
        if (longitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
            resEntity.longitude=firstId.stringValue;
            
        } else {
            
        }
        
        // name
        NSArray *names = [shopMember elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            resEntity.resNameTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // payment
        NSArray *payments = [shopMember elementsForName:@"payment"];
        if (payments.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
            
        } else {
            
        }
        
        // phone
        NSArray *phones = [shopMember elementsForName:@"phone"];
        if (phones.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
            resEntity.ResTelTxt=firstId.stringValue;
            
        } else {
            
        }
        
        // score
        NSArray *scores = [shopMember elementsForName:@"score"];
        if (scores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
            
        } else {
            
        }
        
        // sdArea
        NSArray *sdAreas = [shopMember elementsForName:@"sdArea"];
        if (sdAreas.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
            resEntity.resSdArea=firstId.stringValue;
            
        } else {
            
        }
        
        // sdAreaCode
        NSArray *sdAreaCodes = [shopMember elementsForName:@"sdAreaCode"];
        if (sdAreaCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdDeposit
        NSArray *sdDeposits = [shopMember elementsForName:@"sdDeposit"];
        if (sdDeposits.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
            
        } else {
            
        }
        
        // sdMessageCode
        NSArray *sdMessageCodes = [shopMember elementsForName:@"sdMessageCode"];
        if (sdMessageCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdRegion
        NSArray *sdRegions = [shopMember elementsForName:@"sdRegion"];
        if (sdRegions.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
            
        } else {
            
        }
        
        // sdRegionCode
        NSArray *sdRegionCodes = [shopMember elementsForName:@"sdRegionCode"];
        if (sdRegionCodes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
            
        } else {
            
        }
        
        // status
        NSArray *statuses = [shopMember elementsForName:@"status"];
        if (statuses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
            
        } else {
            
        }
        
        // totalSMS
        NSArray *totalSMSes = [shopMember elementsForName:@"totalSMS"];
        if (totalSMSes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
            
        } else {
            
        }
        
        // workTime
        NSArray *workTimes = [shopMember elementsForName:@"workTime"];
        if (workTimes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
            resEntity.workTime = firstId.stringValue;
        } else {
            
        }
        
        // mPhone
        NSArray *mPhones = [shopMember elementsForName:@"mPhone"];
        if (mPhones.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
            
        } else {
            
        }
        
        [restaurants addObject:resEntity];
        
    }
    return restaurants;
}


//根据menuCode获取不同类别的菜单
+ (void) getDishInfoByMenuCode:(NSString *) menuCode{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"dish"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getDishInfoByMenuCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getDishInfoByMenuCode>\
                             </soap:Body>\
                             </soap:Envelope>",menuCode];
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
    // NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *dishMembers = [doc nodesForXPath:@"//return" error:&error];
    
    //NSMutableArray *dishList=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *returnElement in dishMembers){
        NSData *data = [returnElement.stringValue dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", error);
        } else {
            for (NSDictionary *item in jsonArray) {
                DishEntity *dishEntity = [[DishEntity alloc] init];
                dishEntity.imageUrl=[item objectForKey:@"imageUrl"];
                dishEntity.dishName=[item objectForKey:@"dishName"];
                dishEntity.dishCode=[item objectForKey:@"dishCode"];
                dishEntity.dishUnit=[item objectForKey:@"dishUnit"];
                dishEntity.isFeatureDish=[NSString stringWithFormat:@"%@",[item objectForKey:@"isFeatureDish"]];
                dishEntity.dishPrice=[NSString stringWithFormat:@"%@", [item objectForKey:@"dishPrice"]];
                dishEntity.num=[NSString stringWithFormat:@"%@", [item objectForKey:@"num"]];
                dishEntity.menuName=[item objectForKey:@"menuName"];
                dishEntity.menuCode=[item objectForKey:@"menuCode"];
                //[dishList addObject:dishEntity];
                [DishEntity insertDish:dishEntity];
            }
        }
    }
    //return dishList;
}
//获取菜单分类
+ (void) getMenuInfoBySDCode:(NSString *) sdCode{

    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"dish"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getMenuInfoBySDCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getMenuInfoBySDCode>\
                             </soap:Body>\
                             </soap:Envelope>",sdCode];
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
   // NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *dishMembers = [doc nodesForXPath:@"//return" error:&error];
    
    //NSMutableArray *dishMenuList=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *dishMember in dishMembers) {
        DishMenu *dishMenu = [[DishMenu alloc] init];
        //menuCode
        NSArray *menuCodes = [dishMember elementsForName:@"menuCode"];
        if (menuCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [menuCodes objectAtIndex:0];
            dishMenu.menuCode=firstId.stringValue;
        } else {
            
        }
        //menuName
        NSArray *menuNames = [dishMember elementsForName:@"menuName"];
        if (menuNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [menuNames objectAtIndex:0];
            dishMenu.menuName=firstId.stringValue;
        } else {
            
        }
        //sdCode
        NSArray *sdCodes = [dishMember elementsForName:@"sdCode"];
        if (sdCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdCodes objectAtIndex:0];
            dishMenu.sdCode=firstId.stringValue;
        } else {
            
        }
        //[dishMenuList addObject:dishMenu];
        [DishMenu insertMenu:dishMenu];
        
    }
    

    //return dishMenuList;
}
//组合条件查询
+ (NSMutableArray *) getShopListByPSConditionForIos:(NSString *) pageNow :(NSString *) pageSize :(NSString *)lng :(NSString *)lat :(NSString *)dis :(NSString *)flavorCode :(NSString *)areaCode{
    NSString *pages;
    NSString *nums;
    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopListByPSConditionForIos xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             <arg3>%@</arg3>\
                             <arg4>%@</arg4>\
                             <arg5>%@</arg5>\
                             <arg6>%@</arg6>\
                             </getShopListByPSConditionForIos>\
                             </soap:Body>\
                             </soap:Envelope>",pageNow,pageSize,lng,lat,dis,flavorCode,areaCode];
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
    NSArray *shopMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *shopMember in shopMembers) {
        
        //totalNum
        NSArray *totalNums = [shopMember elementsForName:@"totalNum"];
        if (totalNums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalNums objectAtIndex:0];
            nums=firstId.stringValue;
        } else {
            
        }
        //totalPage
        NSArray *totalPages = [shopMember elementsForName:@"totalPage"];
        if (totalPages.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalPages objectAtIndex:0];
            pages=firstId.stringValue;
        } else {
            
        }
        //resultList
        NSArray *resultLists = [shopMember elementsForName:@"resultList"];
        if (resultLists.count > 0) {
            
            //GDataXMLElement *firstId = (GDataXMLElement *) [resultLists objectAtIndex:0];
            //NSLog(@"addTime = %@", firstId.stringValue);
            for (GDataXMLElement *shopList in shopLists){
                
                ResEntity *resEntity=[[ResEntity alloc] init];
                resEntity.totalNum=nums;
                resEntity.totalPage=pages;
                
                //addTime
                NSArray *addTimes = [shopList elementsForName:@"addTime"];
                if (addTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // address
                NSArray *addresses = [shopList elementsForName:@"address"];
                if (addresses.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
                    resEntity.ResAddressTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // appTotalPercen
                NSArray *appTotalPercens = [shopList elementsForName:@"appTotalPercen"];
                if (appTotalPercens.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];
                    
                } else {
                    
                }
                
                // applicationId
                NSArray *applicationIds = [shopList elementsForName:@"applicationId"];
                if (applicationIds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // avgCon
                NSArray *avgCons = [shopList elementsForName:@"avgCon"];
                if (avgCons.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
                    resEntity.resPriceTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // bus
                NSArray *buses = [shopList elementsForName:@"bus"];
                if (buses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // certificate
                NSArray *certificates = [shopList elementsForName:@"certificate"];
                if (certificates.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];
                    
                } else {
                    
                }
                
                // code
                NSArray *codes = [shopList elementsForName:@"code"];
                if (codes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
                    resEntity.resCode=firstId.stringValue;
                } else {
                    
                }
                
                // contacter
                NSArray *contacters = [shopList elementsForName:@"contacter"];
                if (contacters.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];
                    
                } else {
                    
                }
                
                // grade
                NSArray *grades = [shopList elementsForName:@"grade"];
                if (grades.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
                    resEntity.ResStarGradeTxt=firstId.stringValue;
                    
                } else {
                    
                }
                // distance
                NSArray *distances = [shopList elementsForName:@"distance"];
                if (distances.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
                    resEntity.resDistanceTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                
                // ico
                NSArray *icos = [shopList elementsForName:@"ico"];
                if (icos.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
                    
                } else {
                    
                }
                
                // imageUrl
                NSArray *imageUrls = [shopList elementsForName:@"imageUrl"];
                if (imageUrls.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
                    resEntity.resImg=firstId.stringValue;
                    
                } else {
                    
                }
                
                // intro
                NSArray *intros = [shopList elementsForName:@"intro"];
                if (intros.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
                    resEntity.resIntro=firstId.stringValue;
                    // NSLog(@"%@",firstId.stringValue);
                    
                } else {
                    
                }
                
                // isAllowApp
                NSArray *isAllowApps = [shopList elementsForName:@"isAllowApp"];
                if (isAllowApps.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isAudit
                NSArray *isAudits = [shopList elementsForName:@"isAudit"];
                if (isAudits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isDoubleScore
                NSArray *isDoubleScores = [shopList elementsForName:@"isDoubleScore"];
                if (isDoubleScores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isRecommed
                NSArray *isRecommeds = [shopList elementsForName:@"isRecommed"];
                if (isRecommeds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // lastSMS
                NSArray *lastSMSes = [shopList elementsForName:@"lastSMS"];
                if (lastSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // latitude
                NSArray *latitudes = [shopList elementsForName:@"latitude"];
                if (latitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
                    resEntity.latitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // license
                NSArray *licenses = [shopList elementsForName:@"license"];
                if (licenses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // longitude
                NSArray *longitudes = [shopList elementsForName:@"longitude"];
                if (longitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
                    resEntity.longitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // name
                NSArray *names = [shopList elementsForName:@"name"];
                if (names.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
                    resEntity.resNameTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // payment
                NSArray *payments = [shopList elementsForName:@"payment"];
                if (payments.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
                    
                } else {
                    
                }
                
                // phone
                NSArray *phones = [shopList elementsForName:@"phone"];
                if (phones.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
                    resEntity.ResTelTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // score
                NSArray *scores = [shopList elementsForName:@"score"];
                if (scores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdArea
                NSArray *sdAreas = [shopList elementsForName:@"sdArea"];
                if (sdAreas.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
                    resEntity.resSdArea=firstId.stringValue;
                    
                } else {
                    
                }
                
                // sdAreaCode
                NSArray *sdAreaCodes = [shopList elementsForName:@"sdAreaCode"];
                if (sdAreaCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdDeposit
                NSArray *sdDeposits = [shopList elementsForName:@"sdDeposit"];
                if (sdDeposits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdMessageCode
                NSArray *sdMessageCodes = [shopList elementsForName:@"sdMessageCode"];
                if (sdMessageCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegion
                NSArray *sdRegions = [shopList elementsForName:@"sdRegion"];
                if (sdRegions.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegionCode
                NSArray *sdRegionCodes = [shopList elementsForName:@"sdRegionCode"];
                if (sdRegionCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // status
                NSArray *statuses = [shopList elementsForName:@"status"];
                if (statuses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // totalSMS
                NSArray *totalSMSes = [shopList elementsForName:@"totalSMS"];
                if (totalSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // workTime
                NSArray *workTimes = [shopList elementsForName:@"workTime"];
                if (workTimes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
                    resEntity.workTime = firstId.stringValue;
                } else {
                    
                }
                
                // mPhone
                NSArray *mPhones = [shopList elementsForName:@"mPhone"];
                if (mPhones.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
                    
                } else {
                    
                }
                
                [restaurants addObject:resEntity];
            }
            
        } else {
            
        }
    }
    return restaurants;
}

+ (NSMutableArray *) getFlavorInfo{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"flavor"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getFlavorInfo xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getFlavorInfo>\
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
    NSArray *cookingMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    
    NSMutableArray *cookingStyles=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *cookingMember in cookingMembers) {
        
        CookStyleEntity *cookEntity=[[CookStyleEntity alloc] init];
        //code
        NSArray *codes = [cookingMember elementsForName:@"code"];
        if (codes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
            cookEntity.cookCode=firstId.stringValue;
        } else {
            
        }
        //name
        NSArray *names = [cookingMember elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            cookEntity.cookName=firstId.stringValue;
            //pages=firstId.stringValue;
        } else {
            
        }
        //parent
        NSArray *parents = [cookingMember elementsForName:@"parent"];
        if (parents.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [parents objectAtIndex:0];
            cookEntity.parent=firstId.stringValue;
            //pages=firstId.stringValue;
        } else {
            
        }
        
        [cookingStyles addObject:cookEntity];
    }
    //NSLog(@"%d",[cookingStyles count]);
    return cookingStyles;
}

+ (NSMutableArray *) getAreaInfo{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"area"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getAreaInfo xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getAreaInfo>\
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
    NSArray *areaMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    
    NSMutableArray *areaLists=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *areaMember in areaMembers) {
        
        AreaEntity *areaEntity=[[AreaEntity alloc] init];
        //code
        NSArray *codes = [areaMember elementsForName:@"code"];
        if (codes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
            areaEntity.areaCode=firstId.stringValue;
        } else {
            
        }
        //name
        NSArray *names = [areaMember elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            areaEntity.areaName=firstId.stringValue;
            //pages=firstId.stringValue;
        } else {
            
        }
                
        [areaLists addObject:areaEntity];
    }
    return areaLists;
}

+(NSMutableArray *) getNearShopForIOS:(NSString *) pageNow :(NSString *) pageSize :(NSString *) lad :(NSString *)lgd :(NSString *)dis
{
    
    NSString *pages;
    NSString *nums;
    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getNearShopForIOS xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             <arg3>%@</arg3>\
                             <arg4>%@</arg4>\
                             </getNearShopForIOS>\
                             </soap:Body>\
                             </soap:Envelope>",pageNow,pageSize,lgd,lad,dis];
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
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
     for (GDataXMLElement *customerMember in customerMembers) { 

         //totalNum
         NSArray *totalNums = [customerMember elementsForName:@"totalNum"];
         if (totalNums.count > 0) {
             GDataXMLElement *firstId = (GDataXMLElement *) [totalNums objectAtIndex:0];
             nums=firstId.stringValue;
         } else {
             
         }
         //totalPage
         NSArray *totalPages = [customerMember elementsForName:@"totalPage"];
         if (totalPages.count > 0) {
             GDataXMLElement *firstId = (GDataXMLElement *) [totalPages objectAtIndex:0];
             pages=firstId.stringValue;
         } else {
             
         }
        //resultList
        NSArray *resultLists = [customerMember elementsForName:@"resultList"];
        if (resultLists.count > 0) {
            
            //GDataXMLElement *firstId = (GDataXMLElement *) [resultLists objectAtIndex:0];
            //NSLog(@"addTime = %@", firstId.stringValue);
            for (GDataXMLElement *shopList in shopLists){
                
                ResEntity *resEntity=[[ResEntity alloc] init];
                resEntity.totalNum=nums;
                resEntity.totalPage=pages;
                
                //addTime
                NSArray *addTimes = [shopList elementsForName:@"addTime"];
                if (addTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];

                } else {
                    
                }
                
                // address
                NSArray *addresses = [shopList elementsForName:@"address"];
                if (addresses.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
                    resEntity.ResAddressTxt=firstId.stringValue;

                } else {
                    
                }
                
                // appTotalPercen
                NSArray *appTotalPercens = [shopList elementsForName:@"appTotalPercen"];
                if (appTotalPercens.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];

                } else {
                    
                }
                
                // applicationId
                NSArray *applicationIds = [shopList elementsForName:@"applicationId"];
                if (applicationIds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];

                } else {
                    
                }
                
                // avgCon
                NSArray *avgCons = [shopList elementsForName:@"avgCon"];
                if (avgCons.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
                    resEntity.resPriceTxt=firstId.stringValue;

                } else {
                    
                }
                
                // bus
                NSArray *buses = [shopList elementsForName:@"bus"];
                if (buses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];

                } else {
                    
                }
                
                // certificate
                NSArray *certificates = [shopList elementsForName:@"certificate"];
                if (certificates.count > 0) {
                   // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];

                } else {
                    
                }
                
                // code
                NSArray *codes = [shopList elementsForName:@"code"];
                if (codes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
                    resEntity.resCode=firstId.stringValue;
                } else {
                    
                }
                
                // contacter
                NSArray *contacters = [shopList elementsForName:@"contacter"];
                if (contacters.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];

                } else {
                    
                }
                
                // grade
                NSArray *grades = [shopList elementsForName:@"grade"];
                if (grades.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
                    resEntity.ResStarGradeTxt=firstId.stringValue;
                    
                } else {
                    
                }
                // distance
                NSArray *distances = [shopList elementsForName:@"distance"];
                if (distances.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
                    resEntity.resDistanceTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                
                // ico
                NSArray *icos = [shopList elementsForName:@"ico"];
                if (icos.count > 0) {
                   // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
                    
                } else {
                    
                }
                
                // imageUrl
                NSArray *imageUrls = [shopList elementsForName:@"imageUrl"];
                if (imageUrls.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
                    resEntity.resImg=firstId.stringValue;
                   
                } else {
                    
                }
                
                // intro
                NSArray *intros = [shopList elementsForName:@"intro"];
                if (intros.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
                    resEntity.resIntro=firstId.stringValue;
                   // NSLog(@"%@",firstId.stringValue);
                    
                } else {
                    
                }
                
                // isAllowApp
                NSArray *isAllowApps = [shopList elementsForName:@"isAllowApp"];
                if (isAllowApps.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isAudit
                NSArray *isAudits = [shopList elementsForName:@"isAudit"];
                if (isAudits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isDoubleScore
                NSArray *isDoubleScores = [shopList elementsForName:@"isDoubleScore"];
                if (isDoubleScores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
                   
                } else {
                    
                }
                
                // isRecommed
                NSArray *isRecommeds = [shopList elementsForName:@"isRecommed"];
                if (isRecommeds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // lastSMS
                NSArray *lastSMSes = [shopList elementsForName:@"lastSMS"];
                if (lastSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // latitude
                NSArray *latitudes = [shopList elementsForName:@"latitude"];
                if (latitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
                    resEntity.latitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // license
                NSArray *licenses = [shopList elementsForName:@"license"];
                if (licenses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // longitude
                NSArray *longitudes = [shopList elementsForName:@"longitude"];
                if (longitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
                    resEntity.longitude=firstId.stringValue;
                   
                } else {
                    
                }
                
                // name
                NSArray *names = [shopList elementsForName:@"name"];
                if (names.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
                    resEntity.resNameTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // payment
                NSArray *payments = [shopList elementsForName:@"payment"];
                if (payments.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
                    
                } else {
                    
                }
                
                // phone
                NSArray *phones = [shopList elementsForName:@"phone"];
                if (phones.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
                    resEntity.ResTelTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // score
                NSArray *scores = [shopList elementsForName:@"score"];
                if (scores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
                   
                } else {
                    
                }
                
                // sdArea
                NSArray *sdAreas = [shopList elementsForName:@"sdArea"];
                if (sdAreas.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
                    resEntity.resSdArea=firstId.stringValue;
                   
                } else {
                    
                }
                
                // sdAreaCode
                NSArray *sdAreaCodes = [shopList elementsForName:@"sdAreaCode"];
                if (sdAreaCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdDeposit
                NSArray *sdDeposits = [shopList elementsForName:@"sdDeposit"];
                if (sdDeposits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
                   
                } else {
                    
                }
                
                // sdMessageCode
                NSArray *sdMessageCodes = [shopList elementsForName:@"sdMessageCode"];
                if (sdMessageCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegion
                NSArray *sdRegions = [shopList elementsForName:@"sdRegion"];
                if (sdRegions.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegionCode
                NSArray *sdRegionCodes = [shopList elementsForName:@"sdRegionCode"];
                if (sdRegionCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // status
                NSArray *statuses = [shopList elementsForName:@"status"];
                if (statuses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // totalSMS
                NSArray *totalSMSes = [shopList elementsForName:@"totalSMS"];
                if (totalSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
                   
                } else {
                    
                }
                
                // workTime
                NSArray *workTimes = [shopList elementsForName:@"workTime"];
                if (workTimes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
                    resEntity.workTime = firstId.stringValue;
                } else {
                    
                }
                
                // mPhone
                NSArray *mPhones = [shopList elementsForName:@"mPhone"];
                if (mPhones.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
                    
                } else {
                    
                }

                [restaurants addObject:resEntity];
            } 
            
        } else {
            
        }  
    }
    return restaurants;
}
        
               
+ (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
}

+(UserEntity *)login:(NSString *)myPhone :(NSString *)myPassWord :(NSString *)deviceToken :(NSString *)type
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <login xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             <arg3>%@</arg3>\
                             </login>\
                             </soap:Body>\
                             </soap:Envelope>", myPhone, myPassWord, deviceToken, type];
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
    NSArray *userInfomations = [doc.rootElement nodesForXPath:@"//return" error:&error];
   
    UserEntity *userEntity=[[UserEntity alloc] init];
    
    for (GDataXMLElement *userInfomation in userInfomations) {
        //CCode
        NSArray *CCodes = [userInfomation elementsForName:@"CCode"];
        if (CCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [CCodes objectAtIndex:0];
            userEntity.userCCode=firstId.stringValue;
        } else {
            
        }

        //devoteName
        NSArray *devoteNames = [userInfomation elementsForName:@"devoteName"];
        if (devoteNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [devoteNames objectAtIndex:0];
            userEntity.userDevoteName=firstId.stringValue;
            
        } else {
            
        }
        //email
        NSArray *emails = [userInfomation elementsForName:@"email"];
        if (emails.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [emails objectAtIndex:0];
            userEntity.userEmail=firstId.stringValue;
        } else {
            
        }

        //flag
        NSArray *flags = [userInfomation elementsForName:@"flag"];
        if (flags.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [flags objectAtIndex:0];
            userEntity.userFlag=firstId.stringValue;
        } else {
            
        }
        
        //imageUrl
        NSArray *imageUrls = [userInfomation elementsForName:@"imageUrl"];
        if (flags.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            userEntity.imageUrl=firstId.stringValue;
            
        } else {
            
        }

        //isActive
        NSArray *isActives = [userInfomation elementsForName:@"isActive"];
        if (isActives.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isActives objectAtIndex:0];
            userEntity.userIsActive=firstId.stringValue;
            
        } else {
            
        }

        //nickName
        NSArray *nickNames = [userInfomation elementsForName:@"nickName"];
        if (nickNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [nickNames objectAtIndex:0];
            userEntity.userNickName=firstId.stringValue;
            
        } else {
            
        }
        
        //score
        NSArray *scores = [userInfomation elementsForName:@"score"];
        if (scores.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
            userEntity.userScore=firstId.stringValue;
            
        } else {
            
        }
        //regTime
        NSArray *regTimes = [userInfomation elementsForName:@"regTime"];
        if (regTimes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [regTimes objectAtIndex:0];
            userEntity.regTime=firstId.stringValue;
        } else {
        }
        
        //sex
        NSArray *sexs = [userInfomation elementsForName:@"sex"];
        if (sexs.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sexs objectAtIndex:0];
            userEntity.userSex=firstId.stringValue;
            
        } else {
            
        }
    }
    return userEntity;

}

+(UserEntity *)addCustomer:(NSString *)myPhone :(NSString *)myPassWord
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <addCustomer xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             </addCustomer>\
                             </soap:Body>\
                             </soap:Envelope>", myPhone, myPassWord];
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
    NSArray *userInfomations = [doc.rootElement nodesForXPath:@"//return" error:&error];

    UserEntity *userEntity=[[UserEntity alloc] init];
    
    for (GDataXMLElement *userInfomation in userInfomations) {
        //CCode
        NSArray *CCodes = [userInfomation elementsForName:@"CCode"];
        if (CCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [CCodes objectAtIndex:0];
            userEntity.userCCode=firstId.stringValue;
        } else {
            
        }
        
        //devoteName
        NSArray *devoteNames = [userInfomation elementsForName:@"devoteName"];
        if (devoteNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [devoteNames objectAtIndex:0];
            userEntity.userDevoteName=firstId.stringValue;
        } else {
            
        }
        //email
        NSArray *emails = [userInfomation elementsForName:@"email"];
        if (emails.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [emails objectAtIndex:0];
            userEntity.userEmail=firstId.stringValue;
            
        } else {
            
        }
        //flag
        NSArray *flags = [userInfomation elementsForName:@"flag"];
        if (flags.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [flags objectAtIndex:0];
            userEntity.userFlag=firstId.stringValue;
            
        } else {
            
        }
        
        //imageUrl
        NSArray *imageUrls = [userInfomation elementsForName:@"imageUrl"];
        if (flags.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            userEntity.imageUrl=firstId.stringValue;
            
        } else {
            
        }
        
        //isActive
        NSArray *isActives = [userInfomation elementsForName:@"isActive"];
        if (isActives.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isActives objectAtIndex:0];
            userEntity.userIsActive=firstId.stringValue;
            
        } else {
            
        }
        
        //nickName
        NSArray *nickNames = [userInfomation elementsForName:@"nickName"];
        if (nickNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [nickNames objectAtIndex:0];
            userEntity.userNickName=firstId.stringValue;
            
        } else {
            
        }

        //score
        NSArray *scores = [userInfomation elementsForName:@"score"];
        if (scores.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
            userEntity.userScore=firstId.stringValue;
        } else {
            
        }
        //regTime
        NSArray *regTimes = [userInfomation elementsForName:@"regTime"];
        if (regTimes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [regTimes objectAtIndex:0];
            userEntity.regTime=firstId.stringValue;
            
        } else {
            
        }
        
        
        //sex
        NSArray *sexs = [userInfomation elementsForName:@"sex"];
        if (sexs.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sexs objectAtIndex:0];
            userEntity.userSex=firstId.stringValue;
            
        } else {
            
        }
    }
    return userEntity;
}

+(void)resendMessage:(NSString *)myPhone
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                              <soap:Body>\
                             <resendMessage xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </resendMessage>\
                             </soap:Body>\
                             </soap:Envelope>", myPhone];
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
    
   // NSData *responseData = [request responseData];
    
   // NSError *error;
   // GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:&error];
   // NSArray *userInfomations = [doc.rootElement nodesForXPath:@"//return" error:&error];
     
}

+(NSString *)modifyCustomer:(NSString *)myCCode :(NSString *)myPhone :(NSString *)strNum
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <modifyCustomer xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             </modifyCustomer>\
                             </soap:Body>\
                             </soap:Envelope>", myCCode, myPhone, strNum];
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
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    GDataXMLElement *root = [doc rootElement];
    NSString *modifyResult = root.stringValue;
        
    return modifyResult;
}

+(NSString *)findPassword:(NSString *)myPhone
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <findPassword xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </findPassword>\
                             </soap:Body>\
                             </soap:Envelope>", myPhone];
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
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    GDataXMLElement *root = [doc rootElement];
    NSString *temporaryPsd = root.stringValue;
   
    
    return temporaryPsd;
}

+(NSString *)addAppointment:(NSString *)appInfo
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"appointment"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <addAppointment xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </addAppointment>\
                             </soap:Body>\
                             </soap:Envelope>", appInfo];
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
    //NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];

    GDataXMLElement *root = [doc rootElement];
    NSString *addAppointmentResult = root.stringValue;

    return addAppointmentResult;

}

+(NSString *)addAppointmentForPhone:(NSString *)appInfo{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"appointment"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <addAppointmentForPhone xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </addAppointmentForPhone>\
                             </soap:Body>\
                             </soap:Envelope>", appInfo];
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
    //NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    GDataXMLElement *root = [doc rootElement];
    NSString *addAppointmentResult = root.stringValue;
    
    return addAppointmentResult;
}
+(NSMutableArray *) getAppointments:(NSString *)customerCode
{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"appointment"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getAppointments xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getAppointments>\
                             </soap:Body>\
                             </soap:Envelope>", customerCode];
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
    
    NSArray *RegistMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
        
    NSMutableArray *registList=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *element in RegistMembers) {
        
         AppointmentModel *appointmentModel=[[AppointmentModel alloc] init];
        
        //appCode
        NSArray *appCodes = [element elementsForName:@"appCode"];
        
        if (appCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [appCodes objectAtIndex:0];
            appointmentModel.appCode=firstId.stringValue;
            
        } else {
        }
        
        // appDate
        NSArray *appDates = [element elementsForName:@"appDate"];
        
        if (appDates.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [appDates objectAtIndex:0];            
            appointmentModel.appDate=firstId.stringValue;
            
        } else {
            
        }
        
        
        // appStatusName
        NSArray *appStatusNames = [element elementsForName:@"appStatusName"];
        
        if (appStatusNames.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [appStatusNames objectAtIndex:0];
            appointmentModel.appStatusName=firstId.stringValue;
            
        } else {
   
        }
        
        // appTableCount
        NSArray *appTableCounts = [element elementsForName:@"appTableCount"];
        
        if (appTableCounts.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [appTableCounts objectAtIndex:0];
            
            appointmentModel.appTableCount=firstId.stringValue;
            
        } else {
  
        }
        // appCustomerCount
        NSArray *appCustomerCounts = [element elementsForName:@"appCustomerCount"];
        
        if (appCustomerCounts.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [appCustomerCounts objectAtIndex:0];
            
            appointmentModel.appCustomerCount=firstId.stringValue;
            
        } else {
            
        }
        // appTime
        NSArray *appTimes = [element elementsForName:@"appTime"];
        
        if (appTimes.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [appTimes objectAtIndex:0];

            appointmentModel.appTime=firstId.stringValue;
        } else {
   
        }
        
        // customerCode
        NSArray *customerCodes = [element elementsForName:@"customerCode"];
        
        if (customerCodes.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [customerCodes objectAtIndex:0];
            
            appointmentModel.customerCode=firstId.stringValue;
         } else {
  
        }
            
        // isPark
        NSArray *isParks = [element elementsForName:@"isPark"];
        
        if (isParks.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [isParks objectAtIndex:0];
            appointmentModel.isPark=firstId.stringValue;
            //NSLog(@"isPark = %@", firstId.stringValue);
          } else {
     
        }
        
        // isProxyDrive
        NSArray *isProxyDrives = [element elementsForName:@"isProxyDrive"];
        
        if (isProxyDrives.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [isProxyDrives objectAtIndex:0];
            
            appointmentModel.isProxyDrive=firstId.stringValue;
            
        } else {
   
        }
        
        // isRoom
        NSArray *isRooms = [element elementsForName:@"isRoom"];
        
        if (isRooms.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [isRooms objectAtIndex:0];
            appointmentModel.isRoom=firstId.stringValue;
            
        } else {
  
        }
       
        // name
        NSArray *names = [element elementsForName:@"name"];
        
        if (names.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            appointmentModel.name=firstId.stringValue;
            
        } else {
  
        }
        
        // phone
        NSArray *phones = [element elementsForName:@"phone"];
        
        if (phones.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
            
            appointmentModel.phone=firstId.stringValue;
        } else {
  
        }
        
//        // purpose
//        NSArray *purposes = [element elementsForName:@"purpose"];
//        
//        if (purposes.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [purposes objectAtIndex:0];
//            
//            NSLog(@"purpose = %@", firstId.stringValue);
//            
//            appointmentModel.purpose=firstId.stringValue;
//            
//        } else {
// 
//        }
        
//        // purposeName
//        NSArray *purposeNames = [element elementsForName:@"purposeName"];
//        
//        if (purposeNames.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [purposeNames objectAtIndex:0];
//            
//            appointmentModel.purposeName=firstId.stringValue;
//            
//            NSLog(@"purposeName = %@", firstId.stringValue);
//            
//        } else {
// 
//        }
//        
//        // room
//        NSArray *rooms = [element elementsForName:@"room"];
//        
//        if (rooms.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [rooms objectAtIndex:0];
//            
//            NSLog(@"room = %@", firstId.stringValue);
//  
//        } else {
//  
//        }
        
        // sdCode
        NSArray *sdCodes = [element elementsForName:@"sdCode"];
        
        if (sdCodes.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [sdCodes objectAtIndex:0];
            
            appointmentModel.sdCode=firstId.stringValue;
              
        } else {
  
        }
        
        // sex
        NSArray *sexs = [element elementsForName:@"sex"];
        
        if (sexs.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [sexs objectAtIndex:0];
            appointmentModel.sex=firstId.stringValue;
          
        } else {
  
        }
        
//        // shopDetailModel
//        NSArray *shopDetailModels = [element elementsForName:@"shopDetailModel"];
//        
//        if (shopDetailModels.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [shopDetailModels objectAtIndex:0];
//            
//            NSLog(@"shopDetailModel = %@", firstId.stringValue);
//
//        } else {
//
//        }
        
        // shopName
        NSArray *shopNames = [element elementsForName:@"shopName"];
        
        if (shopNames.count > 0) {
            
            GDataXMLElement *firstId = (GDataXMLElement *) [shopNames objectAtIndex:0];
            appointmentModel.shopName=firstId.stringValue;
            
        } else {
  
        }
        
//        // table
//        NSArray *tables = [element elementsForName:@"table"];
//        
//        if (tables.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [tables objectAtIndex:0];
//            
//            NSLog(@"table = %@", firstId.stringValue);
//            
//        } else {
//   
//        }
        
//        // tableList
//        NSArray *tableLists = [element elementsForName:@"tableList"];
//        
//        if (tableLists.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [tableLists objectAtIndex:0];
//            
//            NSLog(@"tableList = %@", firstId.stringValue);
//            
//        } else {
//  
//        }
//        
//        // way
//        NSArray *ways = [element elementsForName:@"way"];
//        
//        if (ways.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [ways objectAtIndex:0];
//            
//            NSLog(@"way = %@", firstId.stringValue);
//            
//            appointmentModel.way=firstId.stringValue;
//            
//        } else {
// 
//        }
//        
        // window
//        NSArray *windows = [element elementsForName:@"window"];
//        
//        if (windows.count > 0) {
//            
//            GDataXMLElement *firstId = (GDataXMLElement *) [windows objectAtIndex:0];
//            
//            NSLog(@"window = %@", firstId.stringValue);
//            
//            appointmentModel.window=(int )firstId.stringValue;
//            
//        } else {
//   
//        }
        
        [registList addObject:appointmentModel];
    }
    return registList;
}

+(NSMutableArray *) getShopsForIOS:(NSString *) pageNow :(NSString *) pageSize :(NSString *) code
{
    NSString *pages;
    NSString *nums;
    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopsForIOS xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             </getShopsForIOS>\
                             </soap:Body>\
                             </soap:Envelope>",pageNow,pageSize,code];
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
    //NSLog(@"===========================");
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in customerMembers) {
        
        //totalNum
        NSArray *totalNums = [customerMember elementsForName:@"totalNum"];
        if (totalNums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalNums objectAtIndex:0];
            nums=firstId.stringValue;
           // NSLog(@"%@",firstId.stringValue);
            
        } else {
            
        }
        //totalPage
        NSArray *totalPages = [customerMember elementsForName:@"totalPage"];
        if (totalPages.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalPages objectAtIndex:0];
            pages=firstId.stringValue;
            //NSLog(@"%@",firstId.stringValue);
        } else {
            
        }
        //resultList
        NSArray *resultLists = [customerMember elementsForName:@"resultList"];
        if (resultLists.count > 0) {
            
            //GDataXMLElement *firstId = (GDataXMLElement *) [resultLists objectAtIndex:0];
            //NSLog(@"addTime = %@", firstId.stringValue);
            for (GDataXMLElement *shopList in shopLists){
                
                ResEntity *resEntity=[[ResEntity alloc] init];
                resEntity.totalNum=nums;
                resEntity.totalPage=pages;
            // NSLog(@"%@",resEntity.totalNum);
            //NSLog(@"%@",resEntity.totalPage);
                //addTime
                NSArray *addTimes = [shopList elementsForName:@"addTime"];
                if (addTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdAddress
                NSArray *addresses = [shopList elementsForName:@"sdAddress"];
                if (addresses.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
                    resEntity.ResAddressTxt=firstId.stringValue;
                    //NSLog(@"%@",resEntity.ResAddressTxt);
                } else {
                    
                }
                
                // appTotalPercen
                NSArray *appTotalPercens = [shopList elementsForName:@"appTotalPercen"];
                if (appTotalPercens.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];
                    
                } else {
                    
                }
                
                // applicationId
                NSArray *applicationIds = [shopList elementsForName:@"applicationId"];
                if (applicationIds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdAvgCon
                NSArray *avgCons = [shopList elementsForName:@"sdAvgCon"];
                if (avgCons.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
                    resEntity.resPriceTxt=firstId.stringValue;
                    //NSLog(@"%@",resEntity.resPriceTxt);
                } else {
                    
                }
                
                // bus
                NSArray *buses = [shopList elementsForName:@"bus"];
                if (buses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // certificate
                NSArray *certificates = [shopList elementsForName:@"certificate"];
                if (certificates.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdCode
                NSArray *codes = [shopList elementsForName:@"sdCode"];
                if (codes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
                    resEntity.resCode=firstId.stringValue;
                    //NSLog(@"%@",resEntity.resCode);
                } else {
                    
                }
                
                // contacter
                NSArray *contacters = [shopList elementsForName:@"contacter"];
                if (contacters.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdGrade
                NSArray *grades = [shopList elementsForName:@"sdGrade"];
                if (grades.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
                    resEntity.ResStarGradeTxt=firstId.stringValue;
                    
                } else {
                    
                }
                // distance
                NSArray *distances = [shopList elementsForName:@"distance"];
                if (distances.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
                    resEntity.resDistanceTxt=firstId.stringValue;
                   // NSLog(@"%@",resEntity.resDistanceTxt);
                    
                } else {
                    
                }
                
                
                // ico
                NSArray *icos = [shopList elementsForName:@"ico"];
                if (icos.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
                    
                } else {
                    
                }
                
                // imageUrl
                NSArray *imageUrls = [shopList elementsForName:@"imageUrl"];
                if (imageUrls.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
                    resEntity.resImg=firstId.stringValue;
                    
                } else {
                    
                }
                
                // sdIntro
                NSArray *intros = [shopList elementsForName:@"sdIntro"];
                if (intros.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
                    resEntity.resIntro=firstId.stringValue;
                    //NSLog(@"%@",firstId.stringValue);
                    
                } else {
                    
                }
                
                // isAllowApp
                NSArray *isAllowApps = [shopList elementsForName:@"isAllowApp"];
                if (isAllowApps.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isAudit
                NSArray *isAudits = [shopList elementsForName:@"isAudit"];
                if (isAudits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isDoubleScore
                NSArray *isDoubleScores = [shopList elementsForName:@"isDoubleScore"];
                if (isDoubleScores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isRecommed
                NSArray *isRecommeds = [shopList elementsForName:@"isRecommed"];
                if (isRecommeds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // lastSMS
                NSArray *lastSMSes = [shopList elementsForName:@"lastSMS"];
                if (lastSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdLatitude
                NSArray *latitudes = [shopList elementsForName:@"sdLatitude"];
                if (latitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
                    resEntity.latitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // license
                NSArray *licenses = [shopList elementsForName:@"license"];
                if (licenses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdLongitude
                NSArray *longitudes = [shopList elementsForName:@"sdLongitude"];
                if (longitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
                    resEntity.longitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // sdName
                NSArray *names = [shopList elementsForName:@"sdName"];
                if (names.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
                    resEntity.resNameTxt=firstId.stringValue;
                   // NSLog(@"%@",firstId.stringValue);
                } else {
                    
                }
                
                // payment
                NSArray *payments = [shopList elementsForName:@"payment"];
                if (payments.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdPhone
                NSArray *phones = [shopList elementsForName:@"sdPhone"];
                if (phones.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
                    resEntity.ResTelTxt=firstId.stringValue;
                   // NSLog(@"%@",firstId.stringValue);
                } else {
                    
                }
                
                // score
                NSArray *scores = [shopList elementsForName:@"score"];
                if (scores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdArea
                NSArray *sdAreas = [shopList elementsForName:@"sdArea"];
                if (sdAreas.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
                    resEntity.resSdArea=firstId.stringValue;
                   // NSLog(@"%@",firstId.stringValue);
                } else {
                    
                }
                
                // sdAreaCode
                NSArray *sdAreaCodes = [shopList elementsForName:@"sdAreaCode"];
                if (sdAreaCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdDeposit
                NSArray *sdDeposits = [shopList elementsForName:@"sdDeposit"];
                if (sdDeposits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdMessageCode
                NSArray *sdMessageCodes = [shopList elementsForName:@"sdMessageCode"];
                if (sdMessageCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegion
                NSArray *sdRegions = [shopList elementsForName:@"sdRegion"];
                if (sdRegions.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegionCode
                NSArray *sdRegionCodes = [shopList elementsForName:@"sdRegionCode"];
                if (sdRegionCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // status
                NSArray *statuses = [shopList elementsForName:@"status"];
                if (statuses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // totalSMS
                NSArray *totalSMSes = [shopList elementsForName:@"totalSMS"];
                if (totalSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // workTime
                NSArray *workTimes = [shopList elementsForName:@"workTime"];
                if (workTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // mPhone
                NSArray *mPhones = [shopList elementsForName:@"mPhone"];
                if (mPhones.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
                    
                } else {
                    
                }
                
                [restaurants addObject:resEntity];
            } 
            
        } else {
            
        }  
    }
    return restaurants;
}

+(NSMutableArray *) getShopDetailInfoByIsRecommedForIOS:(NSString *) pageNow :(NSString *) pageSize
{
    NSString *pages;
    NSString *nums;
    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopDetailInfoByIsRecommedForIOS xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             </getShopDetailInfoByIsRecommedForIOS>\
                             </soap:Body>\
                             </soap:Envelope>",pageNow,pageSize];
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
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *shopLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in customerMembers) {
        
        //totalNum
        NSArray *totalNums = [customerMember elementsForName:@"totalNum"];
        if (totalNums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalNums objectAtIndex:0];
            nums=firstId.stringValue;
           // NSLog(@"%@",nums);
        } else {
            
        }
        //totalPage
        NSArray *totalPages = [customerMember elementsForName:@"totalPage"];
        if (totalPages.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalPages objectAtIndex:0];
            pages=firstId.stringValue;
            //NSLog(@"%@",pages);
        } else {
            
        }
        //resultList
        NSArray *resultLists = [customerMember elementsForName:@"resultList"];
        if (resultLists.count > 0) {
            
            //GDataXMLElement *firstId = (GDataXMLElement *) [resultLists objectAtIndex:0];
            //NSLog(@"addTime = %@", firstId.stringValue);
            for (GDataXMLElement *shopList in shopLists){
                
                ResEntity *resEntity=[[ResEntity alloc] init];
                resEntity.totalNum=nums;
                resEntity.totalPage=pages;
                
                //addTime
                NSArray *addTimes = [shopList elementsForName:@"addTime"];
                if (addTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // address
                NSArray *addresses = [shopList elementsForName:@"address"];
                if (addresses.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
                    resEntity.ResAddressTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // appTotalPercen
                NSArray *appTotalPercens = [shopList elementsForName:@"appTotalPercen"];
                if (appTotalPercens.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [appTotalPercens objectAtIndex:0];
                    
                } else {
                    
                }
                
                // applicationId
                NSArray *applicationIds = [shopList elementsForName:@"applicationId"];
                if (applicationIds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [applicationIds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // avgCon
                NSArray *avgCons = [shopList elementsForName:@"avgCon"];
                if (avgCons.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
                    resEntity.resPriceTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // bus
                NSArray *buses = [shopList elementsForName:@"bus"];
                if (buses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [buses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // certificate
                NSArray *certificates = [shopList elementsForName:@"certificate"];
                if (certificates.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [certificates objectAtIndex:0];
                    
                } else {
                    
                }
                
                // code
                NSArray *codes = [shopList elementsForName:@"code"];
                if (codes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
                    resEntity.resCode=firstId.stringValue;
                } else {
                    
                }
                
                // contacter
                NSArray *contacters = [shopList elementsForName:@"contacter"];
                if (contacters.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [contacters objectAtIndex:0];
                    
                } else {
                    
                }
                
                // grade
                NSArray *grades = [shopList elementsForName:@"grade"];
                if (grades.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
                    resEntity.ResStarGradeTxt=firstId.stringValue;
                    
                } else {
                    
                }
                // distance
                NSArray *distances = [shopList elementsForName:@"distance"];
                if (distances.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
                    resEntity.resDistanceTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                
                // ico
                NSArray *icos = [shopList elementsForName:@"ico"];
                if (icos.count > 0) {
                    // GDataXMLElement *firstId = (GDataXMLElement *) [icos objectAtIndex:0];
                    
                } else {
                    
                }
                
                // imageUrl
                NSArray *imageUrls = [shopList elementsForName:@"imageUrl"];
                if (imageUrls.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
                    resEntity.resImg=firstId.stringValue;
                    
                } else {
                    
                }
                
                // intro
                NSArray *intros = [shopList elementsForName:@"intro"];
                if (intros.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
                    resEntity.resIntro=firstId.stringValue;
                   // NSLog(@"%@",firstId.stringValue);
                    
                } else {
                    
                }
                
                // isAllowApp
                NSArray *isAllowApps = [shopList elementsForName:@"isAllowApp"];
                if (isAllowApps.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isAudit
                NSArray *isAudits = [shopList elementsForName:@"isAudit"];
                if (isAudits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isDoubleScore
                NSArray *isDoubleScores = [shopList elementsForName:@"isDoubleScore"];
                if (isDoubleScores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // isRecommed
                NSArray *isRecommeds = [shopList elementsForName:@"isRecommed"];
                if (isRecommeds.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
                    
                } else {
                    
                }
                
                // lastSMS
                NSArray *lastSMSes = [shopList elementsForName:@"lastSMS"];
                if (lastSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // latitude
                NSArray *latitudes = [shopList elementsForName:@"latitude"];
                if (latitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
                    resEntity.latitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // license
                NSArray *licenses = [shopList elementsForName:@"license"];
                if (licenses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // longitude
                NSArray *longitudes = [shopList elementsForName:@"longitude"];
                if (longitudes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
                    resEntity.longitude=firstId.stringValue;
                    
                } else {
                    
                }
                
                // name
                NSArray *names = [shopList elementsForName:@"name"];
                if (names.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
                    resEntity.resNameTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // payment
                NSArray *payments = [shopList elementsForName:@"payment"];
                if (payments.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
                    
                } else {
                    
                }
                
                // phone
                NSArray *phones = [shopList elementsForName:@"phone"];
                if (phones.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
                    resEntity.ResTelTxt=firstId.stringValue;
                    
                } else {
                    
                }
                
                // score
                NSArray *scores = [shopList elementsForName:@"score"];
                if (scores.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdArea
                NSArray *sdAreas = [shopList elementsForName:@"sdArea"];
                if (sdAreas.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
                    resEntity.resSdArea=firstId.stringValue;
                    
                } else {
                    
                }
                
                // sdAreaCode
                NSArray *sdAreaCodes = [shopList elementsForName:@"sdAreaCode"];
                if (sdAreaCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdAreaCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdDeposit
                NSArray *sdDeposits = [shopList elementsForName:@"sdDeposit"];
                if (sdDeposits.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdDeposits objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdMessageCode
                NSArray *sdMessageCodes = [shopList elementsForName:@"sdMessageCode"];
                if (sdMessageCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdMessageCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegion
                NSArray *sdRegions = [shopList elementsForName:@"sdRegion"];
                if (sdRegions.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegions objectAtIndex:0];
                    
                } else {
                    
                }
                
                // sdRegionCode
                NSArray *sdRegionCodes = [shopList elementsForName:@"sdRegionCode"];
                if (sdRegionCodes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [sdRegionCodes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // status
                NSArray *statuses = [shopList elementsForName:@"status"];
                if (statuses.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [statuses objectAtIndex:0];
                    
                } else {
                    
                }
                
                // totalSMS
                NSArray *totalSMSes = [shopList elementsForName:@"totalSMS"];
                if (totalSMSes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [totalSMSes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // workTime
                NSArray *workTimes = [shopList elementsForName:@"workTime"];
                if (workTimes.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [workTimes objectAtIndex:0];
                    
                } else {
                    
                }
                
                // mPhone
                NSArray *mPhones = [shopList elementsForName:@"mPhone"];
                if (mPhones.count > 0) {
                    //GDataXMLElement *firstId = (GDataXMLElement *) [mPhones objectAtIndex:0];
                    
                } else {
                    
                }
                
                [restaurants addObject:resEntity];
            } 
            
        } else {
            
        }  
    }
    return restaurants;
}


+ (void) checkAppInfo:(NSString *)Info{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"appointment"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <checkAppInfo xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </checkAppInfo>\
                             </soap:Body>\
                             </soap:Envelope>", Info];
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
    
}

+(NSMutableArray *) getAppointmentByAppCode:(NSString *)appointmentCode{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"appointment"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getAppointmentByAppCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getAppointmentByAppCode>\
                             </soap:Body>\
                             </soap:Envelope>", appointmentCode];
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
    NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    
    NSMutableArray *appDishLists=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in dishMembers) {
        
        DishEntity *dishEntity=[[DishEntity alloc] init];
        //discount
        NSArray *discounts = [customerMember elementsForName:@"discount"];
        if (discounts.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [discounts objectAtIndex:0];
            dishEntity.discount=[firstId stringValue];
        } else {
            
        }
        //dishCode
        NSArray *dishCodes = [customerMember elementsForName:@"dishCode"];
        if (dishCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishCodes objectAtIndex:0];
            dishEntity.dishCode=[firstId stringValue];
        } else {
            
        }
        //dishName
        NSArray *dishNames = [customerMember elementsForName:@"dishName"];
        if (dishNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishNames objectAtIndex:0];
            dishEntity.dishName=[firstId stringValue];
        } else {
            
        }
        //dishPrice
        NSArray *dishPrices = [customerMember elementsForName:@"dishPrice"];
        if (dishPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishPrices objectAtIndex:0];
            dishEntity.dishPrice=[firstId stringValue];
        } else {
            
        }
        //isFeatureDish
        NSArray *isFeatureDishs = [customerMember elementsForName:@"isFeatureDish"];
        if (isFeatureDishs.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isFeatureDishs objectAtIndex:0];
            dishEntity.isFeatureDish=[firstId stringValue];
        } else {
            
        }
        //num
        NSArray *nums = [customerMember elementsForName:@"num"];
        if (nums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [nums objectAtIndex:0];
            dishEntity.num=[firstId stringValue];
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            dishEntity.imageUrl=[firstId stringValue];
        } else {
            
        }
        
        [appDishLists addObject:dishEntity];
    }
    return appDishLists;
}

+(NSMutableArray *) getDishInfoBySDCodeForIOS:(NSString *)pageNow :(NSString *)pageSize :(NSString *)resCode{
    NSString *pages;
    NSString *nums;
    
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"dish"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getDishInfoBySDCodeForIOS xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             <arg2>%@</arg2>\
                             </getDishInfoBySDCodeForIOS>\
                             </soap:Body>\
                             </soap:Envelope>",pageNow,pageSize,resCode];
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
    NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    NSArray *dishLists = [doc.rootElement nodesForXPath:@"//resultList" error:&error];
    
    NSMutableArray *dishes=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in dishMembers) {
        
        //totalNum
        NSArray *totalNums = [customerMember elementsForName:@"totalNum"];
        if (totalNums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalNums objectAtIndex:0];
            nums=firstId.stringValue;
            NSLog(@"%@",nums);
        } else {
            
        }
        //totalPage
        NSArray *totalPages = [customerMember elementsForName:@"totalPage"];
        if (totalPages.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [totalPages objectAtIndex:0];
            pages=firstId.stringValue;
            NSLog(@"%@",pages);
        } else {
            
        }
        //resultList
        NSArray *resultLists = [customerMember elementsForName:@"resultList"];
        if (resultLists.count > 0) {
            
            //GDataXMLElement *firstId = (GDataXMLElement *) [resultLists objectAtIndex:0];
            //NSLog(@"addTime = %@", firstId.stringValue);
            for (GDataXMLElement *customerMember in dishLists) {
                DishEntity *dishEntity=[[DishEntity alloc] init];
                dishEntity.totalPage=pages;
                dishEntity.totalNum=nums;
                //discount
                NSArray *discounts = [customerMember elementsForName:@"discount"];
                if (discounts.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [discounts objectAtIndex:0];
                    dishEntity.discount=[firstId stringValue];
                    // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishCode
                NSArray *dishCodes = [customerMember elementsForName:@"dishCode"];
                if (dishCodes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishCodes objectAtIndex:0];
                    dishEntity.dishCode=[firstId stringValue];
                    // NSLog(@"dishEntity.dishCode======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishName
                NSArray *dishNames = [customerMember elementsForName:@"dishName"];
                if (dishNames.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishNames objectAtIndex:0];
                    dishEntity.dishName=[firstId stringValue];
                    //NSLog(@"dishEntity.dishName======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishNum
                NSArray *dishNums = [customerMember elementsForName:@"dishNum"];
                if (dishNums.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishNums objectAtIndex:0];
                    dishEntity.dishNum=[firstId stringValue];
                    // NSLog(@"dishEntity.dishNum======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishPoint
                NSArray *dishPoints = [customerMember elementsForName:@"dishPoint"];
                if (dishPoints.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishPoints objectAtIndex:0];
                    dishEntity.dishPoint=[firstId stringValue];
                    // NSLog(@"dishEntity.dishPoint======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishPrice
                NSArray *dishPrices = [customerMember elementsForName:@"dishPrice"];
                if (dishPrices.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishPrices objectAtIndex:0];
                    dishEntity.dishPrice=[firstId stringValue];
                    // NSLog(@"dishEntity.dishPrice======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishPriceS
                NSArray *dishPriceSs = [customerMember elementsForName:@"dishPriceS"];
                if (dishPriceSs.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishPriceSs objectAtIndex:0];
                    dishEntity.dishPriceS=[firstId stringValue];
                    // NSLog(@"dishEntity.dishPriceS======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishScore
                NSArray *dishScores = [customerMember elementsForName:@"dishScore"];
                if (dishScores.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishScores objectAtIndex:0];
                    dishEntity.dishScore=[firstId stringValue];
                    // NSLog(@"dishEntity.dishScore======%@",[firstId stringValue]);
                } else {
                    
                }
                //dishUnit
                NSArray *dishUnits = [customerMember elementsForName:@"dishUnit"];
                if (dishUnits.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [dishUnits objectAtIndex:0];
                    dishEntity.dishUnit=[firstId stringValue];
                    // NSLog(@"dishEntity.dishUnit======%@",[firstId stringValue]);
                } else {
                    
                }
                //imageCode
                NSArray *imageCodes = [customerMember elementsForName:@"imageCode"];
                if (imageCodes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageCodes objectAtIndex:0];
                    dishEntity.imageCode=[firstId stringValue];
                    // NSLog(@"dishEntity.imageCode======%@",[firstId stringValue]);
                } else {
                    
                }
                //imageUrl
                NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
                if (imageUrls.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
                    dishEntity.imageUrl=[firstId stringValue];
                    // NSLog(@"dishEntity.imageUrl======%@",[firstId stringValue]);
                } else {
                    
                }
                //isDelete
                NSArray *isDeletes = [customerMember elementsForName:@"isDelete"];
                if (isDeletes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [isDeletes objectAtIndex:0];
                    dishEntity.isDelete=[firstId stringValue];
                    // NSLog(@"dishEntity.isDelete======%@",[firstId stringValue]);
                } else {
                    
                }
                //isDiscount
                NSArray *isDiscounts = [customerMember elementsForName:@"isDiscount"];
                if (isDiscounts.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [isDiscounts objectAtIndex:0];
                    dishEntity.isDiscount=[firstId stringValue];
                    // NSLog(@"dishEntity.isDiscount======%@",[firstId stringValue]);
                } else {
                    
                }
                //isDishPoint
                NSArray *isDishPoints = [customerMember elementsForName:@"isDishPoint"];
                if (isDishPoints.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [isDishPoints objectAtIndex:0];
                    dishEntity.isDishPoint=[firstId stringValue];
                    // NSLog(@"dishEntity.isDishPoint======%@",[firstId stringValue]);
                } else {
                    
                }
                //isFeatureDish
                NSArray *isFeatureDishs = [customerMember elementsForName:@"isFeatureDish"];
                if (isFeatureDishs.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [isFeatureDishs objectAtIndex:0];
                    dishEntity.isFeatureDish=[firstId stringValue];
                    // NSLog(@"dishEntity.isFeatureDish======%@",[firstId stringValue]);
                } else {
                    
                }
                //menuCode
                NSArray *menuCodes = [customerMember elementsForName:@"menuCode"];
                if (menuCodes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [menuCodes objectAtIndex:0];
                    dishEntity.menuCode=[firstId stringValue];
                    //  NSLog(@"dishEntity.menuCode======%@",[firstId stringValue]);
                } else {
                    
                }
                //menuName
                NSArray *menuNames = [customerMember elementsForName:@"menuName"];
                if (menuNames.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [menuNames objectAtIndex:0];
                    dishEntity.menuName=[firstId stringValue];
                    //  NSLog(@"dishEntity.menuName======%@",[firstId stringValue]);
                } else {
                    
                }
                //num
                NSArray *nums = [customerMember elementsForName:@"num"];
                if (nums.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [nums objectAtIndex:0];
                    dishEntity.num=[firstId stringValue];
                    // NSLog(@"dishEntity.num======%@",[firstId stringValue]);
                } else {
                    
                }
                //pyDishName
                NSArray *pyDishNames = [customerMember elementsForName:@"pyDishName"];
                if (pyDishNames.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [pyDishNames objectAtIndex:0];
                    dishEntity.pyDishName=[firstId stringValue];
                    // NSLog(@"dishEntity.pyDishName======%@",[firstId stringValue]);
                } else {
                    
                }
                //shopCode
                NSArray *shopCodes = [customerMember elementsForName:@"shopCode"];
                if (shopCodes.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [shopCodes objectAtIndex:0];
                    dishEntity.shopCode=[firstId stringValue];
                    //  NSLog(@"dishEntity.shopCode======%@",[firstId stringValue]);
                } else {
                    
                }
                //shopName
                NSArray *shopNames = [customerMember elementsForName:@"shopName"];
                if (shopNames.count > 0) {
                    GDataXMLElement *firstId = (GDataXMLElement *) [shopNames objectAtIndex:0];
                    dishEntity.shopName=[firstId stringValue];
                    // NSLog(@"dishEntity.shopName======%@",[firstId stringValue]);
                } else {
                    
                }
                
                
                [dishes addObject:dishEntity];
            }
        }else {
            
        }
    }
    return dishes;
}

+(NSMutableArray *) getEventInfoBySDCode:(NSString *)resCode{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"event"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getEventInfoBySDCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getEventInfoBySDCode>\
                             </soap:Body>\
                             </soap:Envelope>",resCode];
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
    NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
   
    
    NSMutableArray *shopActivities=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in dishMembers) {
        ActivityEntity *activityEntity=[[ActivityEntity alloc] init];
        
        //eventCode
        NSArray *eventCodes = [customerMember elementsForName:@"eventCode"];
        if (eventCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventCodes objectAtIndex:0];
            activityEntity.eventCode=[firstId stringValue];
        } else {
            
        }
        //eventIntro
        NSArray *eventIntros = [customerMember elementsForName:@"eventIntro"];
        if (eventIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventIntros objectAtIndex:0];
            activityEntity.eventIntro=[firstId stringValue];
        } else {
            
        }
        //eventName
        NSArray *eventNames = [customerMember elementsForName:@"eventName"];
        if (eventNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventNames objectAtIndex:0];
            activityEntity.eventName=[firstId stringValue];
        } else {
            
        }
        //eventPrice
        NSArray *eventPrices = [customerMember elementsForName:@"eventPrice"];
        if (eventPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [eventPrices objectAtIndex:0];
            activityEntity.eventPrice=[firstId stringValue];
        } else {
            
        }
        //flage
        NSArray *flages = [customerMember elementsForName:@"flag"];
        if (flages.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [flages objectAtIndex:0];
            activityEntity.flage=[firstId stringValue];
            
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (eventPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            activityEntity.imageUrl=[firstId stringValue];
        } else {
            
        }
        
        [shopActivities addObject:activityEntity];
    }
    
    return shopActivities;
}

+(NSMutableArray *) getDishsByEventCode:(NSString *)evenCode{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"event"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getDishsByEventCode xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getDishsByEventCode>\
                             </soap:Body>\
                             </soap:Envelope>",evenCode];
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
    NSArray *dishMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    
    NSMutableArray *activityDishes=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in dishMembers) {
        DishEntity *dishEntity=[[DishEntity alloc] init];
        
        //discount
        NSArray *discounts = [customerMember elementsForName:@"discount"];
        if (discounts.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [discounts objectAtIndex:0];
            dishEntity.discount=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //dishCode
        NSArray *dishCodes = [customerMember elementsForName:@"dishCode"];
        if (dishCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishCodes objectAtIndex:0];
            dishEntity.dishCode=[firstId stringValue];
            // NSLog(@"dishEntity.dishCode======%@",[firstId stringValue]);
        } else {
            
        }
        //dishName
        NSArray *dishNames = [customerMember elementsForName:@"dishName"];
        if (dishNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishNames objectAtIndex:0];
            dishEntity.dishName=[firstId stringValue];
            //NSLog(@"dishEntity.dishName======%@",[firstId stringValue]);
        } else {
            
        }
        //dishNum
        NSArray *dishNums = [customerMember elementsForName:@"dishNum"];
        if (dishNums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishNums objectAtIndex:0];
            dishEntity.dishNum=[firstId stringValue];
            // NSLog(@"dishEntity.dishNum======%@",[firstId stringValue]);
        } else {
            
        }
        //dishPoint
        NSArray *dishPoints = [customerMember elementsForName:@"dishPoint"];
        if (dishPoints.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishPoints objectAtIndex:0];
            dishEntity.dishPoint=[firstId stringValue];
            // NSLog(@"dishEntity.dishPoint======%@",[firstId stringValue]);
        } else {
            
        }
        //dishPrice
        NSArray *dishPrices = [customerMember elementsForName:@"dishPrice"];
        if (dishPrices.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishPrices objectAtIndex:0];
            dishEntity.dishPrice=[firstId stringValue];
            // NSLog(@"dishEntity.dishPrice======%@",[firstId stringValue]);
        } else {
            
        }
        //dishPriceS
        NSArray *dishPriceSs = [customerMember elementsForName:@"dishPriceS"];
        if (dishPriceSs.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishPriceSs objectAtIndex:0];
            dishEntity.dishPriceS=[firstId stringValue];
            // NSLog(@"dishEntity.dishPriceS======%@",[firstId stringValue]);
        } else {
            
        }
        //dishScore
        NSArray *dishScores = [customerMember elementsForName:@"dishScore"];
        if (dishScores.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [dishScores objectAtIndex:0];
            dishEntity.dishScore=[firstId stringValue];
            // NSLog(@"dishEntity.dishScore======%@",[firstId stringValue]);
        } else {
            
        }
//        //dishUnit
//        NSArray *dishUnits = [customerMember elementsForName:@"dishUnit"];
//        if (dishUnits.count > 0) {
//            GDataXMLElement *firstId = (GDataXMLElement *) [dishUnits objectAtIndex:0];
//            dishEntity.dishUnit=[firstId stringValue];
//            // NSLog(@"dishEntity.dishUnit======%@",[firstId stringValue]);
//        } else {
//            
//        }
        //imageCode
        NSArray *imageCodes = [customerMember elementsForName:@"imageCode"];
        if (imageCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageCodes objectAtIndex:0];
            dishEntity.imageCode=[firstId stringValue];
            // NSLog(@"dishEntity.imageCode======%@",[firstId stringValue]);
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            dishEntity.imageUrl=[firstId stringValue];
             //NSLog(@"dishEntity.imageUrl======%@",[firstId stringValue]);
        } else {
            
        }
        //isDelete
        NSArray *isDeletes = [customerMember elementsForName:@"isDelete"];
        if (isDeletes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isDeletes objectAtIndex:0];
            dishEntity.isDelete=[firstId stringValue];
            // NSLog(@"dishEntity.isDelete======%@",[firstId stringValue]);
        } else {
            
        }
        //isDiscount
        NSArray *isDiscounts = [customerMember elementsForName:@"isDiscount"];
        if (isDiscounts.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isDiscounts objectAtIndex:0];
            dishEntity.isDiscount=[firstId stringValue];
            // NSLog(@"dishEntity.isDiscount======%@",[firstId stringValue]);
        } else {
            
        }
        //isDishPoint
        NSArray *isDishPoints = [customerMember elementsForName:@"isDishPoint"];
        if (isDishPoints.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isDishPoints objectAtIndex:0];
            dishEntity.isDishPoint=[firstId stringValue];
            // NSLog(@"dishEntity.isDishPoint======%@",[firstId stringValue]);
        } else {
            
        }
        //isFeatureDish
        NSArray *isFeatureDishs = [customerMember elementsForName:@"isFeatureDish"];
        if (isFeatureDishs.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [isFeatureDishs objectAtIndex:0];
            dishEntity.isFeatureDish=[firstId stringValue];
            // NSLog(@"dishEntity.isFeatureDish======%@",[firstId stringValue]);
        } else {
            
        }
        //menuCode
        NSArray *menuCodes = [customerMember elementsForName:@"menuCode"];
        if (menuCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [menuCodes objectAtIndex:0];
            dishEntity.menuCode=[firstId stringValue];
            //  NSLog(@"dishEntity.menuCode======%@",[firstId stringValue]);
        } else {
            
        }
        //menuName
        NSArray *menuNames = [customerMember elementsForName:@"menuName"];
        if (menuNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [menuNames objectAtIndex:0];
            dishEntity.menuName=[firstId stringValue];
            //  NSLog(@"dishEntity.menuName======%@",[firstId stringValue]);
        } else {
            
        }
        //num
        NSArray *nums = [customerMember elementsForName:@"num"];
        if (nums.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [nums objectAtIndex:0];
            dishEntity.num=[firstId stringValue];
            // NSLog(@"dishEntity.num======%@",[firstId stringValue]);
        } else {
            
        }
        //pyDishName
        NSArray *pyDishNames = [customerMember elementsForName:@"pyDishName"];
        if (pyDishNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [pyDishNames objectAtIndex:0];
            dishEntity.pyDishName=[firstId stringValue];
            // NSLog(@"dishEntity.pyDishName======%@",[firstId stringValue]);
        } else {
            
        }
        //shopCode
        NSArray *shopCodes = [customerMember elementsForName:@"shopCode"];
        if (shopCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [shopCodes objectAtIndex:0];
            dishEntity.shopCode=[firstId stringValue];
            //  NSLog(@"dishEntity.shopCode======%@",[firstId stringValue]);
        } else {
            
        }
        //shopName
        NSArray *shopNames = [customerMember elementsForName:@"shopName"];
        if (shopNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [shopNames objectAtIndex:0];
            dishEntity.shopName=[firstId stringValue];
            // NSLog(@"dishEntity.shopName======%@",[firstId stringValue]);
        } else {
            
        }
        [activityDishes addObject:dishEntity];
    }
    
    return activityDishes;
}

+ (NSMutableArray *) getCoupons{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getCoupons xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             </getCoupons>\
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
   // NSLog(@"%@", [doc rootElement]);
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    NSMutableArray *coupons=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        
        //couponCode
        NSArray *couponCodes = [customerMember elementsForName:@"couponCode"];
        if (couponCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponCodes objectAtIndex:0];
            couponEntity.couponCode=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //couponIntro
        NSArray *couponIntros = [customerMember elementsForName:@"couponIntro"];
        if (couponIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponIntros objectAtIndex:0];
            couponEntity.couponIntro=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //couponName
        NSArray *couponNames = [customerMember elementsForName:@"couponName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //sdName
        NSArray *sdNames = [customerMember elementsForName:@"sdName"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //views
        NSArray *viewses = [customerMember elementsForName:@"views"];
        if (viewses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [viewses objectAtIndex:0];
            couponEntity.views=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl=[firstId stringValue];
           // NSLog(@"%@",couponEntity.imageUrl);
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        [coupons addObject:couponEntity];
    }
    
    return coupons;
}

+ (NSMutableArray *) getCouponsByType:(NSString *)type{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getCouponsByType xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getCouponsByType>\
                             </soap:Body>\
                             </soap:Envelope>",type];
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
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    NSMutableArray *coupons=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        
        //couponCode
        NSArray *couponCodes = [customerMember elementsForName:@"couponCode"];
        if (couponCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponCodes objectAtIndex:0];
            couponEntity.couponCode=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //couponIntro
        NSArray *couponIntros = [customerMember elementsForName:@"couponIntro"];
        if (couponIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponIntros objectAtIndex:0];
            couponEntity.couponIntro=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //couponName
        NSArray *couponNames = [customerMember elementsForName:@"couponName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //sdName
        NSArray *sdNames = [customerMember elementsForName:@"sdName"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //views
        NSArray *viewses = [customerMember elementsForName:@"views"];
        if (viewses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [viewses objectAtIndex:0];
            couponEntity.views=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl=[firstId stringValue];
           // NSLog(@"%@",couponEntity.imageUrl);
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        [coupons addObject:couponEntity];
    }
    
    return coupons;
}

+ (NSMutableArray *) getFavoritesCoupons:(NSString *)couponString{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"coupon"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getFavoritesCoupons xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getFavoritesCoupons>\
                             </soap:Body>\
                             </soap:Envelope>",couponString];
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
    NSArray *couponMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    NSMutableArray *coupons=[[NSMutableArray alloc] init];
    
    for (GDataXMLElement *customerMember in couponMembers) {
        CouponEntity *couponEntity=[[CouponEntity alloc] init];
        
        //couponCode
        NSArray *couponCodes = [customerMember elementsForName:@"couponCode"];
        if (couponCodes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponCodes objectAtIndex:0];
            couponEntity.couponCode=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //couponIntro
        NSArray *couponIntros = [customerMember elementsForName:@"couponIntro"];
        if (couponIntros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponIntros objectAtIndex:0];
            couponEntity.couponIntro=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //couponName
        NSArray *couponNames = [customerMember elementsForName:@"couponName"];
        if (couponNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [couponNames objectAtIndex:0];
            couponEntity.couponName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //sdName
        NSArray *sdNames = [customerMember elementsForName:@"sdName"];
        if (sdNames.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [sdNames objectAtIndex:0];
            couponEntity.sdName=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        //views
        NSArray *viewses = [customerMember elementsForName:@"views"];
        if (viewses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [viewses objectAtIndex:0];
            couponEntity.views=[firstId stringValue];
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        //imageUrl
        NSArray *imageUrls = [customerMember elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            couponEntity.imageUrl=[firstId stringValue];
           // NSLog(@"%@",couponEntity.imageUrl);
            // NSLog(@"dishEntity.discount======%@",[firstId stringValue]);
        } else {
            
        }
        
        [coupons addObject:couponEntity];
    }
    
    return coupons;
}

+ (NSMutableArray *) getShopsBySDName:(NSString *)sdName{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"search"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <getShopsBySDName xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             </getShopsBySDName>\
                             </soap:Body>\
                             </soap:Envelope>",sdName];
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
    //NSLog(@"===========================");
    NSArray *customerMembers = [doc.rootElement nodesForXPath:@"//return" error:&error];
    
    
    NSMutableArray *restaurants=[[NSMutableArray alloc] init];
    for (GDataXMLElement *shopList in customerMembers){
        
        ResEntity *resEntity=[[ResEntity alloc] init];
    
        // NSLog(@"%@",resEntity.totalNum);
        //NSLog(@"%@",resEntity.totalPage);
        //addTime
        NSArray *addTimes = [shopList elementsForName:@"addTime"];
        if (addTimes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [addTimes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdAddress
        NSArray *addresses = [shopList elementsForName:@"address"];
        if (addresses.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [addresses objectAtIndex:0];
            resEntity.ResAddressTxt=firstId.stringValue;
            //NSLog(@"%@",resEntity.ResAddressTxt);
        } else {
            
        }
        

        
        // sdAvgCon
        NSArray *avgCons = [shopList elementsForName:@"avgCon"];
        if (avgCons.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [avgCons objectAtIndex:0];
            resEntity.resPriceTxt=firstId.stringValue;
            //NSLog(@"%@",resEntity.resPriceTxt);
        } else {
            
        }
        
       
        
        // sdCode
        NSArray *codes = [shopList elementsForName:@"code"];
        if (codes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [codes objectAtIndex:0];
            resEntity.resCode=firstId.stringValue;
            //NSLog(@"%@",resEntity.resCode);
        } else {
            
        }
       
        
        // sdGrade
        NSArray *grades = [shopList elementsForName:@"grade"];
        if (grades.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [grades objectAtIndex:0];
            resEntity.ResStarGradeTxt=firstId.stringValue;
            
        } else {
            
        }
        // distance
        NSArray *distances = [shopList elementsForName:@"distance"];
        if (distances.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [distances objectAtIndex:0];
            resEntity.resDistanceTxt=firstId.stringValue;
            // NSLog(@"%@",resEntity.resDistanceTxt);
            
        } else {
            
        }
        
               // imageUrl
        NSArray *imageUrls = [shopList elementsForName:@"imageUrl"];
        if (imageUrls.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [imageUrls objectAtIndex:0];
            resEntity.resImg=firstId.stringValue;
            
        } else {
            
        }
        
        // sdIntro
        NSArray *intros = [shopList elementsForName:@"intro"];
        if (intros.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [intros objectAtIndex:0];
            resEntity.resIntro=firstId.stringValue;
            //NSLog(@"%@",firstId.stringValue);
            
        } else {
            
        }
        
        // isAllowApp
        NSArray *isAllowApps = [shopList elementsForName:@"isAllowApp"];
        if (isAllowApps.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAllowApps objectAtIndex:0];
            
        } else {
            
        }
        
        // isAudit
        NSArray *isAudits = [shopList elementsForName:@"isAudit"];
        if (isAudits.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isAudits objectAtIndex:0];
            
        } else {
            
        }
        
        // isDoubleScore
        NSArray *isDoubleScores = [shopList elementsForName:@"isDoubleScore"];
        if (isDoubleScores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isDoubleScores objectAtIndex:0];
            
        } else {
            
        }
        
        // isRecommed
        NSArray *isRecommeds = [shopList elementsForName:@"isRecommed"];
        if (isRecommeds.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [isRecommeds objectAtIndex:0];
            
        } else {
            
        }
        
        // lastSMS
        NSArray *lastSMSes = [shopList elementsForName:@"lastSMS"];
        if (lastSMSes.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [lastSMSes objectAtIndex:0];
            
        } else {
            
        }
        
        // sdLatitude
        NSArray *latitudes = [shopList elementsForName:@"latitude"];
        if (latitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [latitudes objectAtIndex:0];
            resEntity.latitude=firstId.stringValue;
            
        } else {
            
        }
        
        // license
        NSArray *licenses = [shopList elementsForName:@"license"];
        if (licenses.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [licenses objectAtIndex:0];
            
        } else {
            
        }
        
        // sdLongitude
        NSArray *longitudes = [shopList elementsForName:@"longitude"];
        if (longitudes.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [longitudes objectAtIndex:0];
            resEntity.longitude=firstId.stringValue;
            
        } else {
            
        }
        
        // sdName
        NSArray *names = [shopList elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [names objectAtIndex:0];
            resEntity.resNameTxt=firstId.stringValue;
            // NSLog(@"%@",firstId.stringValue);
        } else {
            
        }
        
        // payment
        NSArray *payments = [shopList elementsForName:@"payment"];
        if (payments.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [payments objectAtIndex:0];
            
        } else {
            
        }
        
        // sdPhone
        NSArray *phones = [shopList elementsForName:@"phone"];
        if (phones.count > 0) {
            GDataXMLElement *firstId = (GDataXMLElement *) [phones objectAtIndex:0];
            resEntity.ResTelTxt=firstId.stringValue;
            // NSLog(@"%@",firstId.stringValue);
        } else {
            
        }
        
        // score
        NSArray *scores = [shopList elementsForName:@"score"];
        if (scores.count > 0) {
            //GDataXMLElement *firstId = (GDataXMLElement *) [scores objectAtIndex:0];
            
        } else {
            
        }
        
//        // sdArea
//        NSArray *sdAreas = [shopList elementsForName:@"sdArea"];
//        if (sdAreas.count > 0) {
//            GDataXMLElement *firstId = (GDataXMLElement *) [sdAreas objectAtIndex:0];
//            resEntity.resSdArea=firstId.stringValue;
//            // NSLog(@"%@",firstId.stringValue);
//        } else {
//            
//        }
        
       
                
        [restaurants addObject:resEntity];
    }
 
    return restaurants;
}


+ (void) addDeviceToken:(NSString *)deviceToken :(NSString *)type{
    NSString *webserviceUrl = [WEBSERVICE_ADDRESS stringByAppendingString:@"customerRegister"];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                             <soap:Body>\
                             <addDeviceToken xmlns:ns2=\"http://service.d3rim.czuft.com/\">\
                             <arg0>%@</arg0>\
                             <arg1>%@</arg1>\
                             </addDeviceToken>\
                             </soap:Body>\
                             </soap:Envelope>", deviceToken,type];
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
}

@end
