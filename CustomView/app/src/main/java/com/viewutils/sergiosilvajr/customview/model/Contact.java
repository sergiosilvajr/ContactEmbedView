package com.viewutils.sergiosilvajr.customview.model;

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
}
