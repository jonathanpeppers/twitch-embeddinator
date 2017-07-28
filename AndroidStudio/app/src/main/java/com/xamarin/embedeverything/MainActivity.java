package com.xamarin.embedeverything;

import android.os.Bundle;
import android.app.*;
import android.support.v4.app.FragmentActivity;
import weatherapp_droid.MainFragment;

public class MainActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(weatherapp_droid.R.layout.main);

        try {
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            ft.replace(weatherapp_droid.R.id.fragment_frame_layout, new MainFragment(), "main");
            ft.commit();
        } catch (Throwable e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() != 0) {
            getFragmentManager().popBackStack();
        }
        else {
            super.onBackPressed();
        }
    }
}
