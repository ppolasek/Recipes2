/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.service;

import com.sandbox.recipe.domain.Category;
import com.sandbox.recipe.domain.Cookbook;
import com.sandbox.recipe.domain.Recipe;
import com.sandbox.recipe.repository.CookbookRepository;
import com.sandbox.recipe.repository.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
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
@RestController
public class CookbookController {
    @Autowired // This means to get the bean called CategoryRepository
    // Which is auto-generated by Spring, we will use it to handle the data
    private CookbookRepository _cookbookRepository;

    @CrossOrigin
    @RequestMapping("/getAllCookbooks")
    public List<Cookbook> getAllCookbooks() {
        System.out.println("getAllCookbooks()");
        List<Cookbook> cookbooks = new ArrayList();

        _cookbookRepository.findAll().forEach(cookbooks::add);
        System.out.println("getAllCookbooks() cookbooks.size() = " + (cookbooks != null ? cookbooks.size() : "null"));

        return cookbooks;
    }

    // TODO implement these service methods

//    Future<List<Cookbook>> getAllCookbookNames();
//    Future<Cookbook> getCookbookById(Long cookbookId);
//    Future<Cookbook> saveCookbook(Cookbook cookbook);
//    Future<Cookbook> createCookbook(Cookbook cookbook);
//    Future<bool> deleteCookbook(Long cookbookId);

    //    private static final String template = "Hello %s";
//    private final AtomicLong counter = new AtomicLong();
//
//    @RequestMapping("/greeting")
//    public Greeting greeting(@RequestParam(value="name", defaultValue = "world") String name) {
//        return new Greeting(counter.incrementAndGet(),
//                String.format(template, name));
//    }
}
