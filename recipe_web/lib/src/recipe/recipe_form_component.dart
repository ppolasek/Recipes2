// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:recipe_web/src/category/category_service.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/recipe_util.dart';
import 'package:recipe_web/src/common/recipes2_app_events.dart';
import 'package:recipe_web/src/cookbook/cookbook_service.dart';
import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/recipe/recipe_service.dart';
import 'package:recipe_web/src/recipe/recipe_tag_component.dart';

/// Form component to enter a new recipe.
@Component(
  selector: 'recipe-form',
  styleUrls: const ['recipe_form_component.css'],
  templateUrl: 'recipe_form_component.html',
  directives: const [
    COMMON_DIRECTIVES,
    RecipeTagComponent,
  ],
  providers: const [],
)
class RecipeFormComponent implements OnInit, OnDestroy {
  final Recipes2Logger _log;

  Recipe _recipe;
  Recipe get recipe => _recipe;
  @Input()
  void set recipe(Recipe newValue) {
    print('RecipeFormComponent.set recipe() newValue = $newValue');
    if (newValue != _recipe) {
      _recipe = newValue;
      _recipeChanged();
    }
  }

  @Input()
  bool editRecipe = false;

  @Output()
  Stream get formEvent => _onFormEvent.stream;

  String _categoryTitle;
  String get categoryTitle => _categoryTitle;
  void set categoryTitle(String newValue) {
    if (newValue != _categoryTitle) {
      _categoryTitle = newValue;
      _categoryTitleChanged();
    }
  }

  String _cookbookTitle;
  String get cookbookTitle => _cookbookTitle;
  void set cookbookTitle(String newValue) {
    if (newValue != _cookbookTitle) {
      _cookbookTitle = newValue;
      _cookbookTitleChanged();
    }
  }

  String _cookbookName;
  String get cookbookName => _cookbookName;
  void set cookbookName(String newValue) {
    if (newValue != null) {
      _cookbookName = newValue;
      _cookbookNameChanged();
    }
  }

  List<RecipeTag> allTags;

  String get diagnostic => 'DIAGNOSTIC: $recipe, categoryTitle: $categoryTitle, cookbookTitle: $cookbookTitle, cookbookName: $cookbookName';

  @ViewChild('recipeTagListRef')
  ElementRef recipeTagListRef;

  List<Category> categoryList;
  List<Cookbook> cookbookList;
  bool showCookbooks = true;
  String recipetag;

  final StreamController _onFormEvent = new StreamController.broadcast();

  final CategoryService _categoryService;
  final RecipeService _recipeService;
  final CookbookService _cookbookService;
  final RecipesAppEvents _recipeEvents;

  bool _isNewCookbook = false;

  RecipeFormComponent(this._log, this._categoryService, this._recipeService, this._cookbookService, this._recipeEvents) {
    _log.loggerName = 'RecipeFormComponent';
//    recipe = new Recipe();
  }

  ngOnInit() {
    _log.fine('ngOnInit()');

    _categoryService.getAllCategories()
        .then((list) {
      categoryList = list;
      _log.fine('ngOnInit() categories = $categoryList');
    });

    _loadCookbooks();
    _loadRecipeTags();
  }

  @override
  ngOnDestroy() {
    _onFormEvent.close();
  }

  /// Returns a map of CSS class names representing the state of [control].
  Map<String, bool> controlStateClasses(NgControl control) => {
    'ng-dirty': control.dirty ?? false,
    'ng-pristine': control.pristine ?? false,
    'ng-touched': control.touched ?? false,
    'ng-untouched': control.untouched ?? false,
    'ng-valid': control.valid ?? false,
    'ng-invalid': control.valid == false
  };

  onSubmitClick() {
    _log.fine('onSubmitClick()');
    _log.fine('onSubmitClick() categoryTitle = $categoryTitle');
    _log.fine('onSubmitClick() cookbookTitle = $cookbookTitle');
    _log.fine('onSubmitClick() cookbookName = $cookbookName');

    _log.fine('onSubmitClick() recipe = $recipe');

    if (recipe.isValid) {
      if (recipe.isNew) {
        // This is a new recipe so call 'create' instead of 'save'
        _recipeService.createRecipe(recipe)
            .then((updatedRecipe) {
          _log.fine('onSubmitClick() updatedRecipe = $updatedRecipe');

          // null the current recipe, and get the new list of tags
          recipe = new Recipe();
          _loadRecipeTags();

          _recipeEvents.recipeAdded(updatedRecipe.id);

          // if the call succeeded and there was a new cookbook given then
          // reload them
          if (updatedRecipe != null && _isNewCookbook) {
            _loadCookbooks();
          }
        });
      } else {
        // This is an existing recipe so call 'save' instead of 'create'
        _recipeService.saveRecipe(recipe)
            .then((updatedRecipe) {
          _log.fine('onSubmitClick() updatedRecipe = $updatedRecipe');

          // null the current recipe, and get the new list of tags
          recipe = new Recipe();
          _loadRecipeTags();

          _recipeEvents.recipeUpdated(updatedRecipe.id);

          // if the call succeeded and there was a new cookbook given then
          // reload them
          if (updatedRecipe != null && _isNewCookbook) {
            _loadCookbooks();
          }
        });
      }
    }
  }

  /// Take the tag name from the input box if the user presses the enter key.
  void onTagKeyUp(var event) {
    _log.fine('onTagKeyUp() recipetag = $recipetag, event.runtimeType = ${event.runtimeType}');

    if (event.keyCode == 13 || event.which == 13) {
      if (recipetag != null && recipetag.isNotEmpty) {
        _log.fine('onTagKeyUp() enter key pressed. keeping $recipetag & clearing the selection');

        // convert the entered tag to start with an upper-case letter and the rest to lower-case,
        // and then create a tag from it
        recipe.recipeTags.add(new RecipeTag.fromValues(RecipeUtil.toTitleCaseAll(recipetag)));
      }

      recipetag = null;
    }
  }

  /// Fires when an input value appears, but ignore those not in the dropdown
  /// list, as those are manual entries from the keyboard.
  void onTagInput(var event) {
    _log.fine('onTagInput() recipeTagListRef.nativeElement.value = ${recipeTagListRef.nativeElement.value}');

    if (allTags != null && allTags.isNotEmpty) {
      var tempTag = allTags.firstWhere((rtag) => rtag.tagName == recipeTagListRef.nativeElement.value, orElse: () => null);

      if (tempTag != null) {
        _log.fine('onTagInput() this is from the dropdown. keeping ${recipeTagListRef.nativeElement.value} & clearing the selection');

        // this is a tag from the dropdown list, so keep it as the selected item
        recipe.recipeTags.add(tempTag);

        // and remove the tag from the selection
        allTags.remove(tempTag);

        recipeTagListRef.nativeElement.value = null;
      }
    }
  }

  /// handle events related to tags being added & removed from this recipe.
  void onTagEvent(var event) {
    _log.fine('onTagEvent() event = $event');

    // remove this tag from the list of tags
    if (RecipeTagEvent.DELETE == event[RecipeTagEvent.TYPE]) {
      var eventTag = new RecipeTag.fromJson(event[RecipeTagEvent.TAG]);
      _log.finest('onTagEvent() eventTag = $eventTag');

      // if the tag was pre-existing,
      // add the deleted tag back to the 'allTags' list
      if (!eventTag.isNew) {
        allTags.add(eventTag);
        allTags.sort((a, b) => a.tagName.compareTo(b.tagName));
      }

      if (eventTag.isNew) {
        _log.finer('onTagEvent() removing tag by name');
        recipe.recipeTags?.removeWhere((tag) => tag.tagName == eventTag.tagName);
      } else {
        _log.finer('onTagEvent() removing tag by id');
        recipe.recipeTags?.removeWhere((tag) => tag.id == eventTag.id);
      }
    }
  }

  _loadCookbooks() {
    _cookbookService.getAllCookbooks()
        .then((list) {
      cookbookList = list;
      _log.fine('_loadCookbooks() cookbookList = $cookbookList');
      showCookbooks = cookbookList != null && cookbookList.isNotEmpty;
      _log.fine('_loadCookbooks() showCookbooks = $showCookbooks');
    });
  }

  _loadRecipeTags() async {
    _recipeService.getAllRecipeTags()
        .then((list) {
      allTags = list;
      allTags.sort((a, b) => a.tagName.compareTo(b.tagName));
      _log.fine('_loadRecipeTags() allTags = $allTags');
    });
  }

  _categoryTitleChanged() {
    if (_categoryTitle != null && _categoryTitle.isNotEmpty) {
      var category = categoryList.firstWhere((category) => category.title == _categoryTitle, orElse: () => null);
      _log.fine('_categoryTitleChanged() category = $category');
      recipe.category = category;
    }
  }

  _cookbookTitleChanged() {
    if (cookbookTitle != null && cookbookTitle.isNotEmpty) {
      var cookbook = cookbookList.firstWhere((cookbook) => cookbook.name == cookbookTitle, orElse: () => null);
      _log.fine('onSubmitClick() cookbook = $cookbook');
      recipe.cookbook = cookbook;
    }
  }

  _cookbookNameChanged() {
    if (cookbookName != null && cookbookName.isNotEmpty) {
      recipe.cookbook = new Cookbook(name: cookbookName);
      _isNewCookbook = true;
    }
  }

  _recipeChanged() {
    cookbookTitle = _recipe?.cookbook?.name;
  }
}
