package memberComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import memberComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;

/**
 * Servlet implementation class ComplainListServlet
 */
@WebServlet("/clist")
public class ComplainListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); 
		int Page = 1;
		int limit = 5;
		
		
		if(request.getParameter("Page")!=null){
			Page=Integer.parseInt(request.getParameter("Page"));
		}
		System.out.println("안녕하세요");
		ComplainBoardService Complainbordservice = new ComplainBoardService();
		
		int listCount = Complainbordservice.getListCount();
		
		ArrayList<ComplainBoard> list = Complainbordservice.selectList(Page, limit);
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = ((int)((double)Page / limit + 0.9) - 1) * limit + 1;
		
		int endPage = startPage + limit - 1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("views/complainboard/complainboard.jsp");
			
			request.setAttribute("list", list);
			request.setAttribute("Page", Page);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			view.forward(request, response);
			
		}
		else
			System.out.println("헤헤.. 내가 나와버림");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
