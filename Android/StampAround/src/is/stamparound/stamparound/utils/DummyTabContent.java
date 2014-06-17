package is.stamparound.stamparound.utils;

import android.content.Context;
import android.view.View;
import android.widget.TabHost;

/**
 * Created by thibaultguegan on 05/06/2014.
 */
public class DummyTabContent implements TabHost.TabContentFactory {
    private Context mContext;

    public DummyTabContent(Context context){
        mContext = context;
    }


    @Override
    public View createTabContent(String tag) {
        View v = new View(mContext);
        return v;
    }


}
