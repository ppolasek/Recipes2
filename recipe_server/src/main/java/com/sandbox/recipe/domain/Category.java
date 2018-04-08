/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import java.io.Serializable;

/**
 * --- TODO: Class comments go here ---
 *
 * <b><pre>
 * Copyright 2017 Philip Polasek.
 * All rights reserved.
 * </pre></b>
 *
 * @author ppolasek
 */
@Entity // This tells Hibernate to make a table out of this class
public class Category extends DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private String _title;
    private String _caption;
    private String _assetName;

    @Transient
    public boolean isValid() {
        return _assetName != null && _title != null && _caption != null;
    }

    public Category() {};
    public Category(String assetName, String title, String caption) {
        this._assetName = assetName;
        this._title = title;
        this._caption = caption;
    };

    @Override
    public String toString() {
        return "Category[ " +
            "id: " + getId() +
            ", version: " + getVersion() +
            ", title: " + _title +
            ", caption: " + _caption +
            ", assetName: " + _assetName +
            ", isValid: " + isValid() +
            " ]";
    }

    @Column(unique = true, nullable = false, length = 50)
    public String getTitle() {
        return _title;
    }
    public void setTitle(String title) {
        _title = title;
    }

    @Column(length = 255)
    public String getCaption() {
        return _caption;
    }
    public void setCaption(String caption) {
        _caption = caption;
    }

    @Column(length = 255)
    public String getAssetName() {
        return _assetName;
    }
    public void setAssetName(String assetName) {
        _assetName = assetName;
    }
}
