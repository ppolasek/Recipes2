/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.Transient;
import javax.persistence.Version;
import java.io.Serializable;
import java.util.Date;

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
@MappedSuperclass
public class DomainCommon implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long _id;
    private Integer _version;
    private Date _updatedOn;
    private Date _createdOn;

    DomainCommon() {}

    @Transient
    public boolean isNew() {
        return getId() == null || getId() < 0;
    }

    @PrePersist
    void preInsert() {
        if (isNew()) {
            setCreatedOn(new Date());
        }
        setUpdatedOn(new Date());
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return this._id;
    }
    public void setId(Long _id) {
        this._id = _id;
    }

    @Version
    @Column(nullable = false)
    public Integer getVersion() {
        return this._version;
    }
    public void setVersion(Integer _version) {
        this._version = _version;
    }

    @Column(nullable = false, columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    public Date getCreatedOn() {
        return this._createdOn;
    }
    public void setCreatedOn(Date creationDate) {
        this._createdOn = creationDate;
    }

    @Column(nullable = false, columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    public Date getUpdatedOn() {
        return this._updatedOn;
    }
    public void setUpdatedOn(Date lastUpdateDate) {
        this._updatedOn = lastUpdateDate;
    }
}
