package com.viewutils.sergiosilvajr.views.utils;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;

import com.viewutils.sergiosilvajr.views.model.Contact;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sergiosilvajr on 2/16/16.
 */
public class ContactUtils {
    public static List<Contact> getAllContacts(Context context){
        List<Contact> contactList = new ArrayList<>();

        Uri CONTENT_URI = ContactsContract.Contacts.CONTENT_URI;
        String _ID = ContactsContract.Contacts._ID;

        String DISPLAY_NAME = ContactsContract.Contacts.DISPLAY_NAME;
        String HAS_PHONE_NUMBER = ContactsContract.Contacts.HAS_PHONE_NUMBER;

        Uri PhoneCONTENT_URI = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
        String Phone_CONTACT_ID = ContactsContract.CommonDataKinds.Phone.CONTACT_ID;
        String NUMBER = ContactsContract.CommonDataKinds.Phone.NUMBER;

        Uri EmailCONTENT_URI =  ContactsContract.CommonDataKinds.Email.CONTENT_URI;
        String EmailCONTACT_ID = ContactsContract.CommonDataKinds.Email.CONTACT_ID;
        String DATA = ContactsContract.CommonDataKinds.Email.DATA;

        ContentResolver contentResolver = context.getContentResolver();
        Cursor cursor = contentResolver.query(CONTENT_URI, null, null, null, null);
        if (cursor !=null) {
            while (cursor.moveToNext()){
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
                if(contact.getEmails() != null && !contact.getEmails().isEmpty()) {
                    contactList.add(contact);
                }
            }
        }
        return contactList;
    }

    private static byte[] openPhoto(Context context, long contactId) {
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
