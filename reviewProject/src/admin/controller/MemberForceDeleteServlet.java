package admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.MemberAdminService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberForceDeleteServlet
 */
@WebServlet("/forceDelete")
public class MemberForceDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberForceDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id");
		MemberAdminService maservice = new MemberAdminService();
		String email = request.getParameter("email");
		
		int currentPage = 1;
		if(request.getParameter("page")!=null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int listCount = maservice.getMemberCount();
		int limit = 10;
		int maxPage = (int)((double)(listCount)/limit+0.9);
		int startPage = ((int)((double)currentPage/limit+0.9)-1)*limit+1;

		int endPage = startPage + limit-1;
		
		if(maxPage<endPage){
			endPage = maxPage;
		}		
		
		maservice.insertExileMember(email);
		int result = maservice.deleteMember(id);
				
		ArrayList<Member> list = maservice.viewAllMember(currentPage,limit);
		RequestDispatcher view = null;
		System.out.println(result);
		
		
		if(result>0){
			
			view = request.getRequestDispatcher("views/admin/memberManagement/memberManagement.jsp");
			request.setAttribute("list", list);
			request.setAttribute("page", currentPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("limit", limit);
			
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
