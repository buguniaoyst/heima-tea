package com.heima.test.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.heima.test.utils.Constants;
import com.heima.test.utils.FastDFSTool;

@Controller
public class UploadController {
	
	
	@RequestMapping(value="/uploadVideo.do")
	@ResponseBody
	public Map<String, String> uploadVideo(MultipartFile mf) throws FileNotFoundException, IOException, Exception{
		
		// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
		String uploadFile = FastDFSTool.uploadFile(mf.getBytes(),
				mf.getOriginalFilename());
		// 返回json格式的字符串（图片的绝对网络存放地址）
		Map<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("videoPath", Constants.FDFS_SERVER + uploadFile);
		return hashMap;
	}

	@RequestMapping(value="/uploadPic.do")
	@ResponseBody
	public Map<String, String> uploadPic(MultipartFile mp) throws FileNotFoundException, IOException, Exception{

		// 将文件上传到分布式文件系统，并返回文件的存储路径及名称
		String uploadFile = FastDFSTool.uploadFile(mp.getBytes(),
                mp.getOriginalFilename());
		// 返回json格式的字符串（图片的绝对网络存放地址）
		Map<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("picPath", Constants.FDFS_SERVER + uploadFile);
		return hashMap;
	}
	
	


}
