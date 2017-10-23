package memberComplainComment.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import memberComplainComment.model.service.ComplainCommentService;
import memberComplainComment.model.vo.ComplainComment;


/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/cm")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		
		
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		
		ComplainCommentService bservice = new ComplainCommentService();

		
		
		ArrayList<ComplainComment> list = new ArrayList<ComplainComment>();
		JSONObject job = new JSONObject();
		JSONArray jarr = new JSONArray();

		for(ComplainComment ComplainComment : list){
			JSONObject j = new JSONObject();
			j.put(key, value)
			j.put("username", URLEncoder.encode(user.getUserName(), "UTF-8"));


			
			
			jarr.add(j);
		}		
		
		job.put("list", jarr);
		System.out.println("job : " + job.toJSONString());
		
		PrintWriter pw = response.getWriter();
		pw.print(job.toJSONString());
		pw.flush();
		pw.close();


		
		//원글 조회
		Board originBoard = bservice.selectBoard(bnum);
		
		//댓글 객체 생성, 값 기록
		ComplainBoard replyBoard = new ComplainBoard();
		replyBoard.setBoardContent(bcontent);
		replyBoard.setBoardTitle(btitle);
		replyBoard.setBoardWriter(bwriter);
		replyBoard.setBoardLevel(originBoard.getBoardLevel() + 1);
		replyBoard.setBoardRef(originBoard.getBoardRef());
		if(replyBoard.getBoardLevel() == 2)
			replyBoard.setBoardReplyRef(originBoard.getBoardNum());
		replyBoard.setBoardReplySeq(1);
		
		//같은 레벨의 기존 댓글의 seq 1증가 처리함
		bservice.updateReplySeq(replyBoard);
		request.setAttribute("list", list);
		//댓글 등록 처리
		int result = bservice.insertReply(originBoard, replyBoard);
		
		if(result > 0){
			response.sendRedirect("/first/blist?page=" + currentPage);
		}else{
			RequestDispatcher view = request.getRequestDispatcher("views/board/boardError.jsp");
			request.setAttribute("message", "댓글 달기 실패!");
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
