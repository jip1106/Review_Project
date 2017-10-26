package memberSharedComment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sun.glass.ui.Pixels.Format;
import com.sun.org.apache.xerces.internal.util.URI;

import memberSharedComment.model.service.SharedCommentService;
import memberSharedComment.model.vo.SharedComment;

/**
 * Servlet implementation class SharedCommentInsertServlet
 */
@WebServlet("/sminsert.do")
public class SharedCommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedCommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		String content = request.getParameter("content");
		String id = request.getParameter("id");
				
		SharedCommentService service = new SharedCommentService();
		
		int result = service.sharedCommentInsert(no, id, content);
		
		ArrayList<SharedComment> list = null;
		
		if(result > 0) 
			list = service.sharedCommentList(no);

		System.out.println(result);
		JSONObject job = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(SharedComment c:list) {
			JSONObject j = new JSONObject(); 
		j.put("commentNo", c.getCommentNo());
		j.put("postingNo", c.getPostingNo());
		j.put("userId", URLEncoder.encode(c.getId(),"UTF-8"));
		j.put("content",(c.getCommentContent().replaceAll("\n", "<br>")));
		//j.put("commentDate", c.getCommentStringDate());
		
		//Date from = new Date(); 
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = transFormat.format(c.getCommentDate());
		j.put("timePosted", to);
		
		jarr.add(j);

		}
		
		job.put("list", jarr);
		PrintWriter pw = response.getWriter();
		pw.print(job.toJSONString());
		pw.flush();
		pw.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
