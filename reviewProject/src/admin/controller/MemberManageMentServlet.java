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
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberManageMentServlet
 */
@WebServlet("/mlist")
public class MemberManageMentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberManageMentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");		
		RequestDispatcher view = null;
		MemberAdminService mservice = new MemberAdminService();
		
		int listCount = 0;//그냥 보여줄때랑, 검색했을 때에 따라 달라서 0으로 초기값
		
		String searchValue = null;
	
		if(request.getParameter("searchValue")!=null){	//검색한 경우
			searchValue = request.getParameter("searchValue");
			System.out.println(searchValue);
		}		
		if(searchValue==null){ //처음 회원 관리 눌렀을 때 전체 회원수
			listCount = mservice.getMemberCount();
		}else{ //검색 했을때 검색 결과 나온 회원 수
			listCount = mservice.getSearchByIdListCount(request.getParameter("searchValue"));
		}
		
		int currentPage = 1;
		int limit = 10;
				
		if(request.getParameter("page")!=null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int maxPage = (int)((double)(listCount)/limit+0.9); //총 페이지 수
		
		int startPage = ((int)((double)currentPage/limit + 0.9)-1)*limit +1 ;
		
		int endPage = startPage + limit-1;
		
		if(maxPage<endPage){
			endPage = maxPage;
		}		
		
		ArrayList<Member> mlist = null;
		
		if(searchValue==null){
			mlist = mservice.viewAllMember(currentPage, limit);
		}else{
			mlist = mservice.viewSearchIdMember(request.getParameter("searchValue"), currentPage, limit);
		}
				
				
		if(mlist!=null){
			view = request.getRequestDispatcher("views/admin/memberManagement/memberManagement.jsp");
			
			request.setAttribute("list", mlist);
			request.setAttribute("page", currentPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("limit", limit);
			request.setAttribute("searchValue", searchValue);
			
		
			
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
