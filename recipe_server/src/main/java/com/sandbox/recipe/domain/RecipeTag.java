/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Entity
public class RecipeTag extends DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private String _tagName;

    @Column(nullable = false, length = 50)
    public String getTagName() {
        return _tagName;
    }
    public void setTagName(String tagName) { this._tagName = tagName; }

    public RecipeTag() {};
    public RecipeTag(String tag) {
        this._tagName = tag;
    }

    @Override
    public String toString() {
        return "RecipeTag[ " +
                "id: " + getId() +
                ", version: " + getVersion() +
                ", tagName: " + _tagName +
                " ]";
    }
}
