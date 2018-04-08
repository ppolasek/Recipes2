/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.Size;
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
@Entity // This tells Hibernate to make a table out of this class
public class LogRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    protected Long _id;
    private Date _logTime;
    private String _level;
    private String _loggerName;
    private String _message;

    public LogRecord() {};

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return this._id;
    }
    public void setId(Long _id) {
        this._id = _id;
    }

    public Date getLogTime() {
        return _logTime;
    }
    public void setLogTime(Date logTime) {
        _logTime = logTime;
    }

    @Column(length = 20)
    public String getLevel() {
        return _level;
    }
    public void setLevel(String level) {
        _level = level;
    }

    @Column(length = 50)
    public String getLoggerName() {
        return _loggerName;
    }
    public void setLoggerName(String loggerName) {
        _loggerName = loggerName;
    }

    @Size(max = 4000)
    @Column(length = 4000)
    public String getMessage() {
        return _message;
    }
    public void setMessage(String message) {
        _message = message;
    }

    @Override
    public String toString() {
        return new String("LogRecord:[" +
                "logTime = " + getLogTime() +
                ", level = " + getLevel() +
                ", loggerName = " + getLoggerName() +
                ", message = " + getMessage() +
        "]");
    }
}
