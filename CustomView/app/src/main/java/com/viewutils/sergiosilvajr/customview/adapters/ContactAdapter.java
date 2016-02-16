package com.viewutils.sergiosilvajr.customview.adapters;

import android.app.Activity;
import android.content.Context;
import android.provider.ContactsContract;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Filter;
import android.widget.TextView;

import com.viewutils.sergiosilvajr.customview.R;
import com.viewutils.sergiosilvajr.customview.model.Contact;

import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactAdapter  extends ArrayAdapter<Contact>{
    private List<Contact> contacts;
    private int mLayoutResourceId;

    public ContactAdapter(Context context, int resource, List<Contact> objects) {
        super(context, resource, objects);
        this.contacts = objects;
        mLayoutResourceId= resource;
    }

    @Override
    public int getCount() {
        return contacts.size();
    }



    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = ((Activity) getContext()).getLayoutInflater();
        View view = inflater.inflate(mLayoutResourceId, parent, false);
        TextView textView = (TextView) view.findViewById(R.id.text_view_item);
        textView.setText(contacts.get(position).getName());
        return view;
    }
    
}
