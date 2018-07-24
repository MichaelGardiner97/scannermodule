
package com.reactlibrary;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.provider.MediaStore;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.scanlibrary.ScanActivity;
import com.scanlibrary.ScanConstants;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class RNScannerModuleModule extends ReactContextBaseJavaModule implements ActivityEventListener {

  private static int REQUEST_CODE;

  final ReactApplicationContext reactContext;
  Promise promise;

  public RNScannerModuleModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.reactContext.addActivityEventListener(this);
  }

  @Override
  public void onNewIntent(Intent intent) { }

  @Override
  public String getName() {
    return "RNScannerModule";
  }

  @ReactMethod
  public void openGallery(Promise promise) {
    this.promise = promise;
    REQUEST_CODE = ScanConstants.OPEN_MEDIA;
    startScan(ScanConstants.OPEN_MEDIA);
  }

  @ReactMethod
  public void takePhoto(Promise promise) {
    this.promise = promise;
    REQUEST_CODE = ScanConstants.OPEN_CAMERA;
    startScan(ScanConstants.OPEN_CAMERA);
  }

  protected void startScan(int preference) {
    Intent intent = new Intent(getCurrentActivity(), ScanActivity.class);
    intent.putExtra(ScanConstants.OPEN_INTENT_PREFERENCE, preference);
    getCurrentActivity().startActivityForResult(intent, REQUEST_CODE);
  }

  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
    if (requestCode == REQUEST_CODE && resultCode == Activity.RESULT_OK) {
      Uri uri = data.getExtras().getParcelable(ScanConstants.SCANNED_RESULT);
      Bitmap bitmap;
      try {
        bitmap = MediaStore.Images.Media.getBitmap(getCurrentActivity().getContentResolver(), uri);
        getCurrentActivity().getContentResolver().delete(uri, null, null);
        FileOutputStream out = null;
        try {
          File outputDir = getCurrentActivity().getCacheDir();
          File tempFile = File.createTempFile("bitmap", ".jpeg", outputDir);
          out = new FileOutputStream(tempFile);
          bitmap.compress(Bitmap.CompressFormat.JPEG, 100, out);
          promise.resolve(tempFile.getAbsolutePath());
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          try {
            if (out != null) {
              out.close();
            }
          } catch (IOException e) {
            e.printStackTrace();
            promise.reject("IO_EXCEPTION", e);
          }
        }
      } catch (IOException e) {
        e.printStackTrace();
        promise.reject("IO_EXCEPTION", e);
      }
    }
  }
}
