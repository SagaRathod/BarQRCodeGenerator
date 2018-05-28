-(void)generateQRCodeWithString:(NSString *)string
{
CIFilter *filter = [CIFilter filterWithName:@”CIQRCodeGenerator”];

// NSLog(@”filterAttributes:%@”, filter.attributes);

[filter setDefaults];

NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
[filter setValue:data forKey:@”inputMessage”];

CIImage *outputImage = [filter outputImage];

CIContext *context = [CIContext contextWithOptions:nil];
CGImageRef cgImage = [context createCGImage:outputImage
fromRect:[outputImage extent]];

UIImage *image = [UIImage imageWithCGImage:cgImage
scale:1.
orientation:UIImageOrientationUp];

// Resize without interpolating
UIImage *resized = [self QRresizeImage:image
withQuality:kCGInterpolationNone
rate:5.0];

self.Qrcodeimage.image = resized;

CGImageRelease(cgImage);

}


-(void)generateBarCodeWithString:(NSString *)string
{
CIFilter *barCodeFilter = [CIFilter filterWithName:@”CICode128BarcodeGenerator”];

[barCodeFilter setDefaults];

// NSData *barCodeData = [string dataUsingEncoding:NSASCIIStringEncoding];

NSData *barCodeData = [@”8902242110451″ dataUsingEncoding:NSASCIIStringEncoding];//13 digit number
[barCodeFilter setValue:barCodeData forKey:@”inputMessage”];
[barCodeFilter setValue:[NSNumber numberWithFloat:0] forKey:@”inputQuietSpace”];

CIImage *outputImage = [barCodeFilter outputImage];
CIContext *context = [CIContext contextWithOptions:nil];
CGImageRef cgImage = [context createCGImage:outputImage
fromRect:[outputImage extent]];

UIImage *image = [UIImage imageWithCGImage:cgImage
scale:1.
orientation:UIImageOrientationUp];

UIImage *resized = [self QRresizeImage:image
withQuality:kCGInterpolationNone
rate:5.0];

self.Qrcodeimage.image = resized;

CGImageRelease(cgImage);
}


– (UIImage *)QRresizeImage:(UIImage *)image
withQuality:(CGInterpolationQuality)quality
rate:(CGFloat)rate
{
UIImage *resized = nil;
CGFloat width = image.size.width * rate;
CGFloat height = image.size.height * rate;

UIGraphicsBeginImageContext(CGSizeMake(width, height));
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextSetInterpolationQuality(context, quality);
[image drawInRect:CGRectMake(0, 0, width, height)];
resized = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

return resized;
}
