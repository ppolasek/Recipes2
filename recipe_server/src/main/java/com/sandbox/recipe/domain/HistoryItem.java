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
import java.util.Date;

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
public class HistoryItem extends DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long _recipeId;
    private Date _whenViewed = new Date();

    public HistoryItem() {};

    public HistoryItem(Long recipeId) {
        this._recipeId = recipeId;
    }

    @Transient
    public String toString() {
        return "HistoryItem[ " +
                "id: " + getId() +
                ", version: " + getVersion() +
                ", recipeId: " + _recipeId +
                ", whenViewed: " + _whenViewed +
                " ]";
    }

    @Column(nullable = false)
    public Long getRecipeId() {
        return _recipeId;
    }
    public void setRecipeId(Long recipeId) {
        _recipeId = recipeId;
    }

    @Column(nullable = false)
    public Date getWhenViewed() {
        return _whenViewed;
    }
    public void setWhenViewed(Date whenViewed) {
        _whenViewed = whenViewed;
    }
}
