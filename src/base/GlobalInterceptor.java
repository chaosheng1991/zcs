package base;
import javax.servlet.http.HttpSession;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class GlobalInterceptor implements Interceptor {

	public void intercept(Invocation inv) {
		Controller c = inv.getController();
		String cKey = inv.getControllerKey() + "/" + inv.getMethodName();
		String basePath = c.getSessionAttr("basePath");
		if (basePath == null || "".equals(basePath.trim())) {
			// 标准路径
			String path = c.getRequest().getContextPath();
			basePath = c.getRequest().getScheme() + "://"
					+ c.getRequest().getServerName() + ":"
					+ c.getRequest().getServerPort() + path + "/";
			c.setSessionAttr("basePath", basePath);		
		}
		if (c.getSessionAttr("username") == null
				&& !cKey.contains("/login") && !cKey.contains("/img")) {
			c.redirect(basePath+ "index/login");
			return;
		}
		try {

			inv.getController().keepPara();
			HttpSession session = c.getSession();
			session.removeAttribute("mess");
			inv.invoke();
		} catch (Exception e) {
			e.printStackTrace();
			// 发生异常，跳转至错误界面
			inv.getController().setAttr("exception", e);
			inv.getController().render("/views/500.jsp");
		}
	}

}
