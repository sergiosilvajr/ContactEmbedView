package com.viewutils.sergiosilvajr.views.view;

import android.content.Context;
import android.support.v7.widget.AppCompatMultiAutoCompleteTextView;
import android.util.AttributeSet;
import android.view.View;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.MultiAutoCompleteTextView;
import android.widget.RelativeLayout;


import com.viewutils.sergiosilvajr.views.R;
import com.viewutils.sergiosilvajr.views.adapter.ContactAdapter;
import com.viewutils.sergiosilvajr.views.model.Contact;
import com.viewutils.sergiosilvajr.views.utils.ContactMainAttribute;
import com.viewutils.sergiosilvajr.views.utils.ContactUtils;

import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactPicker extends FrameLayout {
    private AppCompatMultiAutoCompleteTextView multiAutoCompleteTextView;

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
        View rootView = inflate(getContext(), R.layout.contactembedview, null);
        final RelativeLayout relativeLayout = (RelativeLayout) rootView.findViewById(R.id.root_relative_contact_layout);

        this.multiAutoCompleteTextView = (AppCompatMultiAutoCompleteTextView) rootView.findViewById(R.id.multiautocompletetextview);
        List<Contact> contacts = ContactUtils.getAllContacts(getContext());
        Contact.mainAttribute = ContactMainAttribute.NAME;

        final ContactAdapter contactAdapter = new ContactAdapter(getContext(), R.layout.adapter_row, contacts);

        multiAutoCompleteTextView.setAdapter(contactAdapter);

        multiAutoCompleteTextView.setThreshold(1);
        multiAutoCompleteTextView.setTokenizer(new MultiAutoCompleteTextView.CommaTokenizer());
        multiAutoCompleteTextView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Contact contact = (Contact) contactAdapter.getItem(position);
                ContactEmbedView contactEmbedView = new ContactEmbedView(getContext(), contact);
                contactEmbedView.setMultiAutoCompleteTextView(multiAutoCompleteTextView);
                contactEmbedView.setLayoutParams(new RelativeLayout.LayoutParams(
                        RelativeLayout.LayoutParams.WRAP_CONTENT,
                        RelativeLayout.LayoutParams.WRAP_CONTENT));
                relativeLayout.addView(contactEmbedView);
                multiAutoCompleteTextView.setVisibility(View.INVISIBLE);
            }
        });


        rootView.invalidate();
        addView(rootView);
    }
}
