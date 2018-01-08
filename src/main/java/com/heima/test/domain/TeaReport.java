package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Entity
@Table(name = "tea_report")
public class TeaReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Integer id;

    /**
     * 报告类型：1-助教周报   2-学员班会  3-助教例会  4-讲师例会  5-部门成果
     */
    private  Integer reportType;

    /**
     * 创建内容
     */
    private  String creater;
    /**
     * 创建日期
     */
    private Date createDate;
    /**
     * 主题
     */
    private String theme;
    /**
     * 内容概要
     */
    private  String  contentSummary;
    /**
     * 详细内容
     */
    private String contentDetail;
    /**
     * 标签
     */
    private String tags;

    /**
     * 成果 或  结论
     */
    private String result;

    /**
     * 备注
     */
    private String remark;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getReportType() {
        return reportType;
    }

    public void setReportType(Integer reportType) {
        this.reportType = reportType;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getContentSummary() {
        return contentSummary;
    }

    public void setContentSummary(String contentSummary) {
        this.contentSummary = contentSummary;
    }

    public String getContentDetail() {
        return contentDetail;
    }

    public void setContentDetail(String contentDetail) {
        this.contentDetail = contentDetail;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


    @Override
    public String toString() {
        return "TeaReport{" +
                "id=" + id +
                ", reportType=" + reportType +
                ", creater='" + creater + '\'' +
                ", createDate=" + createDate +
                ", theme='" + theme + '\'' +
                ", contentSummary='" + contentSummary + '\'' +
                ", contentDetail='" + contentDetail + '\'' +
                ", tags='" + tags + '\'' +
                ", result='" + result + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
