// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/logger/logger.dart';

enum RecipeEvents {
  key_event_type,
  key_recipe_id,
  key_recipe,
  type_edit_recipe,    // recipe needs to be edited
  type_hover_recipe,   // hovering over a recipe to display it without updating the viewing history
  type_view_recipe,    // recipe was clicked on to be viewed & update viewing history
  type_delete_recipe,  // recipe needs to be deleted
  type_recipe_deleted, // recipe has been deleted
  type_recipe_added,   // recipe has been added
  type_recipe_viewed,  // recipe has been viewed
  type_recipe_updated, // recipe has been updated
  type_close_search,   // close the search box
}

/// Because Angular Dart events do not bubble up, using a separate event class to send
/// event notifications to where they are needed.  This class is injected.
@Injectable()
class RecipesAppEvents implements OnDestroy {
  Recipes2Logger _log;

  StreamController _recipeStreamController = new StreamController.broadcast();

  Stream get recipeStream => _recipeStreamController.stream;

  RecipesAppEvents(this._log) {
    _log.loggerName = 'RecipesAppEvents';
  }

  void ngOnDestroy() {
    _recipeStreamController.close();
  }

  editRecipe(Recipe recipe) {
    _log.fine('editRecipe() recipe = $recipe');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_edit_recipe,
      RecipeEvents.key_recipe: recipe
    });
  }

  /// Display a recipe that was hovered over, but will not update
  /// the viewing history for that recipe.
  hoverRecipe(Recipe recipe) {
    _log.fine('hoverRecipe() recipe = $recipe');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_hover_recipe,
      RecipeEvents.key_recipe_id: recipe.id
    });
  }

  /// Display a recipe that was clicked on, which will update the
  /// viewing history for that recipe.
  viewRecipe(Recipe recipe) {
    _log.fine('viewRecipe() recipe = $recipe');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_view_recipe,
      RecipeEvents.key_recipe_id: recipe.id
    });
  }

  /// Delete the recipe by id, which also will need to delete the viewing history.
  deleteRecipe(int id) {
    _log.fine('deleteRecipe() id = $id');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_delete_recipe,
      RecipeEvents.key_recipe_id: id
    });
  }

  /// A recipe was successfully deleted; the recently added and most viewed
  /// lists may also need to be updated
  recipeDeleted(int id) {
    _log.fine('recipeDeleted() id = $id');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_recipe_deleted,
      RecipeEvents.key_recipe_id: id
    });
  }

  /// A recipe was successfully added.
  recipeAdded(int id) {
    _log.fine('recipeAdded() id = $id');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_recipe_added,
      RecipeEvents.key_recipe_id: id
    });
  }

  /// A recipe was loaded to be viewed so viewing history may be updated.
  recipeViewed(int id) {
    _log.fine('recipeViewed() id = $id');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_recipe_viewed,
      RecipeEvents.key_recipe_id: id
    });
  }

  /// A recipe was successfully updated.
  recipeUpdated(int id) {
    _log.fine('recipeUpdated() id = $id');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_recipe_updated,
      RecipeEvents.key_recipe_id: id
    });
  }

  /// Close the search box
  closeSearch() {
    _log.fine('closeSearch()');
    _recipeStreamController.add({
      RecipeEvents.key_event_type: RecipeEvents.type_close_search
    });

  }
}
