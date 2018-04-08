// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/common/components/selector_directive.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/recipes2_app_events.dart';
import 'package:recipe_web/src/logger/logger.dart';

/// Display a list of recipes
@Component(
  selector: 'recipe-list',
  styleUrls: const ['recipe_list_component.css'],
  templateUrl: 'recipe_list_component.html',
  directives: const [
    CORE_DIRECTIVES,
  ],
  providers: const [],
)
class RecipeListComponent implements OnInit {
  final Recipes2Logger _log;
  final RecipesAppEvents _recipeEvents;
  final SelectorDirective _selector;

  static String SELECTED_ELEMENT_CLASS_NAME = 'selected-element';

  bool isSelected = true;

  List<Recipe> _recipeList;
  List<Recipe> get recipeList => _recipeList;
  @Input()
  void set recipeList(List<Recipe> newValue) {
    _recipeList = newValue;
    _onRecipeListChanged();
  }

  @Input()
  String heading;

  RecipeListComponent(this._log, this._recipeEvents, this._selector);

  ngOnInit() {
    _log.loggerName = 'RecipeListComponent';
  }

  /// The user moved over the recipe, so remember it in case they hover long enough
  void onMouseOver(var event) {
//    _log.fine('onMouseOver()');
    _selector.timer = new Timer(new Duration(milliseconds: 1000), _showHoveredRecipe);

    var nodeText = event?.target?.childNodes?.first?.toString()?.trim();
    var displayName = nodeText.substring(nodeText.indexOf(' ') + 1);

    // need to keep track of the recipe being hovered over, so it can be displayed when the timer fires off
    if (recipeList != null) {
      _selector.hoveredRecipe = recipeList.firstWhere((temp) => temp.recipeName.trim() == displayName, orElse: () => null);
//      _log.finest('onMouseOver() _hoveredRecipe = $_hoveredRecipe');
    }
  }

  /// The user move off a recipe, so cancel the timer for showing that one recipe
  void onMouseOut(var event) {
//    _log.fine('onMouseOut()');

    if (_selector.timer != null && _selector.timer.isActive) {
      _selector.timer.cancel();
    }
  }

  /// The user specifically clicked on the recipe, so show it
  void onMouseClick(var event) {
//    _log.fine('onMouseClick()');
    if (_selector.timer != null && _selector.timer.isActive) {
      _selector.timer.cancel();
    }

    var nodeText = event?.target?.childNodes?.first?.toString()?.trim();
    var displayName = nodeText.substring(nodeText.indexOf(' ') + 1);

    if (recipeList != null) {
      _selector.clickedRecipe = recipeList.firstWhere((temp) => temp.recipeName.trim() == displayName, orElse: () => null);
//      _log.finest('onMouseClick() _clickedRecipe = ${_selector.clickedRecipe}');
      _selector.hoveredRecipe = null;
      _showClickedRecipe(_selector.clickedRecipe);
    }
  }

  void _showHoveredRecipe() {
//    _log.finer('_showHoveredRecipe() _hoveredRecipe = ${_selector.hoveredRecipe}');

    if (_selector.hoveredRecipe != null && _selector.hoveredRecipe.id != _selector.lastFired?.id) {
      _selector.lastFired = _selector.hoveredRecipe;
      _recipeEvents.hoverRecipe(_selector.hoveredRecipe);
    } else if (_selector.hoveredRecipe != null) {
      _log.fine('_showHoveredRecipe() already fired event for $_selector.hoveredRecipe');
    }
  }

  /// Need to avoid the case where they hover over the recipe for a bit and then click on it. Do not fire the event
  /// twice for the same object
  void _showClickedRecipe(Recipe recipe) {
//    _log.finer('_showClickedRecipe() recipe = $recipe');
//    _log.finer('_showClickedRecipe() _selector.lastFired = ${_selector.lastFired}');

//    if (recipe != null && recipe.id != _lastFired?.id) {
      _selector.lastFired = recipe;
      _recipeEvents.viewRecipe(recipe);
//    } else if (recipe != null) {
//      _log.fine('_showClickedRecipe() already fired event for $recipe');
//    }
  }

  /// The list was reloaded.
  void _onRecipeListChanged() {
    _log.fine('_onRecipeListChanged() _selector.clickedRecipe.id = ${_selector.clickedRecipe?.id}');
  }
}
