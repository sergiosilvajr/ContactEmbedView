package com.viewutils.sergiosilvajr.views.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v4.graphics.drawable.RoundedBitmapDrawable;
import android.support.v4.graphics.drawable.RoundedBitmapDrawableFactory;
import android.support.v7.widget.AppCompatMultiAutoCompleteTextView;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.MultiAutoCompleteTextView;
import android.widget.TextView;

import com.viewutils.sergiosilvajr.views.R;
import com.viewutils.sergiosilvajr.views.model.Contact;

/**
 * Created by luissergiodasilvajunior on 16/02/16.
 */
public class ContactEmbedView extends FrameLayout{
    private boolean isXWorking = true;
    private Contact contact;
    private MultiAutoCompleteTextView multiAutoCompleteTextView;

    public ContactEmbedView(Context context) {
        super(context);
        initView();
    }

    public ContactEmbedView(Context context, Contact contact) {
        super(context);
        this.contact = contact;
        initView();
    }

    public ContactEmbedView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initAttrs(attrs);
        initView();
    }

    public ContactEmbedView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initAttrs(attrs);
        initView();
    }
    private void initView(){
        View view = inflate(getContext(), R.layout.customcontactview, null);
        TextView nameTextView = (TextView) view.findViewById(R.id.name);
        TextView firstLetterTextView = (TextView) view.findViewById(R.id.circle_letter);
        if (contact != null){
            nameTextView.setText(contact.getName());
            if (contact.getPhoto() == null) {
                firstLetterTextView.setText(Character.toString(contact.getName().charAt(0)));
            } else {
                firstLetterTextView.setText("");
                Bitmap bitmap = BitmapFactory.decodeByteArray(contact.getPhoto(), 0, contact.getPhoto().length);
                RoundedBitmapDrawable dr = RoundedBitmapDrawableFactory.create(getContext().getResources(), bitmap);
                dr.setCircular(true);
                firstLetterTextView.setBackground(dr);
            }

        }
        TextView cross = (TextView) view.findViewById(R.id.cross);
        if(isXWorking){
            cross.setOnClickListener(new OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (multiAutoCompleteTextView != null) {
                        multiAutoCompleteTextView.setVisibility(View.VISIBLE);
                        multiAutoCompleteTextView.setText("");
                    }
                    setVisibility(View.GONE);
                    //TODO ver como deletar da memoria a view
                }
            });
        }
        view.invalidate();
        addView(view);
    }
    private void initAttrs(AttributeSet attrs){
        if (attrs != null){
            contact = new Contact();
            String packageName = "http://schemas.android.com/apk/res-auto";
            contact.setName(attrs.getAttributeValue(packageName, "user_name"));
            isXWorking = attrs.getAttributeBooleanValue(packageName,"is_x_working",true);
        }

    }

    public void setMultiAutoCompleteTextView(MultiAutoCompleteTextView multiAutoCompleteTextView) {
        this.multiAutoCompleteTextView = multiAutoCompleteTextView;
    }
}
