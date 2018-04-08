/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.repository;

import com.sandbox.recipe.domain.Recipe;
import com.sandbox.recipe.domain.RecipeTag;
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
public interface RecipeRepository extends CrudRepository<Recipe, Long>  {
        // This will be AUTO IMPLEMENTED by Spring into a Bean called recipeRepository
        // CRUD refers Create, Read, Update, Delete

    // This is working now
    List<Recipe> findTop5ByOrderByIdDesc();

    @Query(value="select * from recipe r order by r.id desc limit ?1", nativeQuery = true)
    List<Recipe> findAddedRecently(Long count);

    // This will find by the recipe name ignoring case containing the search value or the
    // notes ignoring case containing the search value.
    List<Recipe> findByRecipeNameIgnoreCaseContainingOrNotesIgnoreCaseContaining(String recipeName, String notes);

    // This is valid
//    List<Recipe> findByRecipeNameIgnoreCaseContaining(String searchText);

    // This is valid
//    List<Recipe> findByRecipeNameOrNotesContaining(String recipeName, String notes);

    // This is valid
//    List<Recipe> findByRecipeNameOrNotesIgnoreCaseContaining(String recipeName, String notes);

    // This is valid
//    List<Recipe> findByRecipeNameOrNotesIgnoreCaseContains(String recipeName, String notes);

    // not valid
//    List<Recipe> findByRecipeNameOrNotesIgnoreCaseContaining(String text);

    // not valid
//    List<Recipe> findByRecipeNameAndNotesAllIgnoreCaseContaining(String recipeName, String notes);

    // not valid
//    List<Recipe> findByRecipeNameIgnoreCaseOrNotesContaining(String searchText);

    // not valid
//    List<Recipe> findByRecipeNameOrNotesIgnoreCaseContaining(String searchText);

    // Find all recipes using the given recipe tags.
    List<Recipe> findByRecipeTagsIn(List<RecipeTag> tags);

    // Find all recipes using the given cookbook ids.
    List<Recipe> findByCookbookIdIn(List<Long> cookbookIds);
}
