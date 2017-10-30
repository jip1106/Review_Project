package memberComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oracle.jrockit.jfr.RequestableEvent;

import jdk.nashorn.internal.ir.RuntimeNode.Request;
import memberComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;
import sun.rmi.server.Dispatcher;

/**
 * Servlet implementation class ComplainSearchServlet
 */
@WebServlet("/csearch")
public class ComplainSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 검색
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		int Page = 1;
		int limit = 10;
		ArrayList<ComplainBoard> list = null;
		ComplainBoardService Complainbordservice = new ComplainBoardService();
		
		if(request.getParameter("Page")!=null){
			Page=Integer.parseInt(request.getParameter("Page"));
		}
		
		String searchValue = request.getParameter("searchValue");
		String searchKeyWord = request.getParameter("searchKeyWord");
		
		int listCount = Complainbordservice.getListCount();
		int SearchCount = Complainbordservice.getSearchCount(searchValue,searchKeyWord);
		
		
		if( request.getParameter("searchKeyWord") !=null){
			list = Complainbordservice.searchList(Page, limit,searchValue,searchKeyWord);
			System.out.println("sv : "+searchValue);
			
		}else{
			list = Complainbordservice.selectList(Page, limit);
			
		}


		
		int maxPage = (int)((double)SearchCount / limit + 0.9);
		int startPage = ((int)((double)Page / limit + 0.9) - 1) * limit + 1;
		
		int endPage = startPage + limit - 1;
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		System.out.println("list="+list);
		if(list != null){
			
			view = request.getRequestDispatcher("views/complainboard/complainboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("Page", Page);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("SearchCount", SearchCount);
			request.setAttribute("searchValue", searchValue);
			request.setAttribute("searchKeyWord", searchKeyWord);
			view.forward(request, response);
			
		}
		else
			System.out.println("헤헤.. 내가 나와버림...");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
