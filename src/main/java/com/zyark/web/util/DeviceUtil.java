package com.zyark.web.util;

/**
 * Created by ron on 16-11-15.
 */
public class DeviceUtil {
    public static boolean isMobileDevice(String requestHeader){
        /**
         * android : 所有android设备
         * mac os : iphone ipad
         * windows phone:Nokia等windows系统的手机
         */
        String[] deviceArray = new String[]{"android","windows phone","mac os","okhttp"};
        if(requestHeader == null)
            return false;
        requestHeader = requestHeader.toLowerCase();
        for(int i=0;i<deviceArray.length;i++){
            if(requestHeader.indexOf(deviceArray[i])>0){
                return true;
            } else if (requestHeader.intern().contains(deviceArray[i].intern())) {
                return true;
            }
        }
        return false;
    }
}
