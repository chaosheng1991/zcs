package controllers;

import com.jfinal.core.Controller;
import com.jfinal.ext.render.CaptchaRender;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


public class IndexController extends Controller {
	private static final String BASE_PATH = "/views/";
	private static final String RANDOM_CODE_KEY = "1";

	public void index(){
		render(BASE_PATH+"login.jsp");
	}

	/**
	 * 用户登录
	 */
	public void login() {
		String inputRandomCode = getPara("inputRandomCode");
		String userName = getPara("username");
		String passWord = getPara("password");
		//最初调用login函数时不做任何处理直接跳转至登录界面
		if (inputRandomCode == null || "".equals(inputRandomCode.trim())) {
			render(BASE_PATH+"login.jsp");
			return;
		}
		if(userName == null || "".equals(userName.trim())||passWord == null || "".equals(passWord.trim())){
			setSessionAttr("message", "用户名和密码不能为空！");
			render(BASE_PATH+"login.jsp");
		}
		boolean loginSuccess = CaptchaRender.validate(this, inputRandomCode, RANDOM_CODE_KEY);
		if (!loginSuccess) {
			setAttr("username",userName);
			setAttr("password",passWord);
			setSessionAttr("message", "验证码错误！");
			render(BASE_PATH+"login.jsp");
		}else{
			Record user=Db.findFirst("select * from user where username=? and password=?",userName,passWord);
			if(user==null){
				setAttr("username",userName);
				setAttr("password",passWord);
				setSessionAttr("message", "用户名或密码错误！");
				render(BASE_PATH+"login.jsp");		
			}else{
				setSessionAttr("username",user.get("username"));
				setSessionAttr("user_id",user.get("user_id"));
				setSessionAttr("name",user.get("name"));
				setSessionAttr("alias",user.get("alias"));
				redirect("/content");
			}
		}
	}

	public void img() {
		CaptchaRender img = new CaptchaRender(RANDOM_CODE_KEY);
		render(img);
	}
	
	public void myinfo() {
		String userId=getSessionAttr("user_id").toString();
		Record user=Db.findFirst("select * from user where user_id=?",userId);
		setAttr("user",user);
		String flag=getSessionAttr("flag");
		removeSessionAttr("flag");
		setAttr("flag",flag);
		render(BASE_PATH+"info.jsp");	
	}
	
	public void editInfo(){
		String userId=getSessionAttr("user_id").toString();
		try {
			Db.update("update user set name=?,alias=?,sex=?,note=? where user_id=?", getPara("name"), getPara("alias"),
					getPara("sex"), getPara("note"), userId);
			setSessionAttr("message", "个人设置修改成功！");
			removeSessionAttr("name");
			removeSessionAttr("alias");
			setSessionAttr("name",getPara("name"));
			setSessionAttr("alias",getPara("alias"));
		} catch (Exception e) {
			
		}
		setSessionAttr("message", "个人设置修改成功！");
		setSessionAttr("flag","info");
		redirect("/index/myinfo");
	}
	
	public void editPassword(){
		String userId=getSessionAttr("user_id").toString();
		Record r=Db.findFirst("select username from user where user_id=? and password=?",userId,getPara("oldPassword"));
		if(r==null){
			setSessionAttr("message", "原密码错误！");
			setSessionAttr("flag","password");
		}else{
			Db.update("update user set password=? where user_id=?",getPara("newPassword"),userId);
			setSessionAttr("message", "密码修改成功,请务必牢记新密码！");
			setSessionAttr("flag","password");
		}
		redirect("/index/myinfo");
	}
	
	/**
	 * 退出登录
	 */
	public void logout() {
		getSession().invalidate();
		redirect("/index");
	}
}
