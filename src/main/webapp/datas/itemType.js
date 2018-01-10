
//题目类型
/*编程题*/
var codeContentStr = '<form id="jvForm" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/item/addItem" method="post">\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">适用范围</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="classType" lay-filter="aihao">\n' +
    '                    <option value=""></option>\n' +
    '                    <option value="0" selected="">基础班</option>\n' +
    '                    <option value="1">就业班</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">题目类型</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="itemType" lay-filter="itemType">\n' +
    '                    <option value=""></option>\n' +
    '                    <option value="0" selected="">编程题</option>\n' +
    '                    <option value="1">单选题</option>\n' +
    '                    <option value="2">多选题</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">课程模块</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="quiz1">\n' +
    '                    <option value="">请选择课程模块</option>\n' +
    '                    <option value="11" selected="">JavaSE初级</option>\n' +
    '                    <option value="12" >JavaSE高级</option>\n' +
    '                    <option value="13" >MySQL+JDBC</option>\n' +
    '                    <option value="14" >前端</option>\n' +
    '                    <option value="15" >JavaWeb核心</option>\n' +
    '                    <option value="16" >Estore</option>\n' +
    '                    <option value="17" >Linux</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="itemSourceId">\n' +
    '                    <option value="">请选择课程</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '\n' +
    '        <div class="layui-form-item" pane="">\n' +
    '            <label class="layui-form-label">题目状态</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <input type="radio" name="itemStatus" value="1" title="启用" checked="">\n' +
    '                <input type="radio" name="itemStatus" value="0" title="禁用" >\n' +
    '            </div>\n' +
    '        </div>\n' +
    '\n' +
    '           <div class="layui-form-item layui-input-inline" pane="">\n' +
    '               <label class="layui-form-label">分值</label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <input type="number" name="itemScore" class="layui-input">\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <!-- 视频上传 -->\n' +
    '           <div class="layui-form-item layui-input-inline" pane="">\n' +
    '               <label class="layui-form-label">视频上传 </label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <button class="layui-upload-button">\n' +
    '                       选择视频<input type="file" name="mf" onchange="uploadVideo()" />\n' +
    '                   </button>\n' +
    '                   <input type="hidden" name="videoPath" id="videoPath"/>\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <div id="videoDiv" class="layui-form-item layui-input-inline " style="display:none">\n' +
    '               <label class="layui-form-label">\n' +
    '                   <a id="showVideo" target="_blank" href="#">播放视频文件</a>\n' +
    '               </label>\n' +
    '               <div class="layui-input-block">\n' +
    '\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <div class="layui-form-item">\n' +
    '               <label class="layui-form-label">答案解析</label>\n' +
    '               <div class="layui-input-block layui-inline">\n' +
    '                   <button class="layui-upload-button">\n' +
    '                       选择图片<input type="file" name="mp" onchange="uploadPic()" />\n' +
    '                   </button>\n' +
    '                   <input type="hidden" name="picPath" id="picPath"/>\n' +
    '               </div>\n' +
    '               <div id="picDiv" class="layui-input-block layui-inline" style="display:none">\n' +
    '                   <img src="#" id="showPic" style="height: 200px;width: 200px">\n' +
    '               </div>\n' +
    '           </div>\n' +
    '         <div class="layui-form-item layui-form-text">\n' +
    '            <label class="layui-form-label">题干信息</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <textarea  name="itemContent" placeholder="请输入题干信息" class="layui-textarea"></textarea>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '           <div class="layui-form-item layui-form-text">\n' +
    '               <label class="layui-form-label">参考答案</label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <textarea  name="itemAnswer" placeholder="请输入参考答案" class="layui-textarea"></textarea>\n' +
    '               </div>\n' +
    '           </div>\n' +
    '        <div class="layui-form-item">\n' +
    '            <button class="layui-btn" lay-submit="" lay-filter="demo2">新增</button>\n' +
    '            <button class="layui-btn "   type="reset" >重置</button>\n' +
    '        </div>\n' +
    '    </form>';

var  singleChoiseItem = '<form id="jvForm" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/item/addItem" method="post">\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">适用范围</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="classType" lay-filter="aihao">\n' +
    '                    <option value=""></option>\n' +
    '                    <option value="0" selected="">基础班</option>\n' +
    '                    <option value="1">就业班</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">题目类型</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="itemType" lay-filter="aihao">\n' +
    '                    <option value=""></option>\n' +
    '                    <option value="0">选择题</option>\n' +
    '                    <option value="1" selected="">编程题</option>\n' +
    '                    <option value="2">填空题</option>\n' +
    '                    <option value="3">判断题</option>\n' +
    '                    <option value="4">其他</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '\n' +
    '        <div class="layui-form-item">\n' +
    '            <label class="layui-form-label">课程模块</label>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="quiz1">\n' +
    '                    <option value="">请选择课程模块</option>\n' +
    '                    <option value="11" selected="">JavaSE初级</option>\n' +
    '                    <option value="12" >JavaSE高级</option>\n' +
    '                    <option value="13" >MySQL+JDBC</option>\n' +
    '                    <option value="14" >前端</option>\n' +
    '                    <option value="15" >JavaWeb核心</option>\n' +
    '                    <option value="16" >Estore</option>\n' +
    '                    <option value="17" >Linux</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '            <div class="layui-input-inline">\n' +
    '                <select name="itemSourceId">\n' +
    '                    <option value="">请选择课程</option>\n' +
    '                    <option value="1101" selected="">day01-搭建环境、数据类型</option>\n' +
    '                    <option value="1102">day02-Eclipse-运算符-键盘录入</option>\n' +
    '                    <option value="1103">day03-选择、循环语句</option>\n' +
    '                    <option value="1104">day04-Random-数组</option>\n' +
    '                    <option value="1105">day05-方法</option>\n' +
    '                    <option value="1106">day06-断点调试-练习</option>\n' +
    '                    <option value="1107">day07-面向对象-private-this-构造方法</option>\n' +
    '                    <option value="1108">day08-String-StringBuilder</option>\n' +
    '                    <option value="1109">day09-对象数组-ArrayList-学生管理案例</option>\n' +
    '                    <option value="1110">day10-字符流-字符缓冲流</option>\n' +
    '                    <option value="1111">day11-学生管理案例IO流版本</option>\n' +
    '                </select>\n' +
    '            </div>\n' +
    '            \n' +
    '        </div>\n' +
    '\n' +
    '        <div class="layui-form-item" pane="">\n' +
    '            <label class="layui-form-label">题目状态</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <input type="radio" name="itemStatus" value="1" title="启用" checked="">\n' +
    '                <input type="radio" name="itemStatus" value="0" title="禁用" >\n' +
    '            </div>\n' +
    '        </div>\n' +
    '\n' +
    '           <div class="layui-form-item layui-input-inline" pane="">\n' +
    '               <label class="layui-form-label">分值</label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <input type="number" name="itemScore" class="layui-input">\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <!-- 视频上传 -->\n' +
    '           <div class="layui-form-item layui-input-inline" pane="">\n' +
    '               <label class="layui-form-label">视频上传 </label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <button class="layui-upload-button">\n' +
    '                       选择视频<input type="file" name="mf" onchange="uploadVideo()" />\n' +
    '                   </button>\n' +
    '                   <input type="hidden" name="videoPath" id="videoPath"/>\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <div id="videoDiv" class="layui-form-item layui-input-inline " style="display:none">\n' +
    '               <label class="layui-form-label">\n' +
    '                   <a id="showVideo" target="_blank" href="#">播放视频文件</a>\n' +
    '               </label>\n' +
    '               <div class="layui-input-block">\n' +
    '\n' +
    '               </div>\n' +
    '           </div>\n' +
    '           <div class="layui-form-item">\n' +
    '               <label class="layui-form-label">答案解析</label>\n' +
    '               <div class="layui-input-block layui-inline">\n' +
    '                   <button class="layui-upload-button">\n' +
    '                       选择图片<input type="file" name="mp" onchange="uploadPic()" />\n' +
    '                   </button>\n' +
    '                   <input type="hidden" name="picPath" id="picPath"/>\n' +
    '               </div>\n' +
    '               <div id="picDiv" class="layui-input-block layui-inline" style="display:none">\n' +
    '                   <img src="#" id="showPic" style="height: 200px;width: 200px">\n' +
    '               </div>\n' +
    '           </div>\n' +
    '         <div class="layui-form-item layui-form-text">\n' +
    '            <label class="layui-form-label">题干信息</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <textarea  name="itemContent" placeholder="请输入题干信息" class="layui-textarea"></textarea>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '           <div class="layui-form-item layui-form-text">\n' +
    '               <label class="layui-form-label">参考答案</label>\n' +
    '               <div class="layui-input-block">\n' +
    '                   <textarea  name="itemAnswer" placeholder="请输入参考答案" class="layui-textarea"></textarea>\n' +
    '               </div>\n' +
    '           </div>\n' +
    '        <div class="layui-form-item">\n' +
    '            <button class="layui-btn" lay-submit="" lay-filter="demo2">新增单选题</button>\n' +
    '            <button class="layui-btn "   type="reset" >重置</button>\n' +
    '        </div>\n' +
    '    </form>';

