# My Favorite Recipes2
Organize all your favorite recipes!

Keep track of:
1. which cookbook your recipe is in and the page number
2. or the URL to your favorite recipe
3. a picture of the prepared dish
4. Notes on what the heck went wrong, or what you had to change
    1. e.g. used different ingredients, or how much

Also:
1. Rate the 'true' effort level to prepare the ingredients and cook the meal
   and the time it took from prep work to completion!

## Coming Soon!
#### Recipes3 - get rid of the back-end services and use a Mongo DB implementation
#### Recipes4 - convert the application to Angular JS

### An Angular Dart application backed by Spring Boot Java Rest services and MySql.

### Getting Started
1. Create a `recipes2` database in MySql
2. Edit the application.properties file and switch these commented-out lines.   
This will create the underlying database tables.   
The file is located at `recipe_server/src/main/resources`

```
# spring.jpa.hibernate.ddl-auto=create
spring.jpa.hibernate.ddl-auto=none
```
3. Start the application server by right-clicking on RecipeServerApplication and selecting "run 'RecipeServerApplication.main()'.   
The file is located at `recipe_server/src/main/java/com/sandbox/recipe`

4. open `index.html` in a web browser by right-clicking the file and select 'Open in Browser',   
then select a browser from the selection.   
The file is located at `recipe_web/web/index.html`

## TODOs
Not in any particular order

## Features Used
#### Spring features used in recipe_server
Feature - Where Located  
tbd - tbd

#### Angular Dart features used in recipe_web

Feature - Where Located  
dependency injection - every file ending in _component.dart  
event firing - recipe_form_component.dart  
event handling - recipe_app_component.dart  
component declaration - every file ending in _component.dart  
services - every file ending in _service.dart  
unit tests - tbd  


#### recipe_server
 1. [ ] Add a 'real' logger to the server application
 2. [ ]

#### recipe_web
 1. [x] make the dialog its own component
 2. [x] make the dialog wider to accommodate the wider form
 3. [x] make the recipe input form two columns to make it more square than vertical N/A
 4. [x] get rid of categories and use tags instead, as multiple tags may be applied to a recipe, but a recipe may belong to only one category
 5. [x] Move logic to open and close the dialog to within the dialog component itself
 6. [x] Retrieve and display the last 5 recipes created
 7. [x] Retrieve and display the 5 most frequently viewed recipes
 8. [x] Convert the main page from a bootstrap css row/column to use margin with viewport measurement (vw)
 9. [x] When hovering over a recipe display it in the main viewing area
 10. [x] When clicking on a recipe display it in the viewing area and add it to the viewing history
 11. [x] Add means to search for a recipe by tag(s) or string value
 12. [x] Add means to edit a recipe, and pre-select the dropdowns
 13. [x] Change save recipe event to indicated recipe was saved instead of generic 'form event' so dialog may be closed
 14. [x] List tags when hovering over the recipe name
 15. [ ] Write a few Angular Dart unit tests
 16. ~~[ ] When clicking on a recipe change the background to be the same as when hovering
 over it, but add a background. And when hovering over a different recipe to display it,
 revert the styling of the clicked recipe.~~
 17. ~~[ ] Create a directive to handle the styling of the recipe lists when hovered over or
 clicked on.~~

===========================================================================================

### See LICENSE
