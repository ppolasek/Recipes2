/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Set;

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
public class Recipe extends DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private String _recipeName;
    private Category _category;
    private String _notes;
    private Cookbook _cookbook;
    private String _pageNrs;
    private String _recipeUrl;
    private String _assetName;
    private boolean _isFavorite = false;
    private Set<RecipeTag> _recipeTags;

    @Transient
    public boolean isValid() {
      return _recipeName != null && _category != null;
    }

    public Recipe() {}

    @Override
    public String toString() {
        return "Recipe[ " +
                "id: " + getId() +
                ", version: " + getVersion() +
                ", recipeName: " + _recipeName +
                ", category: " + _category +
                ", notes: " + _notes +
                ", cookbook: " + _cookbook +
                ", pageNrs: " + _pageNrs +
                ", recipeUrl: " + _recipeUrl +
                ", assetName: " + _assetName +
                ", recipeTags: " + _recipeTags +
                ", isFavorite: " + _isFavorite +
                ", isValid: " + isValid() +
                " ]";
    }

    @Column(nullable = false, length = 100)
    public String getRecipeName() {
        return _recipeName;
    }
    public void setRecipeName(String recipeName) {
        _recipeName = recipeName;
    }

    @ManyToOne
    @JoinColumn(name = "category_id")
    public Category getCategory() {
        return _category;
    }
    public void setCategory(Category category) {
        _category = category;
    }

    @Column(length = 2000)
    public String getNotes() {
        return _notes;
    }
    public void setNotes(String notes) {
        _notes = notes;
    }

    @ManyToOne
    @JoinColumn(name = "cookbook_id")
    public Cookbook getCookbook() {
        return _cookbook;
    }
    public void setCookbook(Cookbook cookbook) {
        _cookbook = cookbook;
    }

    @Column(length = 50)
    public String getPageNrs() {
        return _pageNrs;
    }
    public void setPageNrs(String pageNrs) {
        _pageNrs = pageNrs;
    }

    @Column(length = 500)
    public String getRecipeUrl() {
        return _recipeUrl;
    }
    public void setRecipeUrl(String recipeUrl) {
        _recipeUrl = recipeUrl;
    }

    @Column(length = 255)
    public String getAssetName() {
        return _assetName;
    }
    public void setAssetName(String assetName) {
        _assetName = assetName;
    }

    public boolean isFavorite() {
        return _isFavorite;
    }
    public void setFavorite(boolean favorite) {
        _isFavorite = favorite;
    }

    @ManyToMany
    @JoinTable(name = "recipe_tag_join")
    public Set<RecipeTag> getRecipeTags() {
        return _recipeTags;
    }
    public void setRecipeTags(Set<RecipeTag> recipeTags) {
        _recipeTags = recipeTags;
    }
}
