<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sdf.format(date);
%>
<tr>
	<th width="100">No</th>
	<td id="t1" width="100">${one.cID}</td>
</tr>
<tr>
	<th>차 번호</th>
	<td id="t2">${one.cNum }</td>
</tr>
<tr>
	<th>들어온 시간</th>
	<td id="t3">${one.inTime}</td>
</tr>
<tr>
	<th>나가는 시간</th>
	<td id="t4"><%=today %></td>
</tr>
<tr>
	<th>금액</th>
	<td id="t5">${price}</td>
</tr>