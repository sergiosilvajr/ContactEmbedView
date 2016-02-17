package com.viewutils.sergiosilvajr.views.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import com.viewutils.sergiosilvajr.views.R;
import com.viewutils.sergiosilvajr.views.model.Contact;
import com.viewutils.sergiosilvajr.views.utils.ContactMainAttribute;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactAdapter extends BaseAdapter implements Filterable {
    private Context context;
    private List<Contact> contactsAll;
    private List<Contact> contactsSubSet;
    private List<Contact> contactsSuggestions;
    private int mLayoutResourceId;
    private List<Contact> suggestions = new ArrayList<>();

    public ContactAdapter(Context context, int resource, List<Contact> objects) {
        this.context = context;
        this.contactsAll = objects;
        this.contactsSubSet = new ArrayList<>();
        this.contactsSuggestions = new ArrayList<>();
        this.mLayoutResourceId= resource;
    }

    @Override
    public int getCount() {
        return contactsSubSet.size();
    }

    @Override
    public Object getItem(int position) {
        return contactsSubSet.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = ((Activity) context).getLayoutInflater();

        ViewHolder holder;
        if (convertView == null) {
            convertView =  inflater.inflate(mLayoutResourceId, parent, false);
            holder = new ViewHolder();


            holder.nameTextView = (TextView) convertView.findViewById(R.id.text_view_item_name);
            holder.letterTextView = (TextView) convertView.findViewById(R.id.first_letter_text_view);
            holder.firstEmailTextView = (TextView) convertView.findViewById(R.id.text_view_item_email);
            holder.phoneTextView = (TextView) convertView.findViewById(R.id.text_view_item_phone);

            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
            holder.nameTextView.setText(contactsSubSet.get(position).getName());
            holder.letterTextView.setText(Character.toString(contactsSubSet.get(position).getName().charAt(0)));
            if (contactsSubSet.get(position).getEmails() != null && !contactsSubSet.get(position).getEmails().isEmpty()){
                holder.firstEmailTextView.setText(contactsSubSet.get(position).getEmails().get(0));
            } else{
                holder.firstEmailTextView.setText("");
            }
            if (contactsSubSet.get(position).getPhones() != null && !contactsSubSet.get(position).getPhones().isEmpty()){
                holder.phoneTextView.setText(contactsSubSet.get(position).getPhones().get(0));
            }else{
                holder.phoneTextView.setText("");
            }

        return convertView;
    }

    private static class ViewHolder {
        TextView nameTextView;
        TextView letterTextView;
        TextView firstEmailTextView;
        TextView phoneTextView;
    }


    @Override
    public Filter getFilter() {
        return new Filter() {
            @Override
            public CharSequence convertResultToString(Object resultValue) {
                return super.convertResultToString("");
            }

            @Override
            protected FilterResults performFiltering(CharSequence constraint) {
                if(contactsAll != null && !contactsAll.isEmpty() && constraint!=null){
                    suggestions.clear();
                    for(Contact contact : contactsAll){
                        if (Contact.mainAttribute == ContactMainAttribute.NAME){
                            if (contact.getName().toLowerCase().startsWith(constraint.toString().toLowerCase()) ){
                                suggestions.add(contact);
                            }
                        }else if (Contact.mainAttribute ==ContactMainAttribute.EMAIL){
                            if (!contact.getEmailFromSuggestion(constraint).isEmpty()){
                                suggestions.add(contact);
                            }
                        } else {
                            if (!contact.getPhonesFromSuggestion(constraint).isEmpty()){
                                suggestions.add(contact);
                            }
                        }
                    }
                    FilterResults results = new FilterResults();
                    results.values = suggestions;
                    results.count = suggestions.size();
                    return results;
                } else {
                    return new FilterResults();
                }
            }

            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                contactsSubSet.clear();
                if (results !=null && results.count > 0){
                    List<?> result = (List<?>) results.values;
                    for (Object object : result) {
                        if (object instanceof Contact) {
                            contactsSubSet.add((Contact) object);
                        }
                    }

                }else if (constraint == null){
                    contactsSubSet.addAll(contactsAll);
                }
                notifyDataSetChanged();
            }
        };
    }


}
