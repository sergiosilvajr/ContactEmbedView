package com.viewutils.sergiosilvajr.views.utils;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;

import com.viewutils.sergiosilvajr.views.model.Contact;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactUtils {
    private static ContactUtils contactUtils;
    private List<Contact> contactList = new ArrayList<>();

    private static final Uri CONTENT_URI = ContactsContract.Contacts.CONTENT_URI;
    private static final String _ID = ContactsContract.Contacts._ID;

    private static final String DISPLAY_NAME = ContactsContract.Contacts.DISPLAY_NAME;
    private static final String HAS_PHONE_NUMBER = ContactsContract.Contacts.HAS_PHONE_NUMBER;

    private static final Uri PhoneCONTENT_URI = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
    private static final String Phone_CONTACT_ID = ContactsContract.CommonDataKinds.Phone.CONTACT_ID;
    private static final String NUMBER = ContactsContract.CommonDataKinds.Phone.NUMBER;

    private static final Uri EmailCONTENT_URI =  ContactsContract.CommonDataKinds.Email.CONTENT_URI;
    private static final String EmailCONTACT_ID = ContactsContract.CommonDataKinds.Email.CONTACT_ID;
    private static final String DATA = ContactsContract.CommonDataKinds.Email.DATA;

    private ContactUtils(){}

    public static ContactUtils getInstance() {
        if (contactUtils==null){
            contactUtils = new ContactUtils();
        }
        return contactUtils;
    }

    public void clearList(){
        if (contactList != null){
            contactList.clear();
        }
    }

    public List<Contact> getContactList(){
        return contactList;
    }

    public Contact getContactWithNameAndEmail(Context context, String name, String email){
        ContentResolver contentResolver = context.getContentResolver();
        Cursor cursor = contentResolver.query(CONTENT_URI, null, DISPLAY_NAME+"= ?", new String[]{name}, null);
        List<Contact> contacts = new ArrayList<>();
        if (cursor !=null) {
            while (cursor.moveToNext()){
                contacts.add(getContact(context, contentResolver, cursor));
            }
        }
       if (!contacts.isEmpty()){
           for(Contact contact: contacts){
               if(contact.getName().equalsIgnoreCase(name) && contact.getEmails().contains(email)){
                   return contact;
               }
           }
       }
        return null;
    }
    public void loadAllContacts(Context context){
        ContentResolver contentResolver = context.getContentResolver();
        Cursor cursor = contentResolver.query(CONTENT_URI, null, null, null, null);
        if (cursor !=null) {
            while (cursor.moveToNext()){
                Contact contact = getContact(context, contentResolver, cursor);
                if(contact.getEmails() != null && !contact.getEmails().isEmpty()) {
                    contactList.add(contact);
                }
            }
        }
    }

    private Contact getContact(Context context, ContentResolver contentResolver, Cursor cursor){
        Contact contact = new Contact();
        contact.setName(cursor.getString(cursor.getColumnIndex(DISPLAY_NAME)));
        contact.setId(cursor.getString(cursor.getColumnIndex(_ID)));
        contact.setPhoto(openPhoto(context, Long.parseLong(contact.getId())));

        int hasPhoneNumber = Integer.parseInt(cursor.getString(cursor.getColumnIndex(HAS_PHONE_NUMBER)));

        if (hasPhoneNumber > 0) {
            Cursor phoneCursor = contentResolver.query(PhoneCONTENT_URI, null, Phone_CONTACT_ID + " = ?", new String[]{contact.getId()}, null);
            while (phoneCursor.moveToNext()) {
                contact.addPhone(phoneCursor.getString(phoneCursor.getColumnIndex(NUMBER)));
            }
            phoneCursor.close();
        }
        Cursor emailCursor = contentResolver.query(EmailCONTENT_URI, null, EmailCONTACT_ID + " = ?", new String[]{contact.getId()}, null);
        while (emailCursor.moveToNext()) {
            contact.addEmail(emailCursor.getString(emailCursor.getColumnIndex(DATA)));
        }
        emailCursor.close();
        return contact;
    }


    private byte[] openPhoto(Context context, long contactId) {
        Uri contactUri = ContentUris.withAppendedId(ContactsContract.Contacts.CONTENT_URI, contactId);
        Uri photoUri = Uri.withAppendedPath(contactUri, ContactsContract.Contacts.Photo.CONTENT_DIRECTORY);
        Cursor cursor = context.getContentResolver().query(photoUri,
                new String[]{ContactsContract.Contacts.Photo.PHOTO}, null, null, null);
        if (cursor == null) {
            return null;
        }
        try {
            if (cursor.moveToFirst()) {
                byte[] data = cursor.getBlob(0);
                if (data != null) {
                    return data;
                }
            }
        } finally {
            cursor.close();
        }
        return null;
    }
}
