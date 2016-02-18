package com.viewutils.sergiosilvajr.views.model;

import com.viewutils.sergiosilvajr.views.utils.ContactMainAttribute;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class Contact {
    private String name;
    private String id;
    private List<String> phones;
    private List<String> emails;
    private byte[] photo;

    public static ContactMainAttribute mainAttribute = ContactMainAttribute.NAME;
    public String getName() {
        return name;
    }

    public void addPhone(String phone){
        if (phones == null){
            phones = new ArrayList<>();
        }
        phones.add(phone);
    }

    public void addEmail(String email){
        if (emails == null){
            emails = new ArrayList<>();
        }
        emails.add(email);
    }

    public List<String> getEmails(){
        return emails;
    }

    public List<String> getPhones(){
        return phones;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public List<String> getEmailFromSuggestion(CharSequence charSequence){
        List<String> emails = new ArrayList<>();
        for(String email: emails){
            if(email.toLowerCase().contains(charSequence)){
                emails.add(email);
            }
        }
        return emails;
    }

    public List<String> getPhonesFromSuggestion(CharSequence charSequence){
        List<String> phones = new ArrayList<>();
        for(String phone: phones){
            if(phone.toLowerCase().startsWith(charSequence.toString().toLowerCase())){
                phones.add(phone);
            }
        }
        return phones;
    }


    public byte[] getPhoto() {
        return photo;
    }
}
