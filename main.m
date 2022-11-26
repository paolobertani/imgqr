/*
 *  imgqr
 *
 *  version 1.0
 *
 *  Decodes the QR Code(s) in the image at the specified path and
 *  outputs the retrieved data in JSON format.
 *
 *  Usage:
 *
 *  imgqr -img <path-to-image>
 *
 *  MIT License
 *
 *  Copyright © 2022 Paolo Bertani - Kalei S.r.l.
 *
 *  Permission is hereby granted, free of charge, to any person
 *  obtaining a copy of this software and associated documentation
 *  files (the "Software"), to deal in the Software without
 *  restriction, including without limitation the rights to use,
 *  copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following
 *  conditions:
 *
 *  The above copyright notice and this permission notice shall be
 *  included in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 *  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 *  OTHER DEALINGS IN THE SOFTWARE.
 *
*/

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

int main(int argc, const char * argv[])
{
    NSUserDefaults          *userDefaults;
    NSString                *path;
    NSURL                   *url;
    CIImage                 *image;
    NSDictionary            *options;
    CIContext               *context;
    CIDetector              *qrDetector;
    NSArray                 *qr;
    NSUInteger              n,
                            i,
                            c;
    CGRect                  bounds;
    CGFloat                 x,
                            y,
                            w,
                            h;
    NSString                *msg;

    userDefaults = [NSUserDefaults standardUserDefaults];
    path = [ userDefaults stringForKey:@"img" ];

    if( ! path )
    {
        fprintf( stderr, "image path not specified, usage: imgqr -img <path_to_image>\n" );
        exit( 20 );
    }

    url = [ [ NSURL alloc ] initFileURLWithPath:path ];
    image = [ [ CIImage alloc ] initWithContentsOfURL:url ];

    if( ! image )
    {
        fprintf( stderr, "cannot load %s\n", [path UTF8String] );
        exit( 21 );
    }

    context = [CIContext context];
    options = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh }; // CIDetectorAccuracyLow

    qrDetector = [ CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:options ];

    qr = [ qrDetector featuresInImage:image options:options];

    if( ! qr )
    {
        printf( "[]\n" );
        exit( 0 );
    }

    n = [qr count];

    if( n == 0 )
    {
        printf( "[]\n" );
        exit( 0 );
    }


    printf( "[\n" );

    c = 0;

    for( i = 0; i < n; i++ )
    {
        if( [ [ qr objectAtIndex: i ] isKindOfClass:CIQRCodeFeature.class ] )
        {
            if( c > 0 )
            {
                printf( ",\n" );
            }

            msg = [ [ qr objectAtIndex: i ] messageString ];
            bounds = [ [ qr objectAtIndex: i ] bounds ];
            x = bounds.origin.x;
            y = bounds.origin.y;
            w = bounds.size.width;
            h = bounds.size.height;

            msg = [msg stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
            msg = [msg stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
            msg = [msg stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];

            printf( "    {\n" );
            printf( "        message: \"%s\",\n", [msg UTF8String] );
            printf( "        x:       %f,\n", x );
            printf( "        y:       %f,\n", y );
            printf( "        w:       %f,\n", w );
            printf( "        h:       %f\n", h );
            printf( "    }" );

            c++;
        }
    }

    printf( "\n]\n" );

    return 0;
}
