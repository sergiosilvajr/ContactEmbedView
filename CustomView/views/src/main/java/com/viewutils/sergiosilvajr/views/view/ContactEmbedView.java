package com.viewutils.sergiosilvajr.views.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.viewutils.sergiosilvajr.views.R;

/**
 * Created by luissergiodasilvajunior on 16/02/16.
 */
public class ContactEmbedView extends FrameLayout{
    private String mContactName;
    private boolean isXWorking = true;

    public ContactEmbedView(Context context) {
        super(context);
        initView();
    }

    public ContactEmbedView(Context context, String contactName) {
        super(context);
        mContactName = contactName;
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
        if (mContactName!= null){
            nameTextView.setText(mContactName);
            firstLetterTextView.setText(Character.toString(mContactName.charAt(0)));
        }
        TextView cross = (TextView) view.findViewById(R.id.cross);
        if(isXWorking){
            cross.setOnClickListener(new OnClickListener() {
                @Override
                public void onClick(View v) {
                    setVisibility(View.GONE);
                }
            });
        }
        view.invalidate();
        addView(view);
    }
    private void initAttrs(AttributeSet attrs){
        if (attrs != null){
            String packageName = "http://schemas.android.com/apk/res-auto";
            mContactName = attrs.getAttributeValue(packageName, "user_name");
            isXWorking = attrs.getAttributeBooleanValue(packageName,"is_x_working",true);
        }

    }
}
