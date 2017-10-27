package memberComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

import memberComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;
import memberComplainComment.model.vo.ComplainComment;

/**
 * Servlet implementation class ComplainDetailServlet
 */
@WebServlet("/cdetail")
public class ComplainDetailServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            //신고게시판 게시글 상세보기 서블릿
            request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            
            //바뀐부분
            int index = 0; //신고 게시판에서 글 제목 누른경우
            
            String id = request.getParameter("id");
            
            
            if(request.getParameter("index")!=null){
               index = Integer.parseInt(request.getParameter("index"));//마이 페이지에서 내가쓴 신고글 글 제목 눌렀을 때
            }
            
            int bnum = Integer.parseInt(request.getParameter("bnum"));
            int Page = Integer.parseInt(request.getParameter("Page"));
            
            ComplainBoardService cbservice = new ComplainBoardService();
            
            //조회수 증가 처리
            cbservice.addReadCount(bnum);
            
            ComplainBoard Complainboard = cbservice.selectBoard(bnum,id);
            
            ArrayList<ComplainComment> list = cbservice.selectCommentList(bnum);
            
           
            System.out.println(list);
                        
            //바뀐 부분
            if(Complainboard != null){
               RequestDispatcher view = request.getRequestDispatcher("views/complainboard/complainboardDetail.jsp");
               
               request.setAttribute("Complainboard", Complainboard);
               request.setAttribute("Page", Page);
               request.setAttribute("index", index);
               request.setAttribute("commentList", list);
               request.setAttribute("id", id);
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