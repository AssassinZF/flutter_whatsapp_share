package com.example.flutter_whatsapp_share;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterWhatsappSharePlugin */
public class FlutterWhatsappSharePlugin implements MethodCallHandler {

  private Activity activity;
  private Registrar registrar;

  /**
   * Plugin registration.
   */
  private FlutterWhatsappSharePlugin(Registrar registrar) {
    this.activity = registrar.activity();
    this.registrar = registrar;
  }
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_whatsapp_share");
    channel.setMethodCallHandler(new FlutterWhatsappSharePlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("shareContentToWhatsapp")){
      Map<String,String>param = (Map)call.arguments;
      shareWhatsApp(param.get("msg"),result);
    }else {
      result.notImplemented();
    }
  }

  /**
   * share to whatsapp
   *
   * @param msg                String
   * @param result             Result
   * @param shareToWhatsAppBiz boolean
   */
  private void shareWhatsApp(String msg, Result result) {
    try {
      Intent whatsappIntent = new Intent(Intent.ACTION_SEND);
      whatsappIntent.setType("text/plain");
      whatsappIntent.putExtra(Intent.EXTRA_TEXT, msg);
      whatsappIntent.setPackage("com.whatsapp");

//      if (!TextUtils.isEmpty(url)) {
//        FileUtil fileHelper = new FileUtil(registrar, url);
//        if (fileHelper.isFile()) {
//          whatsappIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
//          whatsappIntent.putExtra(Intent.EXTRA_STREAM, fileHelper.getUri());
//          whatsappIntent.setType(fileHelper.getType());
//        }
//      }
      whatsappIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
      activity.startActivity(whatsappIntent);
      result.success("success");
    } catch (Exception var9) {
      result.error("error", var9.toString(), "");
    }
  }
}
