package is.stamparound.stamparound;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TabHost;
import android.widget.TextView;
import is.stamparound.stamparound.map.MapFragment;
import is.stamparound.stamparound.mycards.MyCardsFragment;
import is.stamparound.stamparound.utils.DummyTabContent;

/**
 * Created by thibaultguegan on 05/06/2014.
 */
public class MainActivity extends FragmentActivity {
    TabHost tHost;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tHost = (TabHost) findViewById(android.R.id.tabhost);
        tHost.setup();

        /** Defining Tab Change Listener event. This is invoked when tab is changed */
        TabHost.OnTabChangeListener tabChangeListener = new TabHost.OnTabChangeListener() {

            @Override
            public void onTabChanged(String tabId) {
                android.support.v4.app.FragmentManager fm = getSupportFragmentManager();
                MapFragment mapFragment = (MapFragment) fm.findFragmentByTag("map");
                MyCardsFragment myCardsFragment = (MyCardsFragment) fm.findFragmentByTag("myCards");
                android.support.v4.app.FragmentTransaction ft = fm.beginTransaction();

                /** Detaches the mapFragment if exists */
                if (mapFragment != null)
                    ft.detach(mapFragment);

                /** Detaches the applefragment if exists */
                if (myCardsFragment != null)
                    ft.detach(myCardsFragment);

                /** If current tab is map */
                if (tabId.equalsIgnoreCase("Map")) {

                    if (mapFragment == null) {
                        /** Create MapFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent, new MapFragment(), "map");
                    } else {
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(mapFragment);
                    }

                } else {    /** If current tab is my cards */
                    if (myCardsFragment == null) {
                        /** Create MyCardsFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent, new MyCardsFragment(), "myCards");
                    } else {
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(myCardsFragment);
                    }
                }
                ft.commit();
            }
        };

        /** Setting tabchangelistener for the tab */
        tHost.setOnTabChangedListener(tabChangeListener);

        /** Defining tab builder for Map tab */
        setupTab(new TextView(this), "Map");
        /*TabHost.TabSpec tSpecMap = tHost.newTabSpec("map");
        tSpecMap.setIndicator("Map");
        tSpecMap.setContent(new DummyTabContent(getBaseContext()));
        tHost.addTab(tSpecMap);*/


        /** Defining tab builder for My Cards tab */
        setupTab(new TextView(this), "My Cards");
        /*TabHost.TabSpec tSpecMyCards = tHost.newTabSpec("myCards");
        tSpecMyCards.setIndicator("My Cards");
        tSpecMyCards.setContent(new DummyTabContent(getBaseContext()));
        tHost.addTab(tSpecMyCards);*/
    }

    private void setupTab(final View view, final String tag) {
        View tabview = createTabView(tHost.getContext(), tag);
        TabHost.TabSpec setContent = tHost.newTabSpec(tag).setIndicator(tabview).setContent(new TabHost.TabContentFactory() {
            public View createTabContent(String tag) {return view;}
        });
        tHost.addTab(setContent);
    }

    private static View createTabView(final Context context, final String text) {
        View view = LayoutInflater.from(context).inflate(R.layout.tabs_bg, null);
        TextView tv = (TextView) view.findViewById(R.id.tabsText);
        tv.setText(text);
        return view;
    }


}