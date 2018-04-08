/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.repository;

import com.sandbox.recipe.domain.HistoryItem;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

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
public interface HistoryItemRepository extends CrudRepository<HistoryItem, Long>  {
        // This will be AUTO IMPLEMENTED by Spring into a Bean called historyItemRepository
        // CRUD refers Create, Read, Update, Delete

    /**
     * The return type is an List<Object[]> with each row containing 2 BigIntegers, the recipe id and the
     * count of occurrences in the table.
     */
    @Query(value="select recipe_id,\n"
            + "          count(recipe_id)\n"
            + "           from history_item\n"
            + "          group by recipe_id\n"
            + "          order by count(recipe_id) desc\n"
            + "          limit ?1\n"
            + ";", nativeQuery = true)
    List<Object[]> findMostViewed(Long count);

    /**
     * Delete all history items for the given recipe id, as the recipe is being deleted.
     *
     * @param recipeId
     */
    void deleteByRecipeId(Long recipeId);
}
