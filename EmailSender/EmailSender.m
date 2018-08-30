// Copyright 2013 Matt Long http://www.cimgf.com/
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "EmailSender.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation EmailSender

+ (void)sendMailWithBody:(NSString*)emailBody
                 subject:(NSString*)subject
      firstReceiverEmail:(NSString*)firstReceiverEmail
     secondReceiverEmail:(NSString*)secondReceiverEmail
      thirdReceiverEmail:(NSString*)thirdReceiverEmail
     fourthReceiverEmail:(NSString*)fourthReceiverEmail
      fifthReceiverEmail:(NSString*)fifthReceiverEmail
            frontPicture:(NSData*)frontPicture
             rearPicture:(NSData*)rearPicture
         completionBlock:(void(^)(NSString* result))completion
            failureBlock:(void(^)(NSURLResponse *response, NSError *error, NSInteger status))failureBlock
{
    NSString *urlString = @"https://pickpocket.ziph0n.com/sendMail";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];

    NSMutableData *requestBody = [[NSMutableData alloc] init];

    NSString *boundary = @"---------------------------0983745982375409872438752038475287";

    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    /*// Front Picture
    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"Content-Disposition: attachment; name=\"frontPic\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[NSData dataWithData:frontPicture]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    // Rear Picture
    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"Content-Disposition: attachment; name=\"rearPic\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[NSData dataWithData:rearPicture]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];*/


    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"subject\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[subject dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"emailBody\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[emailBody dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"firstReceiverEmail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[firstReceiverEmail dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"secondReceiverEmail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[secondReceiverEmail dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"thirdReceiverEmail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[thirdReceiverEmail dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fourthReceiverEmail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[fourthReceiverEmail dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fifthReceiverEmail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[fifthReceiverEmail dataUsingEncoding:NSUTF8StringEncoding]];
    [requestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [requestBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:requestBody];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (data != nil) {
            failureBlock(response, error, 0);
            /*if (response != nil && error != nil) {
                failureBlock(response, error, 0);
            }

            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([responseDictionary valueForKeyPath:@"data.error"]) {
                if (failureBlock) {
                    if (!error) {
                        // If no error has been provided, create one based on the response received from the server
                        error = [NSError errorWithDomain:@"imguruploader" code:10000 userInfo:@{NSLocalizedFailureReasonErrorKey : [responseDictionary valueForKeyPath:@"data.error"]}];
                    }
                    if (response != nil && error != nil) {
                        failureBlock(response, error, [[responseDictionary valueForKey:@"status"] intValue]);
                    }
                }
            } else {
                if (completion) {
                    completion([responseDictionary valueForKeyPath:@"data.link"]);
                }
            }*/
        }
    }];
}

@end

#pragma clang diagnostic pop
