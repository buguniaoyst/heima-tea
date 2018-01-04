package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 *
 * 课程表
 */
@Entity
@Table(name = "course_schedule")
public class CourseSchedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    /**
     * 主键id
     */
    private Integer id;
    /**
     * 结课时间，格式：yyyy-MM-dd
     */
    private Date endDate;
    /**
     * 班级id
     */
    private Integer classId;
    /**
     * 课表状态；0-禁用  1-正常使用
     */
    private Integer state;
    /**
     * 班级名称
     */
    private String className;
    /**
     * 是否正常上课时间：0-否 1-是
     */
    private Integer hasHonorsDay;

    /**
     * 助教姓名
     */
    private String assistant;

    /**
     * 班主任姓名
     */
    private String masterName;

    /**
     * 最后更新时间
     */
    private Date lastUpdateTime;

    /**
     * 最后更新者
     */
    private String lastUpdater;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getClassId() {
        return classId;
    }

    public void setClassId(Integer classId) {
        this.classId = classId;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getHasHonorsDay() {
        return hasHonorsDay;
    }

    public void setHasHonorsDay(Integer hasHonorsDay) {
        this.hasHonorsDay = hasHonorsDay;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
    }

    public String getMasterName() {
        return masterName;
    }

    public void setMasterName(String masterName) {
        this.masterName = masterName;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getLastUpdater() {
        return lastUpdater;
    }

    public void setLastUpdater(String lastUpdater) {
        this.lastUpdater = lastUpdater;
    }

    @Override
    public String toString() {
        return "CourseSchedule{" +
                "id=" + id +
                ", endDate=" + endDate +
                ", classId=" + classId +
                ", state=" + state +
                ", className='" + className + '\'' +
                ", hasHonorsDay=" + hasHonorsDay +
                ", assistant='" + assistant + '\'' +
                ", masterName='" + masterName + '\'' +
                ", lastUpdateTime=" + lastUpdateTime +
                ", lastUpdater='" + lastUpdater + '\'' +
                '}';
    }
}
