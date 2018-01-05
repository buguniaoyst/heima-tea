package com.heima.test.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.abel533.entity.Example;
import com.heima.test.dao.AnswerInfoDao;
import com.heima.test.domain.AnswerInfo;
import com.heima.test.domain.ScoreInfo;
import com.heima.test.domain.User;
import com.heima.test.utils.ZipUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.csource.fastdfs.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.util.*;

@Service
@Transactional
public class AnswerInfoService extends  BaseService<AnswerInfo> {

    @Autowired
    private AnswerInfoDao answerInfoDao;

    private ObjectMapper mapper = new ObjectMapper();

    public Boolean addAnswerInfo(String answerInfo,User loginUser) {
        System.out.println(answerInfo);
        try {
            List<AnswerInfo> answerInfoList = mapper.readValue(answerInfo, new TypeReference<List<AnswerInfo>>() {});
            System.out.println(answerInfoList);
            if (null != answerInfoList && answerInfoList.size()>0){
                for(AnswerInfo answer:answerInfoList){
                    answer.setTestId(loginUser.getTestId());
                    answer.setStuName(loginUser.getUserName());
                    answer.setAnswerStatus(0);
                    save(answer);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    public List<AnswerInfo> queryAllOrderByClassid() {
        return  answerInfoDao.queryAnswerInfoGroupByStuidOrderByClassId();
    }

    public List<AnswerInfo> queryAnswerInfoListGroupByClassId() {
        return answerInfoDao.queryAnswerInfoListGroupByClassId();
    }

    public List<AnswerInfo> queryAnswerInfoListByClassId(String classId) {
        List<AnswerInfo> answerInfoList = answerInfoDao.queryAnswerInfoListByClassIdGroupByTestId(classId);
        return  answerInfoList;

    }

    public List<AnswerInfo> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {
        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId()) && StringUtils.isNotBlank(answerInfo.getTestId())){
            List<AnswerInfo> answerInfoList = answerInfoDao.queryClassAnswerListByClassIdAndTestIdGroupByStuId(answerInfo.getClassId(), answerInfo.getTestId());
            return answerInfoList;
        }
        return  null;
    }

    public List<AnswerInfo> queryAnswerInfoListByClassIdAndTestIdAndStuId(Integer classId, Integer testId, Integer stuId) {
        Example example = new Example(AnswerInfo.class);
        example.createCriteria().andEqualTo("classId", classId)
                .andEqualTo("testId", testId)
                .andEqualTo("stuId", stuId);
        return this.getMapper().selectByExample(example);

    }

    public void updateAnswerInfoByStuIdAndItemId(ScoreInfo scinf) {
        Example example = new Example(AnswerInfo.class);
        example.createCriteria().andEqualTo("stuId", scinf.getStuId())
                .andEqualTo("itemId", scinf.getItemId());
        AnswerInfo answerInfo = new AnswerInfo();
        answerInfo.setAnswerStatus(1);
        answerInfo.setScore(scinf.getItemScore());
        this.getMapper().updateByExampleSelective(answerInfo, example);
    }

    public Map<String,Object> getZipDirs(String zipPath) throws  Exception {
        String treeNodes = "";
        if (StringUtils.isNotBlank(zipPath)) {
           treeNodes = ZipUtils.getTreeNodes(zipPath);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("nodes", treeNodes);
        return result;
    }


    public String getFileContent(String filePath) {
        File f = new File(filePath);
        if (f.isFile()) {
            try {
                String str =  FileUtils.readFileToString(f, "UTF-8");
                return StringEscapeUtils.escapeHtml4(str);
            }catch (Exception e){
                e.printStackTrace();
                return null;
            }

        }

            return null;
    }
}
