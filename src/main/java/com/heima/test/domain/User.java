package com.heima.test.domain;

import javax.persistence.*;

/**
 * Created by yst on 2017/7/19.
 */
@Entity
@Table(name = "user_info")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id", unique=true, nullable=false)
    private Integer id;
    private String userName;
    private String password;
    private String classId;
    private String testId;
    private Integer userType ;
    private Integer testStatus;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Integer getTestStatus() {
        return testStatus;
    }

    public void setTestStatus(Integer testStatus) {
        this.testStatus = testStatus;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", classId='" + classId + '\'' +
                ", testId='" + testId + '\'' +
                ", userType=" + userType +
                ", testStatus=" + testStatus +
                '}';
    }
}
