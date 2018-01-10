var singleItemTemplate = ' <div class="layui-form-item layui-form-text">\n' +
    '                <label class="layui-form-label">题干信息</label>\n' +
    '                <div class="layui-input-block">\n' +
    '                    <input name="itemContent" class="layui-input">\n' +
    '                </div>\n' +
    '            </div><div class="layui-form-item">\n' +
    '                <label class="layui-form-label">选项A</label>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="radio" name="itemAnswer" value="A" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项B</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="radio" name="itemAnswer" value="B" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项C</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="radio" name="itemAnswer" value="C" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项D</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="radio" name="itemAnswer" value="D" title="是否答案" >\n' +
    '                </div>\n' +
    '             </div>';



var codeItemTemplate='<div class="layui-form-item layui-form-text">\n' +
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
    '           </div>';


var multipartItemTemplate = ' <div class="layui-form-item layui-form-text">\n' +
    '                <label class="layui-form-label">题干信息</label>\n' +
    '                <div class="layui-input-block">\n' +
    '                    <input name="itemContent" class="layui-input">\n' +
    '                </div>\n' +
    '            </div><div class="layui-form-item">\n' +
    '                <label class="layui-form-label">选项A</label>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="checkbox" name="itemAnswer" value="A" lay-skin="primary" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项B</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="checkbox" name="itemAnswer" value="B" lay-skin="primary" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项C</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="checkbox" value="C" name="itemAnswer" lay-skin="primary" title="是否答案" >\n' +
    '                </div>\n' +
    '            </div>\n' +
    '            <div class="layui-form-item">\n' +
    '                 <label class="layui-form-label">选项D</label>\n' +
    '                 <div class="layui-input-inline">\n' +
    '                     <input type="text" name="itemAnswerOption" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
    '                 </div>\n' +
    '                <div class="layui-input-inline">\n' +
    '                    <input type="checkbox" value="D" name="itemAnswer" lay-skin="primary" title="是否答案" >\n' +
    '                </div>\n' +
    '             </div>';