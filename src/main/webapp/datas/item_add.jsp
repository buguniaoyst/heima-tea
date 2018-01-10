<%--
  Created by IntelliJ IDEA.
  User: yst
  Date: 2017/7/20
  Time: 0:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>新增测试题</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<!-- 列表面板 -->
<div class="layui-form-pane" style="margin-top: 15px;">
    <form id="jvForm" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/item/addItem" method="post">
        <div class="itemAnswerArea"   id="itemId" >
            <div class="site-title">
                <fieldset><legend><a >第1题</a></legend></fieldset>
            </div>
            <div class="site-item">
                itemContent
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">请写下你的思路</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入思路" cols="30" rows="10" class="layui-textarea silu"></textarea>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">请将你的答案粘贴到下边的文本域中：</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入答案" cols="30" rows="10" class="layui-textarea silu"></textarea>
            </div>
        </div>
        <div class="layui-input-block ">
            <button class="layui-upload-button">
                上传附件：<input  type="file" class="layui-btn layui-btn-primary" name="mp" onchange="uploadPic()" />
            </button>
            <input type="hidden" name="picPath" id="picPath"/>
        </div>

    </form>

</div>
<script src="${pageContext.request.contextPath }/lib/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.form.js" type="text/javascript"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form','upload'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;
        layui.upload();
    });
    function uploadVideo(){
        var options = {
            url : "/rest/uploadVideo.do",
            type : "post",
            dataType : "json",
            success : function(data) {
                //设置图片的在表单提交后的值
                $("#videoPath").val(data.videoPath);
                $("#showVideo").attr("href",data.videoPath);
                $("#videoDiv")[0].style.display = "block";
                console.log("上传的视频地址："+data.videoPath);
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }

    function uploadPic(){
        var options = {
            url : "/rest/uploadPic.do",
            type : "post",
            dataType : "json",
            success : function(data) {
                //设置图片的在表单提交后的值
                $("#picPath").val(data.picPath);
                $("#showPic").attr("src",data.picPath);
                $("#picDiv")[0].style.display = "block";
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }
</script>
</body>
</html>
