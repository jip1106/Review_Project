package memberComplainBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberComplainBoard.model.service.ComplainBoardService;
//바뀐 부분
/**
 * Servlet implementation class ComplainDeleteServlet
 */
@WebServlet("/cdelete")
public class ComplainDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		//바뀐부분
		int location=Integer.parseInt(request.getParameter("location")); //0일때는 신고게시판 삭제, 1일때는 마이페이지에서 삭제
		
		int index= 0;	
		
		if(location==1){
			index = Integer.parseInt(request.getParameter("index"));
		}
		
		int bnum = Integer.parseInt(request.getParameter("bnum"));

		
		//바뀐부분
		if (new ComplainBoardService().deleteBoard(bnum) > 0) {
			if(location ==0 && index==0){ //신고게시판에서 삭제
				response.sendRedirect("/review/clist?page=1");
			}else if(location==1 && index==1){//마이페이지에서 삭제
				response.sendRedirect("/review/views/mypage/member/mycomplainwrite.jsp");
			}
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
