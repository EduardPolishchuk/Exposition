<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" isErrorPage="true"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>



<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ERROR</title>
</head>
    <body>
    <jsp:include page="/common/header.jsp"/>
        <h2>
           Error<br/>
            <i>Oops, something went wrong...<%= exception %>
                <a href="${pageContext.request.contextPath}/">Back.</a>
            </i>
        </h2>


       <br>

    </body>
</html>