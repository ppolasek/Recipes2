/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

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
public class Cookbook extends DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private String _name;

    public Cookbook() {};
    public Cookbook(String name) {
        this._name = name;
    }

    @Override
    public String toString() {
        return "Cookbook[ " +
                "id: " + getId() +
                ", version: " + getVersion() +
                ", name: " + _name +
                " ]";
    }

    @Column(unique = true, nullable = false, length = 100)
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        _name = name;
    }
}
