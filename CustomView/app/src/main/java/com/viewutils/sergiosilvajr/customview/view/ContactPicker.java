package com.viewutils.sergiosilvajr.customview.view;

import android.content.Context;
import android.support.v7.widget.AppCompatMultiAutoCompleteTextView;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.FrameLayout;
import android.widget.MultiAutoCompleteTextView;

import com.viewutils.sergiosilvajr.customview.R;
import com.viewutils.sergiosilvajr.customview.adapters.ContactAdapter;
import com.viewutils.sergiosilvajr.customview.model.Contact;
import com.viewutils.sergiosilvajr.customview.utils.ContactUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactPicker extends FrameLayout {

    public ContactPicker(Context context) {
        super(context);
        initView();
    }

    public ContactPicker(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView();
    }

    public ContactPicker(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initView();
    }

    private void initView(){
        View view = inflate(getContext(), R.layout.contactembedview, null);
        AppCompatMultiAutoCompleteTextView multiAutoCompleteTextView = (AppCompatMultiAutoCompleteTextView) view.findViewById(R.id.multiautocompletetextview);
        List<Contact> contacts = ContactUtils.getAllContacts(getContext());

        multiAutoCompleteTextView.setAdapter( new ArrayAdapter(getContext(),android.R.layout.simple_dropdown_item_1line, convertListFromContactToString(contacts)));
        multiAutoCompleteTextView.setThreshold(1);

        multiAutoCompleteTextView.setTokenizer(new MultiAutoCompleteTextView.CommaTokenizer());

        view.invalidate();
        addView(view);
    }
    private List<String> convertListFromContactToString( List<Contact> contacts){
        List<String> names = new ArrayList<>();
        for(Contact contact: contacts){
            names.add(contact.getName());
        }
        return names;
    }

}
