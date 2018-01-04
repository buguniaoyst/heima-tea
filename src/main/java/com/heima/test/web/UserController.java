package com.heima.test.web;

import com.heima.test.domain.User;
import com.heima.test.service.TestService;
import com.heima.test.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {
    private Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private TestService testService;


    @RequestMapping(value = "regist",method = RequestMethod.POST)
    public String regist(User user) {
        //根据用户名和testid做幂等
        User exitUser = userService.queryListByUserNameAndClassid(user);
        if(null != exitUser){
            return "redirect:/rest/login.jsp?classid="+user.getClassId()+"&registMsg=you have registed,please login on now!";
        }
        user.setTestStatus(0);
        userService.save(user);
        return "redirect:/rest/login.jsp?classid="+user.getClassId();
    }


    /**
     * 后台登录
     *
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ModelAndView login(User user, HttpSession session) {

        if (StringUtils.isBlank(user.getUserName()) || StringUtils.isBlank(user.getPassword())) {
            return new ModelAndView("login","message","请输入正确的用户名和密码");
        }

        //查询
        List<User> userList = userService.queryListByExample(user);
        if(null != userList && userList.size()>0 ){
            session.setAttribute("loginUser",userList.get(0));
            Integer userType = userList.get(0).getUserType();
                return new ModelAndView("redirect:/rest/index");

        }
            return new ModelAndView("login","message","请输入正确的用户名和密码");

    }




    @RequestMapping(value = "loginOut")
    public String loginOut(HttpSession session){
        //销毁session
        session.invalidate();
        return "redirect:/rest/admin_login";
    }


    @RequestMapping(value = "addUser",method = RequestMethod.POST)
    public String addUser(User user) {
        //根据用户名和classid做幂等
        User exitUser = userService.queryListByUserNameAndClassid(user);
        if(null != exitUser){
            return "redirect:/rest/login.jsp?classid="+user.getClassId()+"&registMsg=you have registed,please login on now!";
        }

        userService.save(user);
        return "redirect:/rest/user_info/user_list";
    }

    @RequestMapping(value = "userList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getUserList() {
        Map<String,Object> resultMap = new HashMap<>();
        List<User> userList = userService.queryAll();
        resultMap.put("pagesize", 20);
        resultMap.put("results", userList);
        return resultMap;
    }


    @RequestMapping(value = "getUserListByUserType", method = RequestMethod.GET)
    @ResponseBody
    public List<User> getUserListByUserType(@RequestParam("userType") Integer userType) {
        return userService.queryUserListByUserType(userType);
    }



}
