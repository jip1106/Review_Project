package admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import admin.model.service.MemberAdminService;
import member.model.vo.Member;

/**
 * Servlet implementation class WarningCountOverThreeMemberServlet
 */
@WebServlet("/viewWarningCountOverThree.do")
public class WarningCountOverThreeMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WarningCountOverThreeMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//경고횟수 많은 회원 뽑아오기
		request.setCharacterEncoding("utf-8");
		response.setContentType("aplication/json; charset=utf-8");
		
		MemberAdminService maservice = new MemberAdminService();
		
		
		ArrayList<Member> list = maservice.viewWarningCountOverThree();
	
		
		JSONObject job = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(Member member : list){
			JSONObject j = new JSONObject();
			j.put("id", URLEncoder.encode(member.getId(),"UTF-8"));
			j.put("name", URLEncoder.encode(member.getName(),"UTF-8"));
			j.put("email", URLEncoder.encode(member.getEmail(),"UTF-8"));
			j.put("warningCount", member.getWarningCount());
						
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
