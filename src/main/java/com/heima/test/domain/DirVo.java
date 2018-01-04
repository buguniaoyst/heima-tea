package com.heima.test.domain;


import java.util.ArrayList;
import java.util.List;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
public class DirVo {
    private Integer id;
    private String name;
    private String alias;
    private Boolean spread;
    private List<Object> children = new ArrayList<>();
    private String fileContent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public Boolean getSpread() {
        return spread;
    }

    public void setSpread(Boolean spread) {
        this.spread = spread;
    }

    public List<Object> getChildren() {
        return children;
    }

    public void setChildren(List<Object> children) {
        this.children = children;
    }

    public String getFileContent() {
        return fileContent;
    }

    public void setFileContent(String fileContent) {
        this.fileContent = fileContent;
    }

    @Override
    public String toString() {
        return "DirVo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", alias='" + alias + '\'' +
                ", spread=" + spread +
                ", children=" + children +
                ", fileContent='" + fileContent + '\'' +
                '}';
    }
}
