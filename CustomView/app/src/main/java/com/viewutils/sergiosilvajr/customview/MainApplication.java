package com.viewutils.sergiosilvajr.customview;

import android.app.Application;
import android.util.Log;

import com.viewutils.sergiosilvajr.views.utils.ContactUtils;

/**
 * Created by luissergiodasilvajunior on 20/02/16.
 */
public class MainApplication extends Application {
    private ContactUtils contactUtils;
    @Override
    public void onCreate() {
        super.onCreate();
//        contactUtils = ContactUtils.getInstance();
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                contactUtils.loadAllContacts(MainApplication.this);
//                Log.v("loading status","all contact loaded");
//            }
//        }).start();
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        contactUtils.clearList();
    }
}
