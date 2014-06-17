package is.stamparound.stamparound.mycards;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import is.stamparound.stamparound.R;

/**
 * Created by thibaultguegan on 05/06/2014.
 */
public class MyCardsFragment extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_my_cards, null);

        return view;
    }

    @Override
    public void onViewCreated(android.view.View view, android.os.Bundle savedInstanceState)
    {

    }
}
