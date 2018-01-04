package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 *
 * 课程表对应的课程
 */
@Entity
@Table(name = "course_schedule_detail")
public class CourseScheduleDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    /**
     * 课表id
     */
    private Integer baseId;

    /**
     * 日期：yyyy-MM-dd
     */
    private Date classDate;

    /**
     * 授课模式：0-传统全天  1-AB上午  2-AB下午
     */
    private Integer classMode;

    /**
     * 教室id
     */
    private Integer classRoomId;

    /**
     * 教室名称
     */
    private String classRoomName;

    /**
     * 课程内容
     */
    private String content;

    /**
     * 实际课程天数
     */
    private Integer daySort;

    /**
     * 是否正常上课：0-否  1-是
     */
    private Integer hasHonorsDay;

    /**
     * 是否是大纲课程：0-否  1-是
     */
    private Integer isOutline;

    /**
     * 讲师工号
     */
    private String jobNumber;

    /**
     * 讲师id
     */
    private Integer teacherId;

    /**
     * 讲师姓名
     */
    private  String teacherName;

    /**
     * 星期编号： 1-星期一 ... 7-星期日
     */
    private Integer weekSort;

    /**
     * 助教
     */
    private String assistant;

    /**
     * 助教id
     */
    private Integer assistantId;

    /**
     * 备注
     */
    private String remark;


    /**
     * 班级名
     */
    private String className;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBaseId() {
        return baseId;
    }

    public void setBaseId(Integer baseId) {
        this.baseId = baseId;
    }

    public Date getClassDate() {
        return classDate;
    }

    public void setClassDate(Date classDate) {
        this.classDate = classDate;
    }

    public Integer getClassMode() {
        return classMode;
    }

    public void setClassMode(Integer classMode) {
        this.classMode = classMode;
    }

    public Integer getClassRoomId() {
        return classRoomId;
    }

    public void setClassRoomId(Integer classRoomId) {
        this.classRoomId = classRoomId;
    }

    public String getClassRoomName() {
        return classRoomName;
    }

    public void setClassRoomName(String classRoomName) {
        this.classRoomName = classRoomName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getDaySort() {
        return daySort;
    }

    public void setDaySort(Integer daySort) {
        this.daySort = daySort;
    }

    public Integer getHasHonorsDay() {
        return hasHonorsDay;
    }

    public void setHasHonorsDay(Integer hasHonorsDay) {
        this.hasHonorsDay = hasHonorsDay;
    }

    public Integer getIsOutline() {
        return isOutline;
    }

    public void setIsOutline(Integer isOutline) {
        this.isOutline = isOutline;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public Integer getWeekSort() {
        return weekSort;
    }

    public void setWeekSort(Integer weekSort) {
        this.weekSort = weekSort;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
    }

    public Integer getAssistantId() {
        return assistantId;
    }

    public void setAssistantId(Integer assistantId) {
        this.assistantId = assistantId;
    }


    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    @Override
    public String toString() {
        return "CourseScheduleDetail{" +
                "id=" + id +
                ", baseId=" + baseId +
                ", classDate=" + classDate +
                ", classMode=" + classMode +
                ", classRoomId=" + classRoomId +
                ", classRoomName='" + classRoomName + '\'' +
                ", content='" + content + '\'' +
                ", daySort=" + daySort +
                ", hasHonorsDay=" + hasHonorsDay +
                ", isOutline=" + isOutline +
                ", jobNumber='" + jobNumber + '\'' +
                ", teacherId=" + teacherId +
                ", teacherName='" + teacherName + '\'' +
                ", weekSort=" + weekSort +
                ", assistant='" + assistant + '\'' +
                ", assistantId=" + assistantId +
                ", remark='" + remark + '\'' +
                ", className='" + className + '\'' +
                '}';
    }
}
