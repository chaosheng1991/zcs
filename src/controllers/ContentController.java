package controllers;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import models.Article;
import net.coobird.thumbnailator.Thumbnails;
import util.ID;


public class ContentController extends Controller {
	private static final String BASE_PATH = "/views/";
	private static final int pageSize=10;
	private static final String PIC_PATH="upload/picture";
	private static final String THUM_PATH="upload/thumbnail";
	public void index(){
		int pageNumber=0;
		if(getPara("pageNow")==null||"".equals(getPara("pageNow"))){
			pageNumber=1;
		}else{
			pageNumber=Integer.parseInt(getPara("pageNow").toString());
		}
		Page<Record> pagination=Db.paginate(pageNumber,pageSize,"select a.article_id,a.title,a.descript,"
				+ "a.open_time,a.submit_time,u.alias ", 
				"from article a left join user u on a.user_id=u.user_id where a.is_out_view=0 and a.open_time<=? order by a.open_time desc", new Date());
		setAttr("pagination", pagination);
		render(BASE_PATH+"main.jsp");
	}
	
	public void more(){
		int pageNumber=0;
		if(getPara("pageNow")==null||"".equals(getPara("pageNow"))){
			pageNumber=1;
		}else{
			pageNumber=Integer.parseInt(getPara("pageNow").toString());
		}
		Page<Record> pagination=Db.paginate(pageNumber,pageSize,"select a.article_id,a.title,a.descript,"
				+ "a.open_time,a.submit_time,u.alias ", 
				"from article a left join user u on a.user_id=u.user_id where a.is_out_view=0 and open_time<=? order by a.open_time desc", new Date());
		setAttr("pagination", pagination);
		render(BASE_PATH+"more.jsp");
	}
	
	public void view(){
		Record article=Db.findFirst("select * from article where article_id=? and is_out_view=0 and open_time<=?",getPara("articleId"),new Date());
		if(article==null){
			setAttr("article","");
		}else{
			setAttr("article",article);
		}
		renderJson();
	}
	
	public void my(){
		int pageNumber=0;
		String userId=getSessionAttr("user_id").toString();
		if(getPara("pageNow")==null||"".equals(getPara("pageNow"))){
			pageNumber=1;
		}else{
			pageNumber=Integer.parseInt(getPara("pageNow").toString());
		}
		Page<Record> pagination=Db.paginate(pageNumber,pageSize,"select a.article_id,a.title,a.descript,"
				+ "a.open_time,a.is_out_view,a.submit_time ", 
				"from article a where a.user_id=? order by a.submit_time desc",userId);
		setAttr("pagination", pagination);
		render(BASE_PATH+"my.jsp");
	}
	
	public void mymore(){
		int pageNumber=0;
		String userId=getSessionAttr("user_id").toString();
		if(getPara("pageNow")==null||"".equals(getPara("pageNow"))){
			pageNumber=1;
		}else{
			pageNumber=Integer.parseInt(getPara("pageNow").toString());
		}
		Page<Record> pagination=Db.paginate(pageNumber,pageSize,"select a.article_id,a.title,a.descript,"
				+ "a.open_time,a.is_out_view,a.submit_time ", 
				"from article a where a.user_id=? order by a.submit_time desc", userId);
		setAttr("pagination", pagination);
		render(BASE_PATH+"mymore.jsp");
	}
	
	public void myview(){
		String userId=getSessionAttr("user_id").toString();
		Record article=Db.findFirst("select * from article where article_id=? and user_id=?",getPara("articleId"),userId);
		if(article==null){
			setAttr("article","");
		}else{
			setAttr("article",article);
		}
		renderJson();
	}
	
	public void addNew(){
		render(BASE_PATH+"new.jsp");
	}
	
	public void add(){
		 HttpServletRequest request = getRequest();  
	        String basePath = request.getContextPath();   
	        //存储路径  
	        String path = getSession().getServletContext().getRealPath(PIC_PATH);
	        String thumPath = getSession().getServletContext().getRealPath(THUM_PATH); 
	        UploadFile file = getFile("picture");  
	        System.out.println(path);  
	        String fileName = "";  
	        if(file.getFile().length() > 200*1024*1024) {  
	            System.err.println("文件长度超过限制，必须小于200M");  
	        }else{  
	            //上传文件  
	            String type = file.getFileName().substring(file.getFileName().lastIndexOf(".")); // 获取文件的后缀  
	            long currentTime=System.currentTimeMillis();
	            fileName = currentTime + type; // 对文件重命名取得的文件名+后缀  
	            String dest = path + "/" + fileName;  
	            file.getFile().renameTo(new File(dest));
	            try {
					Thumbnails.of(dest).size(300, 300).toFile(
							thumPath+"/"+currentTime+"_thumb"+type);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }  
		String userId=getSessionAttr("user_id").toString();
		Article article=new Article();
		article.set("article_id", ID.getId());
		article.set("user_id", userId);
		article.set("title", getPara("title"));
		article.set("descript", getPara("descript"));
		article.set("content", getPara("content"));
		if(getPara("open_time")==null||getPara("open_time").equals("")){
			article.set("open_time", null);
		}else{	
			article.set("open_time", getPara("open_time"));
		}
		article.set("is_out_view", getPara("is_out_view"));  //是否对外开放，0-是  1-否
		if(getPara("title")==null||getPara("title").equals("")||getPara("descript")==null||getPara("descript").equals("")||
				getPara("is_out_view")==null){
			setSessionAttr("message", "保存失败，标题、摘要和是否开放不能为空！");
			setAttr("article", article);
			render(BASE_PATH+"new.jsp");
			return;
		}
		if(getPara("is_out_view").equals("0")){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//小写的mm表示的是分钟  
			java.util.Date date=null;
			try {
				date=sdf.parse(getPara("open_time"));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				setSessionAttr("message", "保存失败，请检查！");
				setAttr("article", article);
				render(BASE_PATH+"new.jsp");
				return;
			}
			Date now=new Date();
			if(date.before(now)){
				setSessionAttr("message", "保存失败，开放时间应大于当前时间！");
				setAttr("article", article);
				render(BASE_PATH+"new.jsp");
				return;
			}
		}
		article.set("submit_time", new Date());
		try {
			article.save();
			setSessionAttr("message", "保存成功！");
			redirect("/content/my");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setSessionAttr("message", "保存失败，请检查！");
			setAttr("article", article);
			render(BASE_PATH+"new.jsp");

		}
		
	}
}
