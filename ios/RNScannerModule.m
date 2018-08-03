
#import "RNScannerModule.h"
#import "IRLDocumentScanner.h"

@interface RNScannerModule () <ImageScannerControllerDelegate>
@property (nonatomic, copy) RCTPromiseResolveBlock resolve;
@property (nonatomic, copy) RCTPromiseRejectBlock reject;

@end

@implementation RNScannerModule

+ (NSString *)moduleName {
    return @"RNScannerModule";
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

//exports a method tackePhoto to javascript
RCT_EXPORT_METHOD(takePhoto:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    self.resolve = resolve;
    self.reject = reject;
    
    ImageScannerController *controller = [ImageScannerController];
    controller.imageScannerDelegate = self;
    [[UIApplication.sharedApplication.delegate window].rootViewController presentViewController: controller animated:YES completion:nil];
}

- (void)pageSnapped:(UIImage* _Nonnull)image from:(IRLScannerViewController* _Nonnull)cameraView {
    [cameraView dismissViewControllerAnimated:YES completion:^{
        NSData *data = UIImagePNGRepresentation(image);
        if (data) {
            NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
            NSURL *path = paths.firstObject;
            NSURL *filename = [path URLByAppendingPathComponent:@"temp.png"];
            @try {
                [data writeToURL:filename atomically:YES];
            } @catch (NSException *exception) {
                self.reject(@"FAILED_TO_WRITE", @"Failed to write file", nil);
                return;
            }
            self.resolve(filename.absoluteString);
        } else {
            self.reject(@"NO_DATA", @"No data found", nil);
        }
    }];
}
- (void)didCancelIRLScannerViewController:(IRLScannerViewController* _Nonnull)cameraView {
    [cameraView dismissViewControllerAnimated:YES completion:nil];
}

@end
  
