/*
 * $Id: $
 * $Revision: $
 * $Author: $
 * $Date: $
 * Copyright (c) 2017 Trustwave Holdings, Inc.
 * All Rights Reserved.
 *
 * This software is the confidential and proprietary information
 * of Trustwave Holdings, Inc.  Use of this software is governed by
 * the terms and conditions of the license statement and limited
 * warranty furnished with the software.
 *
 * IN PARTICULAR, YOU WILL INDEMNIFY AND HOLD TRUSTWAVE HOLDINGS INC.,
 * ITS RELATED COMPANIES AND ITS SUPPLIERS, HARMLESS FROM AND AGAINST
 * ANY CLAIMS OR LIABILITIES ARISING OUT OF OR RESULTING FROM THE USE,
 * MODIFICATION, OR DISTRIBUTION OF PROGRAMS OR FILES CREATED FROM,
 * BASED ON, AND/OR DERIVED FROM THIS SOURCE CODE FILE.
 */
package com.sandbox.recipe.domain;

import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.List;

/**
 * --- TODO: Class comments go here ---
 *
 * <b><pre>
 * Copyright (c) 2017 Trustwave Holdings, Inc.
 * All rights reserved.
 * </pre></b>
 *
 * @author ppolasek
 * @version $Revision: $
 */
public class SearchCriteria implements Serializable {
    private static final long serialVersionUID = 1L;

    String _searchText;
    List<RecipeTag> _tags;

    List<Long> _cookbookIds;

    @Override
    public String toString() {
        return "SearchCriteria[ " +
                "searchText: " + getSearchText() +
                ", cookbookIds: " + StringUtils.join(getCookbookIds()) +
                ", tags: " + StringUtils.join(getTags()) +
                " ]";
    }

    public String getSearchText() {
        return _searchText;
    }
    public void setSearchText(String searchText) {
        _searchText = searchText;
    }

    public List<RecipeTag> getTags() {
        return _tags;
    }
    public void setTags(List<RecipeTag> tags) {
        _tags = tags;
    }

    public List<Long> getCookbookIds() {
        return _cookbookIds;
    }
    public void setCookbookIds(List<Long> cookbookIds) {
        _cookbookIds = cookbookIds;
    }
}
